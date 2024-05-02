import 'package:chat_app/core/common/buttons.dart';
import 'package:chat_app/core/common/util_widgets.dart';
import 'package:chat_app/core/common/widgets/app_textfield.dart';
import 'package:chat_app/core/constants/app_text_styles.dart';
import 'package:chat_app/core/constants/colors.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/services/injection_container.dart';
import 'package:chat_app/core/theme/cubit/theme_cubit.dart';
import 'package:chat_app/core/utils/nav_utils.dart';
import 'package:chat_app/core/utils/utils.dart';
import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/auth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //
  final nameCntr = TextEditingController(text: slAuth.user!.name);
  final emailCntr = TextEditingController(text: slAuth.user!.email);
  final passwordCntr = TextEditingController(text: slAuth.user!.password);
  final formKey = GlobalKey<FormState>();

  bool isEdit = false;
  bool isObscure = true;

  @override
  void dispose() {
    nameCntr.dispose();
    emailCntr.dispose();
    passwordCntr.dispose();
    super.dispose();
  }

  void showLogoutDialog() {
    AppDialog.show(
      context,
      title: 'Logout?',
      content: 'Are you sure that you want to logout from the app?',
      actions: [
        ElevatedBtn('No', () => NavUtils.back(context)),
        OutlinedBtn(
          'Yes',
          () => context.read<AuthBloc>().add(const AuthSignOut()),
        ),
      ],
    );
  }

  void saveEdits() {
    if (formKey.currentState!.validate()) {
      final editedUser = UserModel(
        id: slAuth.user!.id,
        email: emailCntr.text.trim(),
        password: passwordCntr.text.trim(),
        name: nameCntr.text.trim(),
      );

      context.read<AuthBloc>().add(AuthUserEdit(editedUser));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text('My Profile')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                StatefulBuilder(
                  builder: (_, setValue) {
                    return Form(
                      key: formKey,
                      child: BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthFailure) {
                            AppSnackbar.error(context, state.message);
                          } else if (state is AuthSuccess) {
                            AppSnackbar.success(
                              context,
                              'User details updated!',
                            );
                            setValue(() => isEdit = false);
                          }
                        },
                        builder: (context, state) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                // - - - - - - - - - - - - NAME
                                AppTextField(
                                  nameCntr,
                                  'Name',
                                  readOnly: !isEdit,
                                  validator: Validators.notEmpty,
                                ),
                                // - - - - - - - - - - - - EMAIL
                                AppTextField(
                                  emailCntr,
                                  'Email',
                                  readOnly: !isEdit,
                                  validator: Validators.email,
                                ),
                                // - - - - - - - - - - - - PASSWORD
                                AppTextField(
                                  passwordCntr,
                                  'Password',
                                  isObscure: isObscure,
                                  readOnly: !isEdit,
                                  validator: Validators.notEmpty,
                                  suffixIcon: isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  suffixFun: () =>
                                      setValue(() => isObscure = !isObscure),
                                ),

                                // - - - - - - - - - - - - EDIT & SUBMIT BUTTONS
                                if (isEdit)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedBtn('Cancel', () {
                                          setValue(() => isEdit = false);
                                          nameCntr.text = slAuth.user!.name;
                                          emailCntr.text = slAuth.user!.email;
                                          passwordCntr.text =
                                              slAuth.user!.password;
                                        }),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: ElevatedBtn('Save', saveEdits),
                                      ),
                                    ],
                                  )
                                else
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextBtn(
                                      'Edit',
                                      () => setValue(() => isEdit = true),
                                      icon: Icons.edit,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                const Spacer(),
                const Divider(height: 30),

                // - - - - - - - - - - - - - - - - THEME SWITCHER
                Row(
                  children: [
                    BlocBuilder<ThemeCubit, bool>(
                      builder: (context, state) {
                        return Expanded(
                          flex: 4,
                          child: ListTile(
                            onTap: () => context.theme.toggleTheme(),
                            leading: const Icon(Icons.auto_awesome_rounded),
                            trailing: ThemeSwitch(
                              value: slTheme.isDark,
                              onTap: () => context.theme.toggleTheme(),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 15),

                    // - - - - - - - - - - - - - - - - LOGOUT
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSignedOut) {
                          NavUtils.offAll(context, const SignInScreen());
                          AppSnackbar.success(
                            context,
                            'Signed out successfully!',
                          );
                        }
                      },
                      child: Expanded(
                        flex: 6,
                        child: ListTile(
                          onTap: showLogoutDialog,
                          tileColor: AppColors.danger.withAlpha(50),
                          leading: const Icon(
                            Icons.exit_to_app,
                            color: AppColors.danger,
                          ),
                          title: Text(
                            'Sign Out',
                            style: AppTStyles.primary
                                .copyWith(color: AppColors.danger),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

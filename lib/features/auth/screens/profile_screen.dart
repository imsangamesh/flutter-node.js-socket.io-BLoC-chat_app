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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            //
            AppTextField(nameCntr, 'Name', readOnly: true),
            //
            AppTextField(emailCntr, 'Email', readOnly: true),
            //
            StatefulBuilder(
              builder: (_, setValue) {
                return AppTextField(
                  passwordCntr,
                  'Password',
                  isObscure: isObscure,
                  readOnly: true,
                  suffixIcon:
                      isObscure ? Icons.visibility : Icons.visibility_off,
                  suffixFun: () => setValue(() => isObscure = !isObscure),
                );
              },
            ),
            const Spacer(),

            const Divider(),
            const SizedBox(height: 10),

            // ----------------------------------- THEME SWITCHER
            BlocBuilder<ThemeCubit, bool>(
              builder: (context, state) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () => context.theme.toggleTheme(),
                      leading: const Icon(Icons.auto_awesome_rounded),
                      title: Text(
                        slTheme.isDark
                            ? 'Lively & Nightly nights!'
                            : 'Light & Bright mood!',
                        style: AppTStyles.primary,
                      ),
                      trailing: ThemeSwitch(
                        value: slTheme.isDark,
                        onTap: () => context.theme.toggleTheme(),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 15),

            // ----------------------------------- LOGOUT
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  NavUtils.offAll(context, const SignInScreen());
                  AppSnackbar.success(context, 'Logout Successful!');
                }
              },
              child: ListTile(
                onTap: showLogoutDialog,
                tileColor: AppColors.danger.withAlpha(50),
                leading: const Icon(Icons.exit_to_app, color: AppColors.danger),
                title: Text(
                  'Logout',
                  style: AppTStyles.primary.copyWith(color: AppColors.danger),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

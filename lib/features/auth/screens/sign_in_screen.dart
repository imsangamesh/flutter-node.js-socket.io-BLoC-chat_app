import 'package:chat_app/core/common/buttons.dart';
import 'package:chat_app/core/common/widgets/app_textfield.dart';
import 'package:chat_app/core/constants/app_text_styles.dart';
import 'package:chat_app/core/constants/images.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/utils/nav_utils.dart';
import 'package:chat_app/core/utils/utils.dart';
import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //
  final emailCntr = TextEditingController();
  final passwordCntr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  @override
  void dispose() {
    emailCntr.dispose();
    passwordCntr.dispose();
    super.dispose();
  }

  void signIn(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            AuthSignIn(
              email: emailCntr.text.trim(),
              password: passwordCntr.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (_, state) {
        if (state is AuthFailure) {
          AppSnackbar.error(context, state.message);
        } else if (state is AuthSuccess) {
          NavUtils.offAll(context, const ChatScreen());
          AppSnackbar.success(context, 'Signed In successfully!');
        }
      },
      builder: (context, state) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(AppImages.logo, width: 40),
                            const SizedBox(width: 10),
                            Text('Sign In', style: AppTStyles.large),
                          ],
                        ),
                        const SizedBox(height: 20),

                        /// -------------------- `EMAIL`
                        AppTextField(
                          emailCntr,
                          'Email',
                          validator: Validators.email,
                        ),

                        /// -------------------- `PASSWORD`
                        StatefulBuilder(
                          builder: (_, setValue) {
                            return AppTextField(
                              passwordCntr,
                              'Password',
                              isObscure: isObscure,
                              validator: Validators.notEmpty,
                              suffixIcon: isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              suffixFun: () =>
                                  setValue(() => isObscure = !isObscure),
                            );
                          },
                        ),

                        /// -------------------- `SUBMIT BUTTON`
                        SizedBox(
                          width: context.w,
                          child: ElevatedBtn(
                            'Sign In',
                            () => signIn(context),
                            loading: state is AuthLoading,
                          ),
                        ),
                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: AppTStyles.caption,
                            ),
                            TextButton(
                              onPressed: () => NavUtils.back(context),
                              child: const Text('Sign Up'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:chat_app/core/common/buttons.dart';
import 'package:chat_app/core/common/widgets/app_textfield.dart';
import 'package:chat_app/core/constants/app_text_styles.dart';
import 'package:chat_app/core/constants/images.dart';
import 'package:chat_app/core/extensions/context_extension.dart';
import 'package:chat_app/core/services/injection_container.dart';
import 'package:chat_app/core/utils/nav_utils.dart';
import 'package:chat_app/core/utils/utils.dart';
import 'package:chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:chat_app/features/auth/screens/sign_in_screen.dart';
import 'package:chat_app/features/chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //
  final nameCntr = TextEditingController();
  final emailCntr = TextEditingController();
  final passwordCntr = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  @override
  void dispose() {
    nameCntr.dispose();
    emailCntr.dispose();
    passwordCntr.dispose();
    super.dispose();
  }

  void signUp(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final newUser = UserModel(
        id: slUuid.v1(),
        email: emailCntr.text.trim(),
        password: passwordCntr.text.trim(),
        name: nameCntr.text.trim(),
      );

      context.read<AuthBloc>().add(AuthSignUp(newUser));
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
          AppSnackbar.success(context, 'Signed Up successfully!');
        }
      },
      builder: (_, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppImages.logo, width: 40),
                        const SizedBox(width: 10),
                        Text('Sign Up', style: AppTStyles.large),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// -------------------- `NAME`
                    AppTextField(
                      nameCntr,
                      'Name',
                      validator: Validators.notEmpty,
                    ),

                    /// -------------------- `EMAIL`
                    AppTextField(
                      emailCntr,
                      'Email',
                      inputType: TextInputType.emailAddress,
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
                        'Sign Up',
                        () => signUp(context),
                        loading: state is AuthLoading,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: AppTStyles.caption,
                        ),
                        TextButton(
                          onPressed: () => NavUtils.to(
                            context,
                            const SignInScreen(),
                          ),
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

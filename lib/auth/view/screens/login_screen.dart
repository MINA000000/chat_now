
import 'package:chat_now/auth/view_model/auth_states.dart';
import 'package:chat_now/auth/view_model/auth_view_model.dart';
import 'package:chat_now/utils/ui_utils.dart';
import 'package:chat_now/validators/app_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_now/auth/view/screens/register_screen.dart';
import 'package:chat_now/home_screen.dart';
import 'package:chat_now/auth/view/widgets/default_elevated_button.dart';
import 'package:chat_now/auth/view/widgets/default_text_form.dart';

class LoginScreen extends StatelessWidget {
  static final String route = '/login-screen';
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextForm(
                hint: 'Enter your email',
                controller: emailController,
                validator: (email) {
                  if (email == null || email.trim().length < 5) {
                    return 'Email should contain at least 5 characters';
                  } else if (!AppValidators.isEmail(email)) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              DefaultTextForm(
                hint: 'Enter your password',
                controller: passwordController,
                validator: (password) {
                  if (password == null || password.trim().length < 6) {
                    return 'Password should contain at least 6 characters';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 32),
              BlocListener<AuthViewModel, AuthState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    UiUtils.showLoading(context);
                  } else if (state is LoginError) {
                    UiUtils.hideLoading(context);
                    UiUtils.showMessage(state.message, Colors.red);
                  } else if (state is LoginSuccess) {
                    UiUtils.hideLoading(context);
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(HomeScreen.route);
                  }
                },
                child: DefaultElevatedButton(
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthViewModel>().login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  text: 'Login',
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(RegisterScreen.route);
                },
                child: Text(
                  'Don\'t have an account?',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

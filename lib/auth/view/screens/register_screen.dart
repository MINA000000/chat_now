import 'package:chat_now/auth/view_model/auth_states.dart';
import 'package:chat_now/utils/ui_utils.dart';
import 'package:chat_now/validators/app_validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:chat_now/auth/view/screens/login_screen.dart';
import 'package:chat_now/firebase_functions.dart';
import 'package:chat_now/home_screen.dart';
import 'package:chat_now/auth/models/user_model.dart';
import 'package:chat_now/auth/view_model/auth_view_model.dart';
import 'package:chat_now/auth/view/widgets/default_elevated_button.dart';
import 'package:chat_now/auth/view/widgets/default_text_form.dart';

class RegisterScreen extends StatelessWidget {
  static const String route = '/Register-screen';
  RegisterScreen({super.key});

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Regiser',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextForm(
                hint: 'Enter your name',
                controller: nameController,
                validator: (name) {
                  if (name == null || name.trim().isEmpty) {
                    return 'name should not be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              DefaultTextForm(
                hint: 'Enter your password again',
                controller: confirmPasswordController,
                validator: (password) {
                  if (password == null ||
                      password.trim().compareTo(
                            passwordController.text.trim(),
                          ) !=
                          0) {
                    return 'Password and confirm password should be the same';
                  }
                  return null;
                },
                isPassword: true,
              ),
              SizedBox(height: 32),
              BlocListener<AuthViewModel, AuthState>(
                listener: (context, state) {
                  if (state is RegisterLoading) {
                    UiUtils.showLoading(context);
                  } else if (state is RegisterError) {
                    UiUtils.hideLoading(context);
                    UiUtils.showMessage(state.message, Colors.red);
                  } else if (state is RegisterSuccess) {
                    UiUtils.hideLoading(context);
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(HomeScreen.route);
                  }
                },
                child: DefaultElevatedButton(
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthViewModel>().register(
                        email: emailController.text,
                        password: passwordController.text,
                        name: nameController.text,
                      );
                    }
                  },
                  text: 'Register',
                ),
              ),
              SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(LoginScreen.route);
                },
                child: Text(
                  'Have an account?',
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

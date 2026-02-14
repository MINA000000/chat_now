import 'package:chat_now/auth/view/screens/login_screen.dart';
import 'package:chat_now/auth/view_model/auth_states.dart';
import 'package:chat_now/auth/view_model/auth_view_model.dart';
import 'package:chat_now/home_screen.dart';
import 'package:chat_now/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String route = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AuthViewModel>().getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewModel, AuthState>(
      listener: (context, state) {
        if(state is IsLoggedIn){
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        }
        else if(state is IsLoggedOut){
          Navigator.pushReplacementNamed(context, LoginScreen.route);
        }
      },
      child: const Scaffold(body: LoadingIndicator()),
    );
  }
}

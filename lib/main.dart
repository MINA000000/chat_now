import 'package:chat_now/auth/login_screen.dart';
import 'package:chat_now/auth/register_screen.dart';
import 'package:chat_now/firebase_options.dart';
import 'package:chat_now/home_screen.dart';
import 'package:chat_now/providers/tasks_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const ChatNow(),
    ),
  );
}

class ChatNow extends StatelessWidget {
  const ChatNow({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      routes: {
        HomeScreen.route: (_) => HomeScreen(),
        LoginScreen.route: (_) => LoginScreen(),
        RegisterScreen.route: (_) => RegisterScreen(),
      },
      initialRoute: LoginScreen.route,
    );
  }
}

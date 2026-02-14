import 'package:chat_now/auth/view/screens/login_screen.dart';
import 'package:chat_now/auth/view/screens/register_screen.dart';
import 'package:chat_now/chat/view/screens/chat_screen.dart';
import 'package:chat_now/firebase_options.dart';
import 'package:chat_now/home_screen.dart';
import 'package:chat_now/auth/view_model/auth_view_model.dart';
import 'package:chat_now/rooms/view/screens/create_room_screen.dart';
import 'package:chat_now/shared/app_theme.dart';
import 'package:chat_now/splash_screen.dart';
// import 'package:chat_now/shared/my_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    BlocProvider(create: (context) => AuthViewModel(), child: const ChatNow()),
  );
}

class ChatNow extends StatelessWidget {
  const ChatNow({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.route: (_) => HomeScreen(),
        LoginScreen.route: (_) => LoginScreen(),
        RegisterScreen.route: (_) => RegisterScreen(),
        CreateRoomScreen.route: (_) => CreateRoomScreen(),
        ChatScreen.route: (_) => ChatScreen(),
        SplashScreen.route:(_)=>SplashScreen()
      },
      initialRoute: SplashScreen.route,
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
    );
  }
}

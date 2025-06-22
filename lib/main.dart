import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_helper/views/login_view.dart';
import 'package:notes_helper/views/logout_view.dart';
import 'package:notes_helper/views/register_view.dart';
import 'package:notes_helper/views/verify_email_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // useMaterial3: true,
    ),
    home: const HomePage(),
    routes: {
      "/login/": (context) => const LoginView(),
      "/register/": (context) => const RegisterView(),
      '/home/': (context) => const HomePage(),
      "/verify-email/": (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                return LoginView();
              } else if (!user.emailVerified) {
                print("You need to verify your email");
                return const VerifyEmailView();
              } else if (user.emailVerified) {
                print("Email Verified");
                return const LogoutView();
              }
            default:
              return const CircularProgressIndicator();
          }

          return const Text("Done");
        },
      ),
    );
  }
}

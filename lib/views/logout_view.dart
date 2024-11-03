import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        Text("Logged in User ${user?.email}"),
        ElevatedButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil("/login/", (route) => false);
          },
          child: const Text("Logout"),
        ),
      ],
    );
  }
}

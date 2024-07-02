import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text("Authentication x FireBase", style: TextStyle(color: Colors.grey.shade200),),
        actions: [
          IconButton(
            tooltip: "sign out",
            onPressed: signUserOut,
            icon: Icon(Icons.logout_outlined, color: Colors.grey.shade200,),
          ),
        ],
      ),
      body: Center(
        child: Text("Logged in as: ${user?.email}", style: const TextStyle(fontSize: 18),),
      ),
    );
  }
}

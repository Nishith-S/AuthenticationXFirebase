import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                const SizedBox(
                  height: 55,
                ),
                const Icon(
                  Icons.lock,
                  size: 95,
                ),

                //Welcome back you've been missed
                const SizedBox(
                  height: 45,
                ),
                Text(
                  "Welcome back you've been missed",
                  style: TextStyle(fontSize: 17, color: Colors.grey.shade800),
                ),

                //TextField username
                const SizedBox(
                  height: 25,
                ),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                //TextField password
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                //Forget password
                const SizedBox(
                  height: 25,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Forget password?"),
                    ],
                  ),
                ),

                //Sign-in button
                const SizedBox(
                  height: 35,
                ),
                MyButton(
                  onTap: signUserIn,
                ),

                //or continue with
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const Text(
                        "or continue with",
                        style: TextStyle(fontSize: 16.8),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                // google + apple
                const SizedBox(
                  height: 65,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SquareTile(
                      imagePath: 'assets/images/google.png',
                    ),
                    SquareTile(
                      imagePath: 'assets/images/apple.png',
                    ),
                  ],
                ),

                //not a member? register now
                const SizedBox(
                  height: 50,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?", style: TextStyle(fontSize: 17),),
                    Text(" Register now" , style: TextStyle(fontSize: 17,color: Colors.blue, fontWeight: FontWeight.bold),),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
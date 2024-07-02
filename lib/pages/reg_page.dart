import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class RegistrationPage extends StatefulWidget {
  final Function()? onTap;

  const RegistrationPage({
    super.key,
    required this.onTap
  });

  @override
  State<RegistrationPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformPasswordController =
      TextEditingController();

  bool hidePass = true;

  void errorMessageToUser(String name) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.redAccent,),
                Text(" Error"),
              ],
            ),
            content: Text(name, style: const TextStyle(fontSize: 18),),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Ok"),),
            ],
          );
        });
  }

  void signUserUp() async {
    //show dialog for loading
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      if(_passwordController.text == _conformPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        errorMessageToUser("Password don't match!");
      }
      //pop the CircularProgressIndicator
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      errorMessageToUser(e.code);
    }
  }

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
                  size: 65,
                ),

                //Welcome back you've been missed
                const SizedBox(
                  height: 35,
                ),
                Text(
                  "Create an account",
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
                  obscureText: hidePass,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePass = !hidePass;
                      });
                    },
                    icon: Icon(hidePass ? Icons.visibility_off : Icons.visibility),
                  ),
                ),

                //TextField conform password
                const SizedBox(
                  height: 15,
                ),
                MyTextField(
                  controller: _conformPasswordController,
                  hintText: 'Conform Password',
                  obscureText: hidePass,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePass = !hidePass;
                      });
                    },
                    icon: Icon(hidePass ? Icons.visibility_off : Icons.visibility),
                  ),
                ),

                //Sign-in button
                const SizedBox(
                  height: 35,
                ),
                MyButton(
                  text: "Sign up",
                  onTap: signUserUp,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: 'assets/images/google.png',
                    ),
                    SizedBox(width: 30,),
                    SquareTile(
                      imagePath: 'assets/images/apple.png',
                    ),
                  ],
                ),

                //not a member? register now
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Login now",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
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

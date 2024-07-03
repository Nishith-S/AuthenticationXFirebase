import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class LogInPage extends StatefulWidget {
  final Function()? onTap;
  const LogInPage({super.key, required this.onTap});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
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

  void signUserIn() async {
    //show dialog for loading
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      //pop the CircularProgressIndicator
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      errorMessageToUser(e.code);
    }
  }

  //google sign-in
  void _handelGoogleSignIn() async {
    try {
      GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await FirebaseAuth.instance.signInWithProvider(googleAuthProvider);
    } catch(e) {
      print(e);
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
                  text: "Sign in",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      message: "Sign in with google",
                      onTap: _handelGoogleSignIn,
                      imagePath: 'assets/images/google.png',
                    ),
                    //const SizedBox(width: 30,),
                    // SquareTile(
                    //   onTap: () {},
                    //   imagePath: 'assets/images/twitter.png',
                    // ),
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
                      "Not a member?",
                      style: TextStyle(fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        " Register now",
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

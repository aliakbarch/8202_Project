import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipadu_8202/components/my_button.dart';
import 'package:sipadu_8202/components/my_textfield.dart';
import 'package:sipadu_8202/components/square_tile.dart';
import 'package:sipadu_8202/screens/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isHover = false;

  //Sign in User
  signInUser() async{

    //Loading
    showDialog(context: context,
        builder: (context){
      return const Center(
        child: CircularProgressIndicator());
      }
    );

    //Proses Sign In
    try {
      //Selesai Loading
      Navigator.pop(context);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //if Error occured
    } on FirebaseAuthException catch (e) {
      //Kasih tau apa errornya
      showErrorMessage(e.code);
    }
  }

  //Error Email
  void showErrorMessage(String message){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.green),
              )
            )
          );
        },
    );
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25.0),

                //Logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),

                const SizedBox(height: 25.0),

                //Welcome Back
                const Text('Silahkan Login Terlebih Dahulu',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    )
                ),

                const SizedBox(
                    height: 25.0,
                ),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10.0),

                //Password textfield
                SizedBox(
                  width: 500.0,
                  height: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      onSubmitted: (_)=>signInUser(),
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        fillColor: Colors.white70,
                        filled: true,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                //forgot password
                SizedBox(
                  width: 500.0,
                  height: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Lupa Password?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),

                //sign in button
                MyButton(
                  text: 'Sign In',
                  onTap: signInUser,
                ),

                const SizedBox(height: 25.0),

                //continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: const [
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.black54,
                      ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Sign In Dengan'),
                      ),
                      Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.black54,
                          ))
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //google sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google1.png'
                    ),

                    const SizedBox(width: 25.0)
                  ],
                ),

                const SizedBox(height: 25),

                //register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum Daftar?'),

                    const SizedBox(width: 4),

                    AnimatedContainer(
                      padding: EdgeInsets.only(
                          top: (isHover) ? 10 : 12, bottom: !(isHover) ? 10 : 12),
                      duration: Duration(milliseconds: 200),
                      child: InkWell(
                        onHover: (val){
                          setState(() {
                            isHover = val;
                          });
                        },
                        onTap: widget.onTap,
                        child: const Text(
                          'Registrasi Disini',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )

              ],),
          ),
        )

      ),
    );
  }
}
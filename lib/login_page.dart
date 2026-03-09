import 'package:final_project/components/button_comp.dart';
import 'package:final_project/components/textfield_comp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:email_validator/email_validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controller
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signUserIn() async{
    try {
      final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home_page');
    } on FirebaseAuthException catch (e) {

      setState(() => errorMessage = e.message);
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                //logo
                const SizedBox(height: 20,),
                Image.asset(
                  'assets/images/campusdexlogo.png',
                  height: 120,),
          
          
                //KU CAMPUS TEXT
                const SizedBox(height: 40,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'KU ',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        ),
                    ),
                    Text(
                      'Campus Dex',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
          
          
                //email username textfield
                TextfieldComp(
                  controller: emailController,
                  hintText: 'Email',
                  isPassword: false,
                  errorText: errorMessage != null ? "" : null, // แสดงสีแดงถ้าผิด
                ),
                const SizedBox(height: 30,),
          
          
                //password textfield
                TextfieldComp(
                  controller: passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  errorText: errorMessage,
                ),
                const SizedBox(height: 15,),
          
                //forgot password
          
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password?'),
                    ],
                  ),
                ),
          
                SizedBox(height: 30,),
                //signin button
            
                ButtonComp(
                  onTap: signUserIn,
                  text: 'Sign In',
                ),
                const SizedBox(height: 15,),
                
          
                //goto signup
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not have account?  '),
                      const SizedBox(height: 5,),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/signup_page'),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold,),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                //cont with text
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.grey,
                      ),
                      ),
                      Padding(padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      ),
                      Expanded(child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                      ),
                    ],
                  ),),
                    const SizedBox(height: 20,),
          
          
                  //  google signin 
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: GoogleSignInButton(
                      
                      clientId: "95080321614-hv8qvfp9hsmkor8a1ro596rcpfjq33me.apps.googleusercontent.com", 
                      loadingIndicator: const CircularProgressIndicator(), // แสดงตัวหมุนขณะโหลด
                      onSignedIn: (userCredential) {
                        Navigator.pushReplacementNamed(context, '/home_page');
                      },
                    ),
                  ),
                  
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
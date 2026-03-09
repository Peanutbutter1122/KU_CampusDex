import 'package:final_project/components/button_comp.dart';
import 'package:final_project/components/textfield_comp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class SignupPage extends StatefulWidget {
  SignupPage ({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //text controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  final emailController = TextEditingController();
  String? emailError;
  String? passwordError;
  String? usernameError;

  // dispose เพื่อป้องกัน memory leak
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void signUserUp() async{
    setState(() {

    usernameError = null;
    emailError = null;
    passwordError = null;

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();


    if (username.isEmpty) {
      usernameError = 'Please enter username';
    } else if (username.length < 4) {
      usernameError = 'Username must be at least 4 letters.';
    }

    if (email.isEmpty) {
      emailError = 'Please enter your email';
    } else if (!EmailValidator.validate(email)) {
      emailError = 'Wrong email format (ex. name@email.com)';
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      passwordError = 'Please enter password and confirm password';
    } else if (password.length < 6) {
      passwordError = 'Password need to be at least 6 letters.';
    } else if (password != confirmPassword) {
      passwordError = "Password doesn't match!";
    }
  });

  if (usernameError != null || emailError != null || passwordError != null) return;


  try {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    await userCredential.user?.updateDisplayName(usernameController.text.trim());

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/login_page');
  } on FirebaseAuthException catch (e) {
    setState(() {
      if (e.code == 'email-already-in-use') {
        emailError = 'This email is already in use';
      } else if (e.code == 'weak-password') {
        passwordError = 'Password is too weak';
      } else {
        passwordError = e.message;
      }
    });
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
                const SizedBox(height: 10,),
                Image.asset(
                  'assets/images/campusdexlogo.png',
                  height: 120,),
                
                //KU CAMPUS TEXT
                const SizedBox(height: 10,),
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
          
          
                //username textfield
          
              // ค่อยสร้าง icon ติ้กถูกเมื่อชื่อผู้ใช้ไม่ซ้ำกับคนอื่น
                TextfieldComp(
                  controller: usernameController,
                  hintText: 'Username',
                  isPassword: false,
                  errorText: usernameError,
          
                ),
                const SizedBox(height: 30,),
              //email textfield
              TextfieldComp(
                  controller: emailController, 
                  hintText: 'Email', 
                  isPassword: false,
                  errorText: emailError,
                  ),
          
                  const SizedBox(height: 30,),
          
                //password textfield
                TextfieldComp(
                  controller: passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  errorText: passwordError,
                ),
                const SizedBox(height: 30,),
          
                //confirm password
                TextfieldComp(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  isPassword: true,
                  errorText: passwordError,
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
          
                //signup button
                ButtonComp(
                  onTap: ()=> signUserUp(),
                  text: 'Sign Up',
                ),
                const SizedBox(height: 15,),
          
                //already have acc
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account?  '),
                     GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(context, '/login_page'),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold),
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
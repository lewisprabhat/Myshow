import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:myshow/main.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'Signup.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Signup extends StatelessWidget {


  TextEditingController forgetpasswordcontroller = TextEditingController();

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken?.token ?? "");

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await auth.signInWithCredential(authCredential);
      User? user = result.user;

      if (result != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 120),
                child: const Text(
                  'Sign Up Here !',
                  style: TextStyle(color: Colors.black, fontSize: 40),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                prefixIcon: Icon(Icons.mail),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            validator: (value) {
                              final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value!);
                              print(emailValid);
                              if (value == null || value.isEmpty) {
                                return "email should not be empty";
                              }
                              if (!emailValid) {
                                return "email not valid";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          TextFormField(
                            style: TextStyle(),
                            onChanged: (value) {
                              password = value;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            validator: (PassCurrentValue){
                              RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                              var passNonNullValue=PassCurrentValue??"";
                              if(passNonNullValue.isEmpty){
                                return ("Password is required");
                              }
                              else if(passNonNullValue.length<6){
                                return ("Password Must be more than 5 characters");
                              }
                              else if(!regex.hasMatch(passNonNullValue)){
                                return ("Password should contain upper,lower,digit and Special character ");
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                   final user =
                                    await auth.createUserWithEmailAndPassword(email: email, password: password);
                                    if (user != null) {
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()));
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.lightBlue)),
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 24),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8),
                                child: TextButton(
                                  onPressed: () {
                                    auth
                                        .sendPasswordResetEmail(email: email)
                                        .then((value) {});
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text('Recovery password'),
                                        actions: [
                                          TextField(
                                            style: TextStyle(color: Colors.black),
                                            decoration: InputDecoration(
                                                fillColor: Colors.grey.shade100,
                                                filled: true,
                                                hintText: "Email",
                                                prefixIcon: Icon(Icons.mail),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                )),
                                            onChanged: (value) {
                                              email = value;
                                            },
                                            controller: forgetpasswordcontroller,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    '',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          SocialLoginButton(
                            buttonType: SocialLoginButtonType.facebook,
                            onPressed: () {
                              signInWithFacebook();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SocialLoginButton(
                        buttonType: SocialLoginButtonType.google,
                        onPressed: () {
                          signup(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

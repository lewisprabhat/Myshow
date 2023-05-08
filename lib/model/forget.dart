import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:myshow/model/Login.dart';
import 'package:myshow/model/Signup.dart';

class forget extends StatefulWidget {
  const forget({Key? key}) : super(key: key);

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Show'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_cbrbre30.json',
                height: 350.0,
                repeat: true,
                reverse: true,
                animate: true,
              ),

              Padding(padding: EdgeInsets.symmetric(horizontal:40,vertical:5),
                child: Container(
                  height: 60,
                  width: 200,
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyLogin()));
                  },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                        Colors.lightBlue)),
                      child: const Text('Log in',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xff4c505b),
                            fontSize: 30),),

                  ),
                ),
              ),

              Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
                child: Container(
                  height: 60,
                  width: 200,
                  child: TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));

                  },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                        Colors.lightBlue)),
                    child: const Text('Sign Up',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xff4c505b),
                          fontSize: 30),),

                  ),
                ),
              ),
            ],
          )),
    );
  }
}

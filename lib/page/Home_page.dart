import 'package:expense_tracker/provider/google_sign_in.dart';
import 'package:expense_tracker/widget/logged_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
    );
    return  Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: const Color(0xffedf1f4),
              body: StreamBuilder(
              stream:FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData){
                return LoggedInWidget();
              } 
              else if (!snapshot.hasData) {
                return SignUpWidget();
              }else{
                return Center(child: Text('Something Went Wrong!'));
               }
              },
              ),
            ); 
}
}

class SignUpWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Center(
                    child: Container(
                      height: 200,
                      width: 300,
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hey There, \n Welcome Back",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        SizedBox(height: 10),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(" Login in to your account",
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 16))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () async {
                      print("Clicked");
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      await provider.googleLogin();
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FaIcon(FontAwesomeIcons.google),
                          Text("Sign Up with Google")
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 15),
                      margin: EdgeInsets.symmetric(horizontal: 70.0),
                      decoration: BoxDecoration(
                        color: Color(0xffedf1f4),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade600,
                              offset: Offset(5, 5),
                              blurRadius: 5,
                              spreadRadius: 1),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(-5, -5),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
               );
  }

}


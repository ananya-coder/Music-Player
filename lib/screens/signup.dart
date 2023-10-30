import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_app/screens/PhoneAuthPage.dart';
import 'package:spotify_app/screens/SignInPage.dart';
import 'package:spotify_app/screens/app.dart';
import 'package:spotify_app/screens/search.dart';
import 'package:spotify_app/services/Auth_services.dart';

// import 'home.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  bool circular = false;
  late final Function() onTap;
  AuthClass authClass = AuthClass();
  void signup()async
  {try{
    await firebaseAuth.createUserWithEmailAndPassword(email: "ananya124@gmail.com", password: "123456");
  }
  catch(e)
  {
    print(e);
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
           
        
            child:Column(mainAxisAlignment: MainAxisAlignment.center,
          //   children:<Widget>[
          //     Container(
          //   child: Image.asset(
          //     'assets/Group 1.png',
          // fit: BoxFit.fill,),)],
       children: [Container(
            child: Image.asset(
              'assets/Group 1.png',
          fit: BoxFit.fill,),),Text("Designed For Music Lovers", textAlign: TextAlign.center, style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold,),
       ),
       SizedBox(height: 20),
       buttonItem("assets/google.svg", "Continue with google", 25, () {
        authClass.googleSignIn(context);
       }),
        SizedBox(height: 15),
       buttonItem("assets/phone.svg", "Continue with phone number", 25,(){
        Navigator.push(context, MaterialPageRoute(builder: (builder)=>PhoneAuthPage()));
       }),
        SizedBox(height: 30),
        // colorButton(),
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
          onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (builder) => SignInPage()),
                          (route) => false);
                    },
          child: Text("Log In", style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold)),)
        ],)
       ],
       
       )
        ,
       ),
        )
    );
  }

  Widget buttonItem(String imagepath, String buttonName, double size, Function() onTap)
{
  return InkWell(
    onTap: onTap,
    child:Container(
            height: 60,
            width: MediaQuery.of(context).size.width - 60,
            child: Card(
              color: Colors.black,
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
              side:BorderSide(width:1, color: Colors.grey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset(imagepath,height: size, width:size),
                SizedBox(width: 15),
                Text(buttonName, style: TextStyle(fontSize: 17, color: Colors.white,))],
            ),
       ),),
       );
}

  Widget colorButton()
{
  return InkWell(
    onTap: () async {
        setState(() {
          circular = true;
        });
        try{
          setState(() {
            circular = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => App()),
              (route) => false);}
              catch(e)
              {
           final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular = false;
          });
              }},
    child: Container(
    width: MediaQuery.of(context).size.width - 90,
    height:60,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(colors: [   Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)])
    ),
    child: Text("Sign Up", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.white,),)
  ),);
}
}


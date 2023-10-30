// import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:spotify_app/screens/signup.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
  apiKey: "AIzaSyDhhr-ElBz3o6aXMuq-N1TnXLO6KsDD-ZE",
  appId: "1:69620768664:android:f8a6ac0d28e2a6365855ed",
  messagingSenderId: "69620768664",
  projectId: "fir-music-app-ad1ba",
),
  );
  runApp(MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0)),
      home: MyApp()));
}


// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:spotify_app/models/category.dart';
import 'package:spotify_app/models/music.dart';
import 'package:spotify_app/screens/profilepage.dart';
import 'package:spotify_app/services/category_operations.dart';
import 'package:spotify_app/services/music_operations.dart';

// ignore: must_be_immutable
class Home extends StatelessWidget {
  Function _miniPlayer;
  Home(this._miniPlayer); // Dart Constructor ShortHand
  // const Home({Key? key}) : super(key: key);
  Widget createCategory(Category category) {
    return Container(
        color: Colors.blueGrey.shade400,
        child: Row(
          children: [
            Image.network(category.imageURL, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                category.name,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }

  List<Widget> createListOfCategories() {
    List<Category> categoryList =
        CategoryOperations.getCategories(); // Rec Data
    // Convert Data to Widget Using map function
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();
    return categories;
  }

  Widget createMusic(Music music) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 200,
            child: InkWell(
              onTap: () {
                _miniPlayer(music, stop: true);
              },
              child: Image.network(
                music.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            music.name,
            style: TextStyle(color: Colors.white),
          ),
          Text(music.desc, style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }

  Widget createMusicList(String label) {
    List<Music> musicList = MusicOperations.getMusic();
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 300,
            child: ListView.builder(
              //padding: EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return createMusic(musicList[index]);
              },
              itemCount: musicList.length,
            ),
          )
        ],
      ),
    );
  }

  Widget createGrid() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 280,
      child: GridView.count(
        childAspectRatio: 5 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: createListOfCategories(),
        crossAxisCount: 2,
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Container(
        child: Column(
          children: [
            createAppBar('Good morning', (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=>ProfilePage()));
            }),
            SizedBox(
              height: 5,
            ),
            createGrid(),
            createMusicList('Made for you'),
            createMusicList('Popular PlayList')
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueGrey.shade300, Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.3])),
        //child: Text('Hello Flutter'),
        //color: Colors.orange,
      )),
    );
  }
}

Widget createAppBar(String message, Function() onTap) {
    return InkWell(
      
       onTap: onTap,
       child:Container( 
            padding: EdgeInsets.only(left: 1450), 
                child: CircleAvatar(
                backgroundColor: Color.fromRGBO(173, 140, 123, 1),
                child: Text("A",
                    style: TextStyle(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Raleway",
                        fontStyle: FontStyle.normal,
                        fontSize: 13.0),
                    textAlign: TextAlign.left),
              ),),);

  }

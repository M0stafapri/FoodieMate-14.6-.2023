import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation_project/shared/cubit/states.dart';

import '../../shared/cubit/cubit.dart';
class AboutScreen extends StatelessWidget {
  AboutScreen({Key? key}) : super(key: key);
  final Color firstColor = Color.fromARGB(255,157, 7, 89);
  final Color secondColor = const Color.fromRGBO(0, 0, 0, 1);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return  Scaffold(
          body: SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: MyClipper() ,
                      child: Container(
                        width:double.infinity,
                        height: 350,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:[
                              firstColor,secondColor
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromARGB(255,157, 7, 89),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 25,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color:Colors.white,
                              )),
                          Text('About',style: TextStyle(color: Colors.white, fontSize:30, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 25,
                      child: CircleAvatar(
                        radius: 50,
                        foregroundImage:NetworkImage('${AppCubit.get(context).userModel?.image}'),
                      ),
                    ),

                  ],
                ),
                Form(
                  child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            height: 250,
                            decoration: BoxDecoration(

                            ),
                            child: Text(
                              'FoodieMate is a powerful app that detects food freshness, provides recipes and its ingredients and calories, offers exercise plans, and connects you with nearby trainers. Snap a photo to determine food freshness, access personalized recipes, follow workout routines, and find certified trainers for tailored programs'
                              ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                          ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-300);
    path.lineTo(size.width, 0);
    path.close();
    return path;

  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
}
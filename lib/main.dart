 

import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key ? key }) : super(key : key);

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     home: Musicplayer(),
    );
  }
}
class Musicplayer extends StatefulWidget {
  const Musicplayer({super.key});

  @override
  State<Musicplayer> createState() => _MusicplayerState();
}

class _MusicplayerState extends State<Musicplayer> {
  bool isPlaying =false;
  double value = 0 ;
 
 final player = AudioPlayer();
 Duration ? duration = Duration(seconds: 0); 
 void initPlayer () async{
  await player.setSource(
    AssetSource("uzi.mp3"));
  duration = await player.getDuration();
  
 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Stack(children: [
        Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage("assets/1.jpg"),
              fit: BoxFit.cover,
            ),),
            child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 28,sigmaY: 28),
            child:Container(color: Colors.black45,) ,
            ),
        ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset("assets/1.jpg",
            width: 250.0,),
            
          ),
          SizedBox(height: 20.0 ),
          Text("Hep Hob Vibes" ,
          style: TextStyle(
            color: Colors.white,
            fontSize: 36.0, 
            letterSpacing:6, ),),
            
            
               SizedBox(height: 50.0,),
          Row( 
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${(value / 60).floor()} : ${(value % 6-0).floor()}",
              style: TextStyle(color: Colors.white),),
              Slider.adaptive(
                onChanged:(v) {
                setState(() {
                 value = v; 
                });
              }  , 
              min: 0.0,
               max: duration!.inSeconds.toDouble() ,
                value: value, onChangeEnd: (newValue) async{ 
                  setState(() {
                value = newValue;
                print(newValue);
              });
              player.pause();
              await player.seek(
              Duration(seconds:newValue.toInt() ));
              await player.resume();

              },activeColor: Colors.white,),
                 Text("${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                  style:  TextStyle(
                    color: Colors.white),)
            ],),
            SizedBox(height: 30.0,),
            Container(
              height: 50.0,
              width: 50.0,
              decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(60.0),
                color: Colors.black87,
                border: Border.all(color: Colors.pink),
                ),
                child: InkWell(
                  onTap: ()async{
                if (isPlaying){
                  await player.pause();
                  setState(() {
                     isPlaying = false;
                  });
                }
                 else{   await player.resume();
                   setState(() {
                       isPlaying = true;
                   });
                   player.onPositionChanged.listen(
                    (position){
                   setState(() {
                     value = position.inSeconds.toDouble(); 
                   });
                    }
                   );   
                }
                  },
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  ),
                ),
            )
          
        ],
      ) , 
      ], ), 
    );
  }
}

 

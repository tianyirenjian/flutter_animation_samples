import 'package:flutter/material.dart';
import 'package:flutter_animations/hero_animation.dart';
import 'package:flutter_animations/basic.dart';
import 'package:flutter_animations/color_change.dart';
import 'package:flutter_animations/fab.dart';
import 'package:flutter_animations/hero_animation_home.dart';
import 'package:flutter_animations/medium.dart';
import 'package:flutter_animations/value_change.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/fab': (context) => Fab(),
        '/basic': (context) => Basic(),
        '/medium': (context) => Medium(),
        '/value_change': (context) => ValueChange(),
        '/color_change': (context) => ColorChange(),
        '/hero_animation': (context) => HeroAnimation(),
        '/hero_animation_home': (context) => HeroAnimationHome()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  final samples = {
    'FAB': '/fab',
    'Basic animation': '/basic',
    'Medium\'s clap': '/medium',
    'Value change': '/value_change',
    'Color change': '/color_change',
    'Hero animation': '/hero_animation'
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Samples'),
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          var key = samples.keys.toList()[position];
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, samples[key]);
                },
                child: ListTile(
                  title: Text(key),
                ),
              ),
              Divider()
            ],
          );
        },
        itemCount: samples.length,
      ),
    );
  }
}

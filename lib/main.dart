import 'package:flutter/material.dart';
import 'package:flutter_animations/src/basic.dart';
import 'package:flutter_animations/src/color_change.dart';
import 'package:flutter_animations/src/fab.dart';
import 'package:flutter_animations/src/gridview_hero.dart';
import 'package:flutter_animations/src/hero_animation.dart';
import 'package:flutter_animations/src/hero_animation_home.dart';
import 'package:flutter_animations/src/medium.dart';
import 'package:flutter_animations/src/value_change.dart';

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
        '/value_change': (context) => ValueChange(),
        '/color_change': (context) => ColorChange(),
        '/fab': (context) => Fab(),
        '/basic': (context) => Basic(),
        '/medium': (context) => Medium(),
        '/hero_animation': (context) => HeroAnimation(),
        '/hero_animation_home': (context) => HeroAnimationHome(),
        '/gridview_hero': (context) => GridviewHero()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  final samples = {
    'Value change': '/value_change',
    'Color change': '/color_change',
    'Floating action button': '/fab',
    'Basic animation': '/basic',
    'Medium\'s clap': '/medium',
    'Hero animation': '/hero_animation',
    'Hero animation 2': '/gridview_hero'
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

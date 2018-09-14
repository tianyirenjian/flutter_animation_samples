// from https://www.youtube.com/watch?v=efbB8-x9T2c
import 'package:flutter/material.dart';

class HeroAnimationHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hero = Row(
      children: <Widget>[
        Expanded(child: Container()),
        Hero(
          tag: 'hero',
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircleAvatar(
              radius: 72.0,
              backgroundImage: AssetImage('images/avatar.jpg'),
            ),
          ),
        ),
        Expanded(child: Container())
      ],
    );
    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Welcome hero', style: TextStyle(
        fontSize: 20.0, color: Colors.white
      ),),
    );
    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', style: TextStyle(
          fontSize: 16.0, color: Colors.white
      ),),
    );
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent]
        )
      ),
      child: ListView(
        children: <Widget>[
          hero,
          welcome,
          lorem
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
      ),
      body: body,
    );
  }
}

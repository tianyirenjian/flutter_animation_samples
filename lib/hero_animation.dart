// from https://www.youtube.com/watch?v=efbB8-x9T2c
import 'package:flutter/material.dart';

class HeroAnimation extends StatefulWidget {
  @override
  _HeroAnimationState createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Row(
        children: <Widget>[
          Expanded(child: Container()),
          Container(
            width: 96.0,
            height: 96.0,
            child: CircleAvatar(
              radius: 48.0,
              backgroundImage: AssetImage('images/logo.jpg'),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'youemail@xxx.com',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            Navigator.of(context).pushNamed('/hero_animation_home');
          },
          color: Colors.lightBlueAccent,
          child: Text('Log In', style: TextStyle(
            color: Colors.white
          )),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Hero animation'),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 100.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0,),
            email,
            SizedBox(height: 8.0,),
            password,
            SizedBox(height: 8.0,),
            loginButton
          ],
        )
      )
    );
  }
}

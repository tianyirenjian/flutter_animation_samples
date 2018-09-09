import 'package:flutter/material.dart';
import 'package:flutter_animations/basic.dart';
import 'package:flutter_animations/fab.dart';

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
        '/basic': (context) => Basic()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  final samples = {
    'FAB': '/fab',
    'basic animations': '/basic'
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

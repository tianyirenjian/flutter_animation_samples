import 'dart:math';
import 'package:flutter/material.dart';

class ColorChange extends StatefulWidget {
  State<ColorChange> createState() => _ColorChangeState();
}

class _ColorChangeState extends State<ColorChange> with SingleTickerProviderStateMixin{
  Color start, end;
  AnimationController _colorController;
  Animation<Color> _color;
  Random random;
  bool paused = false;

  @override
  void initState() {
    random = Random();
    start = Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
    end = Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);

    _colorController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    _colorController.addListener((){setState((){});});
    _colorController.addStatusListener((status){
      if (status == AnimationStatus.completed) {
        start = end;
        end = Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
        _color = ColorTween(begin: end, end: start).animate(_colorController); // because of reverse
        _colorController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        start = end;
        end = Color.fromRGBO(random.nextInt(255), random.nextInt(255), random.nextInt(255), 1.0);
        _color = ColorTween(begin: start, end: end).animate(_colorController);
        _colorController.forward();
      }
    });
    _color = ColorTween(begin: start, end: end).animate(_colorController);
    _colorController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  startPause() {
    if (paused) {
      _colorController.forward();
    } else {
      _colorController.stop(canceled: false);
    }
    paused = !paused;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color change'),
      ),
      body: Container(
        color: _color.value,
        child: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlineButton(onPressed: startPause, child: Text('Start / Pause'),)
          ],
        ),),
      ),
    );
  }
}
// from https://proandroiddev.com/flutter-animation-creating-mediums-clap-animation-in-flutter-3168f047421e
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class Medium extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MediumState();
}

class _MediumState extends State<Medium> with TickerProviderStateMixin{
  int _counter = 0;
  final duration = Duration(milliseconds: 400);
  Timer holdTimer, scoreOutETA;
  AnimationController _scoreInAnimationController, _scoreOutAnimationController,
    _scoreSizeAnimationController, _sparklesAnimationController;
  Animation<double> _scoreOutPosition, _sparkles;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
  double _sparkAngle = 0.0;
  Random random;

  initState () {
    _scoreInAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150))
    ..addListener(() {setState((){});});
    _scoreOutAnimationController = AnimationController(vsync: this, duration: duration);
    _scoreOutPosition = Tween(begin: 100.0, end: 150.0).animate(CurvedAnimation(
      parent: _scoreOutAnimationController,
      curve: Curves.easeOut
    ));
    _scoreOutPosition.addListener((){setState((){});});
    _scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });
    _scoreSizeAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 150))
      ..addListener((){setState((){});});
    _scoreSizeAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreSizeAnimationController.reverse();
      }
    });
    _sparklesAnimationController = AnimationController(vsync: this, duration: duration);
    _sparkles = CurvedAnimation(parent: _sparklesAnimationController, curve: Curves.easeIn);
    _sparkles.addListener((){setState((){});});
    random = Random();
    super.initState();
  }

  dispose () {
    _scoreInAnimationController.dispose();
    _scoreOutAnimationController.dispose();
    super.dispose();
  }

  increment (Timer t) {
    _scoreSizeAnimationController.forward(from: 0.0);
    _sparklesAnimationController.forward(from: 0.0);
    setState(() {
      _counter ++;
      _sparkAngle = random.nextDouble() * (2 * pi);
    });
  }

  onTapDown (TapDownDetails tap) {
    if (scoreOutETA != null) {
      scoreOutETA.cancel();
    }
    if (_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE) {
      _scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    }
    if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN) {
      _scoreInAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
    }
    increment(null);
    holdTimer = Timer.periodic(duration, increment);
  }

  onTapUp (TapUpDetails tap) {
    scoreOutETA = Timer(duration, () {
      _scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISIBLE;
    });
    holdTimer.cancel();
  }

  Widget getScoreButton () {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch (_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE:
      case ScoreWidgetStatus.VISIBLE:
        scoreOpacity = _scoreInAnimationController.value;
        scorePosition = _scoreInAnimationController.value * 100;
        extraSize = _scoreSizeAnimationController.value * 10;
        break;
      case ScoreWidgetStatus.BECOMING_INVISIBLE:
        scoreOpacity = 1 - _scoreOutAnimationController.value;
        scorePosition = _scoreOutPosition.value;
    }

    var firstAngle = _sparkAngle;
    var sparkRadius = _sparklesAnimationController.value * 50;
    var sparkOpacity = 1 - _sparkles.value;
    var stackChildren = <Widget>[];
    for (var i = 0; i < 5; i ++) {
      var currentAngle = firstAngle + (2 * pi / 5 * i);
      var sparkleWidget = Positioned(child: Transform.rotate(
          angle: currentAngle - pi / 2,
          child: Opacity(opacity: sparkOpacity, child: Image.asset(
            'images/sparkles.png',
            width: 14.0,
            height: 14.0,
          )),
        ),
        left: sparkRadius * cos(currentAngle) + 20,
        top: sparkRadius * sin(currentAngle) + 20
      );
      stackChildren.add(sparkleWidget);
    }

    stackChildren.add(Opacity(
      opacity: scoreOpacity,
      child: Container(
        height: 50.0 + extraSize,
        width: 50.0 + extraSize,
        decoration: ShapeDecoration(
          shape: CircleBorder(
              side: BorderSide.none
          ),
          color: Colors.pink,
        ),
        child: Center(
          child: Text('+$_counter', style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          )),
        ),
      ),
    ));

    return Positioned(child: Stack(
      alignment: FractionalOffset.center,
      overflow: Overflow.visible,
      children: stackChildren,
    ), bottom: scorePosition);
  }

  Widget getClapButton () {
    var extraSize = 0.0;
    if (_scoreWidgetStatus == ScoreWidgetStatus.VISIBLE || _scoreWidgetStatus == ScoreWidgetStatus.BECOMING_VISIBLE) {
      extraSize = _scoreSizeAnimationController.value * 10;
    }
    return GestureDetector(
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      child: Container(
        height: 60.0 + extraSize,
        width: 60.0 + extraSize,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.pink, width: 1.0),
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.pink, blurRadius: 8.0)
          ]
        ),
        child: ImageIcon(
          AssetImage('images/clap.png'),
          color: Colors.pink,
          size: 40.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medium\'s clap'),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: <Widget>[
            getScoreButton(),
            getClapButton()
          ],
        ),
      ),
    );
  }
}

enum ScoreWidgetStatus {
  HIDDEN,
  BECOMING_VISIBLE,
  VISIBLE,
  BECOMING_INVISIBLE
}
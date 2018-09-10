import 'package:flutter/material.dart';

class Basic extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BasicState();
}

class _BasicState extends State<Basic> with TickerProviderStateMixin{
  AnimationController _opacityController;
  Animation<double> _opacity;
  bool _showHint = false;

  @override
  void initState() {
    _opacityController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _opacity = CurvedAnimation(parent: _opacityController, curve: Curves.easeInOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _opacityController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _opacityController.forward();
        }
      });
    _opacityController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic animation'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            !_showHint ? FadeTransition(
              opacity: _opacity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.arrow_back),
                  Padding(padding: EdgeInsets.only(left: 8.0)),
                  Text('Swipe it', style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey
                  ),)
                ],
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }

}
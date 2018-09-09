import 'package:flutter/material.dart';

class Fab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FabState();
}

class _FabState extends State<Fab> with SingleTickerProviderStateMixin{
  var counter = 0;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animationIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
        begin: Colors.blue,
        end: Colors.red
    ).animate(CurvedAnimation(parent: _animationController, curve: Interval(
      0.00,
      1.00,
      curve: _curve
    )));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -10.0
    ).animate(CurvedAnimation(parent: _animationController, curve: Interval(
      0.00,
      0.75,
      curve: _curve
    )));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate () {
    isOpened ?
        _animationController.reverse() : _animationController.forward();
    isOpened = !isOpened;
    counter ++;
  }

  Widget toggle () {
    return Container(
      child: FloatingActionButton(
        heroTag: 'toggle',
          onPressed: animate,
          backgroundColor: _animateColor.value,
          tooltip: 'toggle',
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationIcon,
          )
      ),
    );
  }

  Widget add () {
    return Container(
      child: FloatingActionButton(
        heroTag: 'add',
        onPressed: null,
        tooltip: 'add',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget image () {
    return Container(
      child: FloatingActionButton(
        heroTag: 'image',
        onPressed: null,
        tooltip: 'image',
        child: Icon(Icons.image),
      ),
    );
  }

  Widget label () {
    return Container(
      child: FloatingActionButton(
        heroTag: 'label',
        onPressed: null,
        tooltip: 'label',
        child: Icon(Icons.label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAB animation')
      ),
      body: Center(
        child: Text("Count: $counter", style: Theme.of(context).textTheme.display1,),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(0.0, _translateButton.value * 3, 0.0),
            child: add(),
          ),
          Transform(
            transform: Matrix4.translationValues(0.0, _translateButton.value * 2, 0.0),
            child: image(),
          ),
          Transform(
            transform: Matrix4.translationValues(0.0, _translateButton.value, 0.0),
            child: label(),
          ),
          toggle()
        ],
      ),
    );
  }

}
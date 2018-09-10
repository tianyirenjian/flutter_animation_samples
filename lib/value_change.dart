import 'package:flutter/material.dart';

class ValueChange extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ValueChangeState();
}

class _ValueChangeState extends State<ValueChange> with SingleTickerProviderStateMixin{
  AnimationController _valueChangeController;
  Animation<int> _valueChange;

  @override
  void initState() {
    _valueChangeController = AnimationController(vsync: this, duration: Duration(seconds: 10));
    _valueChange = IntTween(begin: 1, end: 100).animate(_valueChangeController);
    _valueChange.addListener((){
      setState((){});
    });
    super.initState();
  }

  dispose () {
    _valueChangeController.dispose();
    super.dispose();
  }

  animate() {
    _valueChangeController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Value change'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${_valueChange.value}', style: Theme.of(context).textTheme.display1),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            FloatingActionButton(onPressed: animate, child: Icon(Icons.play_arrow))
          ],
        ),
      ),
    );
  }
}

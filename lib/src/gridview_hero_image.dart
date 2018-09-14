import 'package:flutter/material.dart';

class GridviewHeroImage extends StatefulWidget {
  final tag;
  final image;
  GridviewHeroImage(this.tag, this.image);
  @override
  _GridviewHeroImageState createState() => _GridviewHeroImageState();
}

class _GridviewHeroImageState extends State<GridviewHeroImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(15.0), child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Hero(
            tag: widget.tag,
            child: Image.asset(widget.image),
          ),
        )),
      ),
    );
  }
}

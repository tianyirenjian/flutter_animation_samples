import 'package:flutter/material.dart';
import 'package:flutter_animations/src/gridview_hero_image.dart';

class GridviewHero extends StatefulWidget {
  @override
  _GridviewHeroState createState() => _GridviewHeroState();
}

class _GridviewHeroState extends State<GridviewHero> {
  @override
  Widget build(BuildContext context) {
    final heroes = [{
      'title': 'image 1',
      'tag': 'image1',
      'image': 'images/logo.jpg'
    }, {
      'title': 'image 2',
      'tag': 'image2',
      'image': 'images/avatar.jpg'
    }];
    final width = MediaQuery.of(context).size.width / 2;
    final gridView = GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.75,
      padding: EdgeInsets.all(10.0),
      children: heroes.map((hero) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return GridviewHeroImage(hero['tag'], hero['image']);
            }));
          },
          child: Card(
            semanticContainer: false,
            elevation: 4.0,
            child: Column(
              children: <Widget>[
                Hero(tag: hero['tag'], child: Image.asset(
                  hero['image'],
                  width: width,
                  height: width,
                  fit: BoxFit.cover
                )),
                SizedBox(height: 14.0),
                Text(hero['title'], style: TextStyle(
                  fontSize: 18.0
                ))
              ],
            ),
          )
        );
      }).toList(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero animation 2'),
      ),
      body: gridView,
    );
  }
}

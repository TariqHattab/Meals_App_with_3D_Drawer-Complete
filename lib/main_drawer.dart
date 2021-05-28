import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final Function setIndex;

  const MainDrawer({Key key, this.setIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var width = (w * .834).roundToDouble();
    return SizedBox(
      width: width,
      height: double.infinity,
      child: Material(
        color: Theme.of(context).accentColor,
        child: Column(mainAxisSize: MainAxisSize.max, children: [
          Container(
              width: double.infinity,
              height: 150,
              padding: const EdgeInsets.only(left: 15, top: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                'Cooking Up',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              )),
          ListTile(
            leading: Icon(Icons.restaurant, size: 30),
            title: Text('Categories', style: TextStyle(fontSize: 20)),
            onTap: () {
              setIndex(0);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, size: 30),
            title: Text('Filters', style: TextStyle(fontSize: 20)),
            onTap: () {
              setIndex(1);
            },
          ),
        ]),
      ),
    );
  }
}

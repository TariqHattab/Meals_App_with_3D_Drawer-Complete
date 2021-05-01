import 'package:flutter/material.dart';
import 'package:meals_app_2/providers/available_list.dart';
import 'package:provider/provider.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters_screen';
  final Function setIndex;

  const FiltersScreen({Key key, this.setIndex}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var filters;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filters = Provider.of<AvailableList>(context, listen: false).filters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey('2'),
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Provider.of<AvailableList>(context, listen: false)
                    .setFilters(filters);
                widget.setIndex(0, true);
                // Navigator.of(context).pushReplacementNamed('/');
              })
        ],
      ),
      body: Column(
        children: [
          buildListTileSwitch('is Gluten Free', 'gluten'),
          buildListTileSwitch('is Lactose Free', 'lactose'),
          buildListTileSwitch('is Vegetarian', 'vegeterian'),
          buildListTileSwitch('is Vegan', 'vegan'),
        ],
      ),
    );
  }

  SwitchListTile buildListTileSwitch(
    String title,
    String condType,
  ) {
    return SwitchListTile(
      value: filters[condType],
      onChanged: (value) {
        print(filters[condType]);
        setState(() {
          filters[condType] = value;
        });
        print(filters[condType]);
      },
      title: Text(title),
    );
  }
}

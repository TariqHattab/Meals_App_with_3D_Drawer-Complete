import 'package:flutter/material.dart';
import 'package:meals_app_2/models/meal.dart';
import 'package:meals_app_2/providers/favorite_list.dart';
import 'package:provider/provider.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail_screen';
  final Meal meal;
  MealDetailScreen(this.meal);

  Padding subtitleBuilder(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Container containerBuilder(Widget child) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        height: 200,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${meal.title}'),
      ),
      floatingActionButton: FABisFavorite(
        meal: meal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(tag: meal.id, child: Image.network(meal.imageUrl)),
            subtitleBuilder(context, 'Ingredients'),
            containerBuilder(
              ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (ctx, index) {
                  var ingrd = meal.ingredients[index];
                  return Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(ingrd,
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Divider()
                  ]);
                },
              ),
            ),
            subtitleBuilder(context, 'Steps'),
            containerBuilder(
              ListView.builder(
                padding: const EdgeInsets.only(top: 5),
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  var step = meal.steps[index];
                  return Column(children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(step),
                    ),
                    Divider()
                  ]);
                },
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class FABisFavorite extends StatefulWidget {
  final Meal meal;
  const FABisFavorite({
    Key key,
    this.meal,
  }) : super(key: key);

  @override
  _FABisFavoriteState createState() => _FABisFavoriteState();
}

class _FABisFavoriteState extends State<FABisFavorite> {
  var isFavorite;

  @override
  Widget build(BuildContext context) {
    isFavorite = Provider.of<FavoriteList>(context).isFavorite(widget.meal);
    return FloatingActionButton(
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_outline,
        color: Colors.black,
      ),
      onPressed: () {
        setState(() {
          if (isFavorite) {
            Provider.of<FavoriteList>(context, listen: false)
                .removeFavorite(widget.meal);
          } else {
            Provider.of<FavoriteList>(context, listen: false)
                .addFavorite(widget.meal);
          }
        });
      },
    );
  }
}

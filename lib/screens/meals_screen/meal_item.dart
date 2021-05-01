import 'package:flutter/material.dart';
import 'package:meals_app_2/models/meal.dart';
import 'package:meals_app_2/screens/meal_detail_screen/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    Key key,
    @required this.meal,
  }) : super(key: key);

  final Meal meal;

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;

      default:
        return '';
    }
  }

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(MealDetailScreen.routeName, arguments: {'meal': meal});
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Hero(
                    tag: meal.id,
                    child: FadeInImage(
                      placeholder:
                          AssetImage('assets/images/food-placeholder.jpg'),
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        meal.imageUrl,
                      ),
                    ),
                  ),
                  //fit: BoxFit.cover,
                ),
                Positioned(
                  right: 10,
                  bottom: 20,
                  child: Container(
                    width: 250,
                    padding: const EdgeInsets.all(15),
                    color: Colors.black38,
                    child: Text(
                      '${meal.title}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 5,
                      ),
                      Text(meal.duration.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.work),
                      SizedBox(
                        width: 5,
                      ),
                      Text(complexityText),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.attach_money),
                      SizedBox(
                        width: 5,
                      ),
                      Text(affordabilityText),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

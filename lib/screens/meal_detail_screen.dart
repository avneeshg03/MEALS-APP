import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routName = '/meal-detail-screen';
  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => mealId == meal.id ? true : false);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '${selectedMeal.title}',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingridients!!'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, i) => Card(
                  color: Colors.redAccent,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      selectedMeal.ingredients[i],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, i) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text('#${i + 1}'),
                      ),
                      title: Text(selectedMeal.steps[i]),
                    ),
                    Divider(),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop(mealId);
          },
          child: Icon(Icons.delete),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:customer_app/models/dish.dart';
import 'package:customer_app/values/values.dart';

class DishCard extends StatelessWidget {
  const DishCard({
    Key key,
    @required this.dish,
    this.onPressed,
  }) : super(key: key);

  final Dish dish;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Sizes.SIZE_30,
          ),
          boxShadow: [Shadows.dishCard],
          color: Colors.white,
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Transform.translate(
              offset: Offset(0.0, -40.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 120.0,
                    maxHeight: 120.0,
                  ),
                  child: Image.asset(
                    dish.image,
                  ),
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, 0.2),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 35.0, horizontal: Sizes.SIZE_20),
                child: Text(
                  '${dish.name}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.black),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0.0, 0.6),
              child: Text(
                '${toMoney(dish.price)}',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.pink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

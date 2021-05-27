import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/models/dish.dart';
import 'package:customer_app/values/values.dart';
import 'package:customer_app/widgets/custom_icon.dart';
// import 'package:customer_app/widgets/search_dish_card.dart';

import 'package:customer_app/foodDetailsVar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Dish> _dishes = [];
  List<Dish> _filteredDishes = [];
  int _filteredCount = -1;
  bool _filtering = false;

  @override
  void initState() {
    loadDishes().then((data) {
      setState(() {
        _dishes = data.expand((entry) => entry.dishes).toList();
      });
    });
    super.initState();
  }

  void _navigateBack() {
    ExtendedNavigator.root.pop();
  }

  @override
  Widget build(BuildContext context) {
    final bool itemNotFound = _filteredCount == 0;

    return Scaffold(
      backgroundColor: itemNotFound ? AppColors.blue200 : AppColors.gray,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            _buildSearch(context),
            Expanded(child: _buildGrid(context)),
          ],
        ),
      ),
    );
  }

  void _onTextChanged(String search) {
    setState(() {
      if (search != '') {
        _filtering = true;
        _filteredDishes = _dishes
            .where((dish) => dish.name.toLowerCase().contains(search))
            .toList();
        _filteredCount = _filteredDishes.length;
      } else {
        _filteredCount = -1;
        _filtering = false;
      }
    });
  }

  Padding _buildSearch(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.SIZE_30),
      child: Row(
        children: [
          IconButton(
            onPressed: _navigateBack,
            icon: Icon(Icons.keyboard_arrow_left),
          ),
          SizedBox(width: Sizes.SIZE_30),
          Expanded(
            child: TextField(
              controller: _searchController,
              autofocus: true,
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: StringConst.SEARCH_HINT,
              ),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }

  Center _buildItemNotFound() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIcon(
              name: 'search',
              color: AppColors.gray100,
            ),
            SizedBox(height: Sizes.SIZE_20),
            Text(
              StringConst.ITEM_NOT_FOUND,
              style: Theme.of(context).textTheme.headline3.copyWith(
                    fontFamily: StringConst.SF_PRO_TEXT,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
            ),
            SizedBox(height: Sizes.SIZE_20),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2,
              ),
              child: Text(StringConst.ITEM_NOT_FOUND_HINT,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        fontFamily: StringConst.SF_PRO_TEXT,
                        color: AppColors.gray300,
                      )),
            )
          ],
        ),
      );

  Widget _buildGrid(BuildContext context) {
    if (_filteredCount == 0) {
      return _buildItemNotFound();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white100,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.SIZE_30),
            topRight: Radius.circular(Sizes.SIZE_30)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.SIZE_30),
            child: Align(
              alignment: Alignment.center,
              child: _buildResultText(context),
            ),
          ),
          Expanded(
            child: _buildDishesGridList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildResultText(BuildContext context) {
    if (_filteredCount == -1) {
      return Container();
    }

    return Text(
      'Found $_filteredCount Results',
      style:
          Theme.of(context).textTheme.headline3.copyWith(color: Colors.black),
    );
  }

  Widget _buildDishesGridList(BuildContext context) {
    final List<Dish> _dishList = _filtering ? _filteredDishes : _dishes;

    if (_dishList.length > 0) {
      return GridView.builder(
        padding: const EdgeInsets.all(Sizes.SIZE_30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          final double isFirstMargin =
              index == 0 ? Sizes.SIZE_20 : Sizes.SIZE_12;
          final double isLastMargin =
              index == length - 1 ? Sizes.SIZE_20 : Sizes.SIZE_12;

          if (index % 2 != 0) {
            return Transform(
              transform: Matrix4.identity()..translate(0.0, 60.0),
              child: Container(
                margin: EdgeInsets.only(
                  top: isFirstMargin,
                  bottom: isLastMargin,
                ),
                child: GestureDetector(
                  onTap: () {},
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
                                maxWidth: 100.0,
                                maxHeight: 100.0,
                              ),
                              child: Image.network(
                                foodData[index]['foodpic'],
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
                              foodData[index]['_id'],
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(0.0, 0.6),
                          child: Text(
                            '₹ ' + foodData[index]['foodprice'] + '/-',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: AppColors.red200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Container(
            margin: EdgeInsets.only(
              top: isFirstMargin,
              bottom: isLastMargin,
            ),
            child: GestureDetector(
              onTap: () {},
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
                            maxWidth: 100.0,
                            maxHeight: 100.0,
                          ),
                          child: Image.network(
                            foodData[index]['foodpic'],
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
                          foodData[index]['_id'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.0, 0.6),
                      child: Text(
                        '₹ ' + foodData[index]['foodprice'] + '/-',
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: AppColors.red200),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

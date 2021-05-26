import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/app_theme.dart';
import 'package:customer_app/models/cart.dart';
import 'package:customer_app/models/order.dart';
import 'package:customer_app/models/profile.dart';
import 'package:customer_app/routes/router.gr.dart';
import 'package:customer_app/values/values.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:customer_app/values/user.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void details() async {
    final String url = 'https://apifoodapp.herokuapp.com/infoUser';

    Map<String, dynamic> data = <String, dynamic>{
      'username': USERNAME,
    };

    http.Response response = await http.post(Uri.parse(url), body: data);

    var info = response.body;
    Map valueMap = json.decode(info);
    print(valueMap['_id']);

    if (response.statusCode == 200) {
      String data = response.body;

      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConst.APP_NAME,
      theme: AppTheme.themeData,
      onGenerateRoute: AppRouter(),
      builder: ExtendedNavigator.builder<AppRouter>(
        router: AppRouter(),
        initialRoute: Routes.splashScreen,
        builder: (context, extendedNav) => MultiProvider(
          providers: [
            ChangeNotifierProvider<Profile>(
              create: (_) => Profile(
                name: userFullName,
                email: userEmail,
                address: userAddress,
                mobile: userPhoneNumber,
              ),
            ),
            ChangeNotifierProvider<Cart>(
              create: (_) => Cart(),
            ),
            ChangeNotifierProvider<Orders>(
              create: (_) => Orders(),
            ),
          ],
          child: extendedNav,
        ),
      ),
    );
  }
}

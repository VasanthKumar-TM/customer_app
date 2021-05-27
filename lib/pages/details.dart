import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/theme.dart';
import 'package:customer_app/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:customer_app/screens/home_screen.dart';
import 'package:customer_app/theme.dart';
import 'package:customer_app/utils/bubble_indicator_painter.dart';
import 'package:customer_app/values/user.dart';
import 'dart:convert';

import 'package:customer_app/foodDetailsVar.dart';

var username,
    password,
    fullName,
    phnumber,
    address,
    mail,
    profilepic,
    cPassWord;

class Details extends StatefulWidget {
  Details(user, pass) {
    username = user;
    password = pass;
  }

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();
  final FocusNode focusNodeNumber = FocusNode();
  final FocusNode focusNodeAddress = FocusNode();
  final FocusNode focusNodeProfile = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  bool _loading = true;

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupNumberController = TextEditingController();
  TextEditingController signupAddressController = TextEditingController();
  TextEditingController signupProfileController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    focusNodeName.dispose();
    focusNodeAddress.dispose();
    focusNodeNumber.dispose();
    focusNodeProfile.dispose();
    super.dispose();
  }

  void foodDetails() async {
    print('came');
    final String url = 'https://apifoodapp.herokuapp.com/infoFood';

    // Map<String, dynamic> data = <String, dynamic>{
    //   '': '',
    // };

    http.Response response = await http.post(Uri.parse(url));

    var info = response.body;
    // print(info);

    if (response.statusCode == 200) {
      String data = response.body;
      var valueMap = json.decode(data);
      foodData = valueMap;
      print(foodData);
      length = foodData.length;
      print(length);
      isLoad = true;
    }
  }

  void signUp(usernameN, passwordN, fullNameN, phnumberN, mailN, addressN,
      profilepicN) async {
    final String url = 'https://apifoodapp.herokuapp.com/createUser';

    Map<String, dynamic> data = <String, dynamic>{
      'userpic': profilepicN,
      'userorgname': fullNameN,
      'username': usernameN,
      'password': passwordN,
      'phone': phnumberN,
      'mailid': mailN,
      'address': addressN
    };

    http.Response response = await http.post(Uri.parse(url), body: data);

    if (response.statusCode == 200) {
      String data = response.body;
      if (data == 'true') {
        // CustomSnackBar(context, const Text('Next page'));

        final String urlN = 'https://apifoodapp.herokuapp.com/infoUser';

        Map<String, dynamic> data = <String, dynamic>{'username': usernameN};

        http.Response response = await http.post(Uri.parse(urlN), body: data);

        var info = response.body;
        Map valueMap = json.decode(info);

        userFullName = valueMap['userorgname'];
        userEmail = valueMap['mailid'];
        userAddress = valueMap['address'];
        userPhoneNumber = valueMap['phone'];

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        CustomSnackBar(context, Text('Error: ' + data));
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    CustomTheme.loginGradientStart,
                    CustomTheme.loginGradientEnd
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: _buildMenuBar(context),
                ),
                Expanded(
                  flex: 1,
                  child: PageView(
                    controller: _pageController,
                    physics: const ClampingScrollPhysics(),
                    onPageChanged: (int i) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (i == 0) {
                        setState(() {
                          right = Colors.white;
                          left = Colors.black;
                        });
                      }
                    },
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: Container(
                          padding: const EdgeInsets.only(top: 23.0),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Card(
                                    elevation: 2.0,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      width: 300.0,
                                      height: 500.0,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                                left: 25.0,
                                                right: 25.0),
                                            child: TextField(
                                              focusNode: focusNodeName,
                                              controller: signupNameController,
                                              keyboardType: TextInputType.text,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              autocorrect: false,
                                              onChanged: (value) {
                                                setState(() {
                                                  fullName = value;
                                                });
                                              },
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'WorkSansSemiBold',
                                                  fontSize: 16.0,
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  FontAwesomeIcons.user,
                                                  color: Colors.black,
                                                ),
                                                hintText: 'Full Name',
                                                hintStyle: TextStyle(
                                                    fontFamily:
                                                        'WorkSansSemiBold',
                                                    fontSize: 16.0),
                                              ),
                                              onSubmitted: (_) {
                                                focusNodeEmail.requestFocus();
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 250.0,
                                            height: 1.0,
                                            color: Colors.grey[400],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                                left: 25.0,
                                                right: 25.0),
                                            child: TextField(
                                              focusNode: focusNodeNumber,
                                              controller:
                                                  signupNumberController,
                                              keyboardType: TextInputType.text,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              autocorrect: false,
                                              onChanged: (value) {
                                                setState(() {
                                                  phnumber = value;
                                                });
                                              },
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'WorkSansSemiBold',
                                                  fontSize: 16.0,
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  FontAwesomeIcons.user,
                                                  color: Colors.black,
                                                ),
                                                hintText: 'Phone Number',
                                                hintStyle: TextStyle(
                                                    fontFamily:
                                                        'WorkSansSemiBold',
                                                    fontSize: 16.0),
                                              ),
                                              onSubmitted: (_) {
                                                focusNodeEmail.requestFocus();
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 250.0,
                                            height: 1.0,
                                            color: Colors.grey[400],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                                left: 25.0,
                                                right: 25.0),
                                            child: TextField(
                                              focusNode: focusNodeEmail,
                                              controller: signupEmailController,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              autocorrect: false,
                                              onChanged: (value) {
                                                setState(() {
                                                  mail = value;
                                                });
                                              },
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'WorkSansSemiBold',
                                                  fontSize: 16.0,
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  FontAwesomeIcons.user,
                                                  color: Colors.black,
                                                ),
                                                hintText: 'Mail Id',
                                                hintStyle: TextStyle(
                                                    fontFamily:
                                                        'WorkSansSemiBold',
                                                    fontSize: 16.0),
                                              ),
                                              onSubmitted: (_) {
                                                focusNodeEmail.requestFocus();
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 250.0,
                                            height: 1.0,
                                            color: Colors.grey[400],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                                left: 25.0,
                                                right: 25.0),
                                            child: TextField(
                                              focusNode: focusNodeAddress,
                                              controller:
                                                  signupAddressController,
                                              keyboardType: TextInputType.text,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              autocorrect: false,
                                              onChanged: (value) {
                                                setState(() {
                                                  address = value;
                                                });
                                              },
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'WorkSansSemiBold',
                                                  fontSize: 16.0,
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  FontAwesomeIcons.user,
                                                  color: Colors.black,
                                                ),
                                                hintText: 'Address',
                                                hintStyle: TextStyle(
                                                    fontFamily:
                                                        'WorkSansSemiBold',
                                                    fontSize: 16.0),
                                              ),
                                              onSubmitted: (_) {
                                                focusNodeEmail.requestFocus();
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 250.0,
                                            height: 1.0,
                                            color: Colors.grey[400],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 20.0,
                                                left: 25.0,
                                                right: 25.0),
                                            child: TextField(
                                              focusNode: focusNodeProfile,
                                              controller:
                                                  signupProfileController,
                                              keyboardType: TextInputType.text,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              autocorrect: false,
                                              onChanged: (value) {
                                                setState(() {
                                                  profilepic = value;
                                                });
                                              },
                                              style: const TextStyle(
                                                  fontFamily:
                                                      'WorkSansSemiBold',
                                                  fontSize: 16.0,
                                                  color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                icon: Icon(
                                                  FontAwesomeIcons.user,
                                                  color: Colors.black,
                                                ),
                                                hintText: 'Image',
                                                hintStyle: TextStyle(
                                                    fontFamily:
                                                        'WorkSansSemiBold',
                                                    fontSize: 16.0),
                                              ),
                                              onSubmitted: (_) {
                                                focusNodeEmail.requestFocus();
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 250.0,
                                            height: 1.0,
                                            color: Colors.grey[400],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 480.0),
                                    decoration: _loading
                                        ? const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: CustomTheme
                                                    .loginGradientStart,
                                                offset: Offset(1.0, 6.0),
                                                blurRadius: 20.0,
                                              ),
                                              BoxShadow(
                                                color: CustomTheme
                                                    .loginGradientEnd,
                                                offset: Offset(1.0, 6.0),
                                                blurRadius: 20.0,
                                              ),
                                            ],
                                            gradient: LinearGradient(
                                                colors: <Color>[
                                                  CustomTheme.loginGradientEnd,
                                                  CustomTheme.loginGradientStart
                                                ],
                                                begin:
                                                    FractionalOffset(0.2, 0.2),
                                                end: FractionalOffset(1.0, 1.0),
                                                stops: <double>[0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                          )
                                        : const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: CustomTheme
                                                    .loginGradientStart,
                                                offset: Offset(1.0, 6.0),
                                                blurRadius: 20.0,
                                              ),
                                              BoxShadow(
                                                color: CustomTheme
                                                    .loginGradientEnd,
                                                offset: Offset(1.0, 6.0),
                                                blurRadius: 20.0,
                                              ),
                                            ],
                                            gradient: LinearGradient(
                                                colors: <Color>[
                                                  Colors.white,
                                                  Colors.white
                                                ],
                                                begin:
                                                    FractionalOffset(0.2, 0.2),
                                                end: FractionalOffset(1.0, 1.0),
                                                stops: <double>[0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                          ),
                                    child: _loading
                                        ? MaterialButton(
                                            highlightColor: Colors.transparent,
                                            splashColor:
                                                CustomTheme.loginGradientEnd,
                                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 42.0),
                                              child: Text(
                                                'SUBMIT',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25.0,
                                                    fontFamily: 'WorkSansBold'),
                                              ),
                                            ),
                                            onPressed: () => fullName == "" ||
                                                    address == "" ||
                                                    phnumber == "" ||
                                                    mail == "" ||
                                                    profilepic == ""
                                                ? CustomSnackBar(
                                                    context,
                                                    const Text(
                                                        'Please Enter all the Fields.'))
                                                : {
                                                    signUp(
                                                        username,
                                                        password,
                                                        fullName,
                                                        phnumber,
                                                        mail,
                                                        address,
                                                        profilepic),
                                                    foodDetails(),
                                                    setState(
                                                        () => _loading = false),
                                                  },
                                          )
                                        : CircularProgressIndicator(),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 150.0,
      height: 50.0,
      decoration: const BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: BubbleIndicatorPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () {},
                child: Text(
                  'Details',
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansSemiBold'),
                ),
              ),
            ),
            //Container(height: 33.0, width: 1.0, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _toggleSignUpButton() {
    CustomSnackBar(context, const Text('SignUp button pressed'));
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}

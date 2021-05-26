import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/theme.dart';
import 'package:customer_app/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:customer_app/routes/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:customer_app/values/user.dart';
import 'package:customer_app/models/profile.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;

  bool _loading = true;

  dynamic userName, passWord;

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  void signIn(String userN, dynamic pass) async {
    final String url = 'https://apifoodapp.herokuapp.com/loginUser';

    Map<String, dynamic> data = <String, dynamic>{
      'username': userN,
      'password': pass
    };

    http.Response response = await http.post(Uri.parse(url), body: data);

    if (response.statusCode == 200) {
      String data = response.body;
      if (data == 'success') {
        // CustomSnackBar(context, const Text('Next page'));

        final String urlN = 'https://apifoodapp.herokuapp.com/infoUser';

        Map<String, dynamic> data = <String, dynamic>{'username': userN};

        http.Response response = await http.post(Uri.parse(urlN), body: data);

        var info = response.body;
        Map valueMap = json.decode(info);

        userFullName = valueMap['userorgname'];
        userEmail = valueMap['mailid'];
        userAddress = valueMap['address'];
        userPhoneNumber = valueMap['phone'];

        ExtendedNavigator.root.push(Routes.homeScreen);
      } else {
        CustomSnackBar(context, Text('Error: ' + data));
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeEmail,
                          controller: loginEmailController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            setState(() {
                              userName = value;
                            });
                          },
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                          ),
                          onSubmitted: (_) {
                            focusNodePassword.requestFocus();
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
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: loginPasswordController,
                          obscureText: _obscureTextPassword,
                          onChanged: (value) {
                            setState(() {
                              passWord = value;
                            });
                          },
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            _toggleSignInButton();
                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 170.0),
                decoration: _loading
                    ? const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: CustomTheme.loginGradientStart,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: CustomTheme.loginGradientEnd,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: LinearGradient(
                            colors: <Color>[
                              CustomTheme.loginGradientEnd,
                              CustomTheme.loginGradientStart
                            ],
                            begin: FractionalOffset(0.2, 0.2),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      )
                    : const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: CustomTheme.loginGradientStart,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: CustomTheme.loginGradientEnd,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: LinearGradient(
                            colors: <Color>[Colors.white, Colors.white],
                            begin: FractionalOffset(0.2, 0.2),
                            end: FractionalOffset(1.0, 1.0),
                            stops: <double>[0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                child: _loading
                    ? MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: CustomTheme.loginGradientEnd,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                                fontFamily: 'WorkSansBold'),
                          ),
                        ),
                        onPressed: () => {
                              userName == "" || passWord == ""
                                  ? CustomSnackBar(
                                      context,
                                      const Text(
                                          'Please Enter Username and Password.'))
                                  : {
                                      print("123"),
                                      signIn(userName.toString(), passWord),
                                      USERNAME = userName,
                                      setState(() => _loading = false),
                                    },
                            })
                    : CircularProgressIndicator(),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansMedium'),
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[
          //       Container(
          //         decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //               colors: <Color>[
          //                 Colors.white10,
          //                 Colors.white,
          //               ],
          //               begin: FractionalOffset(0.0, 0.0),
          //               end: FractionalOffset(1.0, 1.0),
          //               stops: <double>[0.0, 1.0],
          //               tileMode: TileMode.clamp),
          //         ),
          //         width: 100.0,
          //         height: 1.0,
          //       ),
          //       const Padding(
          //         padding: EdgeInsets.only(left: 15.0, right: 15.0),
          //         child: Text(
          //           'Or',
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 16.0,
          //               fontFamily: 'WorkSansMedium'),
          //         ),
          //       ),
          //       Container(
          //         decoration: const BoxDecoration(
          //           gradient: LinearGradient(
          //               colors: <Color>[
          //                 Colors.white,
          //                 Colors.white10,
          //               ],
          //               begin: FractionalOffset(0.0, 0.0),
          //               end: FractionalOffset(1.0, 1.0),
          //               stops: <double>[0.0, 1.0],
          //               tileMode: TileMode.clamp),
          //         ),
          //         width: 100.0,
          //         height: 1.0,
          //       ),
          //     ],
          //   ),
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(top: 10.0, right: 40.0),
          //       child: GestureDetector(
          //         onTap: () => CustomSnackBar(
          //             context, const Text('Facebook button pressed')),
          //         child: Container(
          //           padding: const EdgeInsets.all(15.0),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.white,
          //           ),
          //           child: const Icon(
          //             FontAwesomeIcons.facebookF,
          //             color: Color(0xFF0084ff),
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 10.0),
          //       child: GestureDetector(
          //         onTap: () => CustomSnackBar(
          //             context, const Text('Google button pressed')),
          //         child: Container(
          //           padding: const EdgeInsets.all(15.0),
          //           decoration: const BoxDecoration(
          //             shape: BoxShape.circle,
          //             color: Colors.white,
          //           ),
          //           child: const Icon(
          //             FontAwesomeIcons.google,
          //             color: Color(0xFF0084ff),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _toggleSignInButton() {
    CustomSnackBar(context, const Text('Login button pressed'));
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}

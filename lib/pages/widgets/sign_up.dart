import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customer_app/theme.dart';
import 'package:customer_app/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:customer_app/pages/details.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodeName = FocusNode();

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController =
      TextEditingController();

  dynamic userName, passWord, cPassWord;

  @override
  void dispose() {
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeEmail.dispose();
    focusNodeName.dispose();
    super.dispose();
  }

  void signUp(String userN, dynamic pass) async {
    Details details = new Details(userN, pass);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => details),
    );
    // final String url = 'https://apifoodapp.herokuapp.com/createUser';
    //
    // Map<String, dynamic> data = <String, dynamic>{
    //   'username': userN,
    //   'password': pass
    // };
    //
    // http.Response response = await http.post(Uri.parse(url), body: data);
    //
    // if (response.statusCode == 200) {
    //   String data = response.body;
    //   if (data == 'true') {
    //     CustomSnackBar(context, const Text('Next page'));
    //
    //     signUpPage2 sign2 = new signUpPage2(name, email, password);
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => sign2),
    //     );
    //
    //   } else {
    //     CustomSnackBar(context, Text('Error: ' + data));
    //   }
    // } else {
    //   print(response.statusCode);
    // }
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
                  height: 300.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
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
                            focusNodeEmail.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                      //   child: TextField(
                      //     focusNode: focusNodeEmail,
                      //     controller: signupEmailController,
                      //     keyboardType: TextInputType.emailAddress,
                      //     autocorrect: false,
                      //     style: const TextStyle(
                      //         fontFamily: 'WorkSansSemiBold',
                      //         fontSize: 16.0,
                      //         color: Colors.black),
                      //     decoration: const InputDecoration(
                      //       border: InputBorder.none,
                      //       icon: Icon(
                      //         FontAwesomeIcons.envelope,
                      //         color: Colors.black,
                      //       ),
                      //       hintText: 'Email Address',
                      //       hintStyle: TextStyle(
                      //           fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                      //     ),
                      //     onSubmitted: (_) {
                      //       focusNodePassword.requestFocus();
                      //     },
                      //   ),
                      // ),
                      // Container(
                      //   width: 250.0,
                      //   height: 1.0,
                      //   color: Colors.grey[400],
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextPassword,
                          autocorrect: false,
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
                              color: Colors.black,
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
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
                            focusNodeConfirmPassword.requestFocus();
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
                          focusNode: focusNodeConfirmPassword,
                          controller: signupConfirmPasswordController,
                          obscureText: _obscureTextConfirmPassword,
                          autocorrect: false,
                          onChanged: (value) {
                            setState(() {
                              cPassWord = value;
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
                              color: Colors.black,
                            ),
                            hintText: 'Confirmation',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignupConfirm,
                              child: Icon(
                                _obscureTextConfirmPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            _toggleSignUpButton();
                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 280.0),
                decoration: const BoxDecoration(
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
                ),
                child: MaterialButton(
                    highlightColor: Colors.transparent,
                    splashColor: CustomTheme.loginGradientEnd,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        'NEXT >>',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: 'WorkSansBold'),
                      ),
                    ),
                    onPressed: () => {
                          (userName == "" || passWord == "")
                              ? CustomSnackBar(
                                  context,
                                  const Text(
                                      'Please Enter Username and Password.'))
                              : passWord != cPassWord
                                  ? CustomSnackBarRed(
                                      context, const Text('Password Mismatch'))
                                  : signUp(userName.toString(), passWord),
                        }),
              )
            ],
          ),
        ],
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

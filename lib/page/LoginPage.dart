import 'dart:async';

import 'package:desasa/request/RequestAPI.dart';
import 'package:desasa/util/CustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'MenuUtama.dart';

Timer timer;

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double percentage = 0.0;

  int number = 0;

  bool isShowPassword = false;

  final _textEmail = TextEditingController();
  final _textPassword = TextEditingController();
  bool _validateEmail = true;
  bool _validateEmailFormat = true;
  bool _validatePassword = true;

  var focusEmail = new FocusNode();
  var focusPassword = new FocusNode();

  void onClickLogin() {
    setState(() {
      _validateEmail = true;
      _validateEmailFormat = true;
      _validatePassword = true;

      if (_textEmail.text.isEmpty) {
        // print("Email kosong");
        _validateEmail = false;
        focusEmail.requestFocus();
        return;
      } else if (!isEmail(_textEmail.text.toString())) {
        // print("Format Email salah");
        _validateEmailFormat = false;
        focusEmail.requestFocus();
        return;
      } else if (_textPassword.text.isEmpty) {
        // print("Password kosong");
        _validatePassword = false;
        focusPassword.requestFocus();
        return;
      } else {
        // print("AMAANN");
        _validateEmail = true;
        _validateEmailFormat = true;
        _validatePassword = true;

        Future<dynamic> getResponseLogin() async {
          var data = await attemptLogin(
              context: context,
              email: _textEmail.text.toString(),
              password: _textPassword.text.toString());

          // var data = await attemptLogin(
          //     context: context,
          //     email: "taufan.tanjung@dipa.co.id",
          //     password: "lantaiem");

          // Navigator.of(context).pop();
          // print(data);
          if (data != null) {
            if (data['error'] == "NO") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return MenuUtama();
              }));
            }
          }
        }

        getResponseLogin();
      }
    });
  }

  _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogForgotPassword();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'hero',
        child: Image(
          image: AssetImage("images/gedung720.jpg"),
          fit: BoxFit.cover,
        )
        // CircleAvatar(
        //   backgroundColor: Colors.transparent,
        //   radius: 48.0,
        //   child: Image.asset('images/gedung720.jpg'),
        // ),
        );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'putu.roby@yahoo.com',
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        icon: Icon(Icons.email),
        labelText: "Email",
        hintText: 'Email',
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final email2 = Row(
      children: <Widget>[
        Flexible(
          child: new Icon(
            Icons.email,
            color: Colors.blue[700],
          ),
          flex: 1,
        ),
        Flexible(
          child: TextFormField(
            focusNode: focusEmail,
            controller: _textEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(fontSize: 13),
            autofocus: false,
            // initialValue: 'putu.roby@yahoo.com',
            decoration: InputDecoration(
              // errorStyle: TextStyle(color: Colors.red, fontSize: 16),
              // errorText: "sas",
              hintText: "Email",
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
          ),
          flex: 6,
        ),
        // Flexible(
        //   child:
        //       new Tooltip(message: "Hello ToolTip", child: new Text("Press")),
        //   flex: 1,
        // )
      ],
    );

    final password2 = Row(
      children: <Widget>[
        Flexible(
          child: new Icon(
            Icons.vpn_key,
            color: Colors.blue[700],
          ),
          flex: 1,
        ),
        Flexible(
          child: TextFormField(
            focusNode: focusPassword,
            controller: _textPassword,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(fontSize: 13),
            autofocus: false,
            obscureText: !isShowPassword,
            // initialValue: '',
            decoration: InputDecoration(
              hintText: "Password",
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
          ),
          flex: 6,
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              // print(isShowPassword);

              setState(() {
                if (isShowPassword) {
                  isShowPassword = !isShowPassword;
                } else {
                  isShowPassword = !isShowPassword;
                }
                // print(isShowPassword);
              });
            },
            child: Image(
                image: (isShowPassword)
                    ? AssetImage("images/show.png")
                    : AssetImage("images/hide.png")),
          ),
          // child: new Icon(
          //   Icons.close,
          //   color: Colors.blue[700],
          // ),
        )
      ],
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'omrobbie password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: "Password",
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            onClickLogin();
          },
          color: Colors.red[800],
          child: Text(
            'Log In',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    final loginButton2 = Padding(
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 2,
        child: Container(
          width: 150,
          height: 40,
          child: Material(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.amber,
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                onClickLogin();
              },
              child: Center(
                  child: Text(
                "Login",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  colors: [Colors.red[800], Colors.red[200]],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot Password ?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        _showForgotPasswordDialog(context);
        // CustomDialog.showBasicAlertDialog(context, "success", "Success !");
      },
    );

    CustomDialog.declarPr(context);

    final textBannerApp = Text(
      "Dipa Application System",
      style: TextStyle(color: Colors.red),
    );

    final hasthtag =
        Text("#WorkWithNerNormal", style: TextStyle(color: Colors.red));

    final version =
        Text("Version 7.6", style: TextStyle(color: Colors.black87));

    // final widthScreen = MediaQuery.of(context).size.width;
    // final heightScreen = MediaQuery.of(context).size.height;

    final heightScreen =
        (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.height * 2;

    final widthScreen =
        (MediaQuery.of(context).orientation == Orientation.portrait)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.6;

    return Scaffold(
        body: Center(
      child: Container(
        width: widthScreen,
        height: heightScreen,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
                height: heightScreen * 0.48,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 0,
                      top: 0,
                      left: 0,
                      bottom: 0,
                      child: Container(
                        height: heightScreen * 0.48,
                        child: logo,
                      ),
                    ),
                    Positioned(
                      top: -15,
                      right: 15,
                      child: Container(
                          width: widthScreen * 0.23,
                          height: heightScreen * 0.23,
                          child: Image(image: AssetImage("images/logo.png"))),
                    ),
                  ],
                )),
            Container(
              height: heightScreen * 0.48,
              margin: EdgeInsets.only(left: 40, right: 40),
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: heightScreen * 0.01),
                        Visibility(
                          visible: (!_validateEmail || !_validateEmailFormat)
                              ? true
                              : false,
                          child: Text(
                            (!_validateEmail)
                                ? "Email Can't be Empty !"
                                : (!_validateEmailFormat)
                                    ? "Wrong Email Format !"
                                    : "",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: (!_validateEmail ||
                                            !_validateEmailFormat)
                                        ? Colors.red
                                        : Colors.blue[200],
                                    style: BorderStyle.solid)),
                            child: email2),
                        SizedBox(height: heightScreen * 0.01),
                        Visibility(
                          visible: !_validatePassword,
                          child: Text(
                            "Password Can't be Empty !",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: (!_validatePassword)
                                    ? Colors.red
                                    : Colors.blue[200],
                                style: BorderStyle.solid),
                          ),
                          child: password2,
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          loginButton2,
                          forgotLabel,
                          textBannerApp,
                          hasthtag,
                          version
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class DialogForgotPassword extends StatefulWidget {
  @override
  _DialogForgotPasswordState createState() => _DialogForgotPasswordState();
}

class _DialogForgotPasswordState extends State<DialogForgotPassword> {
  final _textEmailForgot = TextEditingController();
  bool _validateEmailForgot = true;
  bool _validateEmailForgotFormat = true;
  var focusEmailForgot = new FocusNode();

  void onClickProcessForgotPassword() {
    setState(() {
      _validateEmailForgot = true;
      _validateEmailForgotFormat = true;

      if (_textEmailForgot.text.isEmpty) {
        _validateEmailForgot = false;
        focusEmailForgot.requestFocus();
        return;
      } else if (!isEmail(_textEmailForgot.text.toString())) {
        _validateEmailForgotFormat = false;
        focusEmailForgot.requestFocus();
      } else {
        _validateEmailForgot = true;
        _validateEmailForgotFormat = true;

        // percentage = 10;
        CustomDialog.showProgressDalogue(context);

        const oneSec = const Duration(seconds: 1);
        timer = new Timer.periodic(oneSec, (Timer t) {
          // print('hi!' + percentage.toString());

          // JIKA ADA SET STATE JANGAN UPDATE
          // CustomDialog.updateProgressDialogue(
          //     context, percentage, "Please Wait..");

          // percentage = percentage + 10;
        });

        Future.delayed(Duration(seconds: 5)).then((onValue) {
          CustomDialog.hideProgressDialogue(context);

          CustomDialog.showBasicAlertDialog(
              context, "success", "Proses berhasil !\nPeriksa Email Anda !");

          // JIKA ADA SET STATE JANGAN UPDATE
          // CustomDialog.updateProgressDialogue(context, 0, "Please Wait..");

          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new Text(
            "Lupa Password ?",
            style: TextStyle(color: Colors.blue[400], fontSize: 18),
            textAlign: TextAlign.right,
          ),
          new Text(
            "Masukan alamat email anda.",
            style: TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.right,
          ),
        ],
      ),
      content: new TextFormField(
        focusNode: focusEmailForgot,
        controller: _textEmailForgot,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        style: TextStyle(fontSize: 13),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          hintText: 'Email',
          errorText: (!_validateEmailForgot)
              ? "Email Can't Be Empty"
              : (!_validateEmailForgotFormat) ? "Wrong Email Format !" : null,
          contentPadding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: FlatButton(
                child: Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: FlatButton(
                child: Text('Process!'),
                onPressed: () {
                  onClickProcessForgotPassword();
                },
              ),
            )
          ],
        )
      ],
    );
  }
}

/*
Future<dynamic> attemptLogin(
    {BuildContext context, String email, String password}) async {
  CustomDialog.showProgressDalogue(context);

  String apiURL = "http://app.mydipa.co.id/android/login2.php";
  // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON

  var apiResult = await http.post(apiURL, body: {
    "email": email,
    "password": password,
    "token": "hBXaklXbwBXYkl2byRmbhRWavJHZuFWYwlGZwBXY",
    "device_id": "test from flutter"
  });

  print('Response status: ${apiResult.statusCode}');

  var data = null;

  if (apiResult.statusCode == 200) {
    var jsonObject = json.decode(apiResult.body);

    data = jsonObject['data'];

    data['statusCode'] = apiResult.statusCode;

    var error = data['error'];

    var message = data['message'];

    var isi = data['isi'];
    var session = data['session'];

    var statusCode = data['statusCode'];

    saveDataLogin(isi, email, password, session);

    print(error);
    print(message);
    print(isi);
    print(session);
    print(statusCode);
  }

  CustomDialog.hideProgressDialogue(context);
  // Navigator.of(context).pop();

  // setState(() {
  //   //RESPONSE YANG DIDAPATKAN DARI API TERSEBUT DI DECODE
  //   var content = json.decode(res.body);
  //   //KEMUDIAN DATANYA DISIMPAN KE DALAM VARIABLE data,
  //   //DIMANA SECARA SPESIFIK YANG INGIN KITA AMBIL ADALAH ISI DARI KEY hasil
  //   data = content['hasil'];
  // });
  return data;
}

void saveDataLogin(
    var isi, String email, String password, String session) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("SESSION_STATUS", true);
  preferences.setString("KEY_USER", email);
  preferences.setString("KEY_PASS", password);
  preferences.setString("KEY_SESSION", session);
  preferences.setString("KEY_REALNAME", isi['REALNAME']);
}
*/

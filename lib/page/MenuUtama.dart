import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuUtama extends StatefulWidget {
  @override
  _MenuUtamaState createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  String nama = "";

  Future<String> getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString("KEY_REALNAME") ?? "No Nama";
  }

  @override
  Widget build(BuildContext context) {
    getNama().then((value) {
      // print(nama);

      setState(() {
        nama = value;
      });
      //  print(nama);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("HELLO " + nama),
            ],
          ),
        ),
      ),
    );
  }
}

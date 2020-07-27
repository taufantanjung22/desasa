import 'package:desasa/config/Keys.dart';
import 'package:desasa/page/AboutActivity.dart';
import 'package:desasa/page/Absensi.dart';
import 'package:desasa/request/RequestAPI.dart';
import 'package:desasa/util/CustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drawerbehavior/drawerbehavior.dart';

class MenuUtama extends StatefulWidget {
  @override
  _MenuUtamaState createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  var REAL_NAME = "";
  var NIK = "";
  var HOST = "";
  var User = null;
  var Pass = null;
  var SESSION_STATUS = false;
  var PICTURE = null;

  int selectedMenuItemId;

  void loadSharedPreferences() {
    Future<String> getRealName() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(Keys.KEY_REALNAME) ?? "No Nama";
    }

    Future<String> getNIK() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(Keys.KEY_NIK) ?? "No NIK";
    }

    Future<String> getHostName() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(Keys.KEY_HOST) ?? "No HOST";
    }

    Future<String> getPicture() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      return pref.getString(Keys.KEY_PROPIC) ?? null;
    }

    getRealName().then((value) {
      setState(() {
        REAL_NAME = value;
      });
    });

    getNIK().then((value) {
      setState(() {
        NIK = value;
      });
    });

    getHostName().then((value) {
      setState(() {
        HOST = value;
      });
    });

    getPicture().then((value) {
      setState(() {
        PICTURE = value;
      });
    });
  }

  Future<String> getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.KEY_USER) ?? null;
  }

  Future<String> getPass() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(Keys.KEY_PASS) ?? null;
  }

  Future<bool> getStatusSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(Keys.SESSION_STATUS) ?? false;
  }

  Future<dynamic> getResponseLogin() async {
    // var data = await attemptLogin(
    //     context: context,
    //     email: _textEmail.text.toString(),
    //     password: _textPassword.text.toString());

    var data =
        await attemptLogin(context: context, email: User, password: Pass);

    // Navigator.of(context).pop();
    // print(data);
    if (data != null) {
      if (data['error'] == "NO") {
        loadSharedPreferences();
      }
    }
  }

  @override
  void initState() {
    // selectedMenuItemId = menuWithIcon.items[0].id;
    // selectedMenuItemId = 0;

    getUser().then((value) {
      setState(() {
        User = value;
      });
    });
    getPass().then((value) {
      Pass = value;
    });

    getStatusSession().then((value) {
      setState(() {
        SESSION_STATUS = value;
        if (SESSION_STATUS) {
          if (User != null && Pass != null) {
            getResponseLogin();
          } else {
            CustomDialog.showBasicAlertDialog(
                context, "error", "Gagal Load Username dan Password");
          }
        } else {
          CustomDialog.showBasicAlertDialog(
              context, "error", "Gagal Load Session");
        }
      });
    });

    super.initState();
  }

  Widget headerView(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 130,
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/kotak.png"), fit: BoxFit.cover),
          ),
          child: Row(
            children: <Widget>[
              new Container(
                  width: 90.0,
                  height: 90.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: (PICTURE != null && PICTURE != "null")
                              ? NetworkImage(
                                  "http://app.mydipa.co.id/" + PICTURE)
                              : AssetImage("images/empty.png")))),
              Container(
                  margin: EdgeInsets.only(left: 16, top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          HOST,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      Text(
                        REAL_NAME,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white.withAlpha(200)),
                      ),
                      Text(
                        NIK,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ))
            ],
          ),
        ),
        Divider(
          color: Colors.white.withAlpha(200),
          height: 16,
        )
      ],
    );
  }

  Widget footerView(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          color: Colors.white.withAlpha(200),
          height: 16,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
          child: Row(
            children: <Widget>[
              new Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/logo.png")))),
              Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "John Witch",
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        "test123@gmail.com",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle
                            .copyWith(color: Colors.white.withAlpha(200)),
                      )
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // getNama().then((value) {
    //   // print(nama);

    //   setState(() {
    //     nama = value;
    //   });
    //   //  print(nama);
    // });

    return DrawerScaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[800],
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Dipa Application System",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              Text(
                "#HashTag",
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.w200, fontSize: 17),
              )
            ],
          ),
          actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})]),
      drawers: [
        SideDrawer(
          percentage: 0.6,
          menu: menuWithIcon,
          headerView: headerView(context),
          // footerView: footerView(context),
          direction: Direction.left,
          animation: true,
          alignment: Alignment.topLeft,
          color: Colors.grey[200],
          selectedItemId: 0,
          onMenuItemSelected: (itemId) {
            setState(() {
              print(itemId);
              print(menu.items[itemId].title);
              if (itemId == 0) {
                // Navigator.pop(context);
                // selectedMenuItemId = itemId;
              } else if (itemId == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutActivity();
                }));
              } else {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Absensi();
                }));
              }
            });
          },
        )
      ],
      builder: (context, id) {
        return Center(child: Text("Ini Menu Utama"));
      },
      // builder: (context, id) => IndexedStack(
      //   index: id,
      //   children: menu.items
      //       .map((e) => Center(
      //             child: Text("Page~${e.title}"),
      //           ))
      //       .toList(),
      // ),
    );
  }
}

List<MenuItem> items = [
  new MenuItem<int>(
    id: 0,
    title: 'THE PADDOCK',
    icon: Icons.fastfood,
  ),
  new MenuItem<int>(
    id: 1,
    title: 'THE HERO',
    icon: Icons.person,
  ),
  new MenuItem<int>(
    id: 2,
    title: 'HELP US GROW',
    icon: Icons.terrain,
  ),
  new MenuItem<int>(
    id: 3,
    title: 'SETTINGS',
    icon: Icons.settings,
  ),
];

final menu = Menu(
  items: items.map((e) => e.copyWith(icon: null)).toList(),
);

final menuWithIcon = Menu(
  items: items,
);

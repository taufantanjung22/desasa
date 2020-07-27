import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

_showCupertinoDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => new CupertinoAlertDialog(
            title: new Text("Cupertino Dialog"),
            content: new Text("Hey! I'm Coflutter!"),
            actions: <Widget>[
              FlatButton(
                child: Text('Close me!'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
}

_showMaterialDialog(BuildContext context, String type, String msg) {
  if (type == "success") {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              title: SizedBox(
                  height: 150,
                  child: LottieBuilder.asset(
                    "assets/success.json",
                    repeat: false,
                  )),
              content: Text(
                msg,
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  } else if (type == "error") {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: EdgeInsets.only(top: 10.0),
              title: SizedBox(
                  height: 150,
                  child: LottieBuilder.asset(
                    "assets/error.json",
                    repeat: false,
                  )),
              content: Text(
                msg,
                style: GoogleFonts.poppins(),
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Close me!'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}

ProgressDialog pr;

_pr(BuildContext context) {
  pr = ProgressDialog(
    context,
    type: ProgressDialogType.Download,
    textDirection: TextDirection.ltr,
    isDismissible: true,
//      customBody: LinearProgressIndicator(
//        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//        backgroundColor: Colors.white,
//      ),
  );

  pr.style(
//      message: 'Downloading file...',
    message: 'Please Wait..',
    borderRadius: 10.0,
    backgroundColor: Colors.white,
    elevation: 10.0,
    insetAnimCurve: Curves.easeInOut,
    progress: 0.0,
    //BISA DIMATIKAN
    // progressWidget: Container(
    //     padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
    // progressWidgetAlignment: Alignment.center,
    maxProgress: 100.0,
    progressTextStyle: TextStyle(
        color: Colors.black, fontSize: 0, fontWeight: FontWeight.w400),
    messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
  );
}

_showPr(BuildContext context) async {
  await pr.show();
}

_hidePr(BuildContext context) {
  // METODE 1
  pr.hide().whenComplete(() {
    // print("pr.isShowing()");
    // print(pr.isShowing());
  });

  // METODE 2
  // if (pr.isShowing()) {
  //   pr.hide().then((isHidden) {
  //     print("isHidden");
  //     print(isHidden);
  //   });
  // }

  // METODE 3 RECOMENDED
  // UPDATE 27 07 2020 ADA BUGS KETIKA HIDDING BERTURUT TURUT
  // Navigator.of(context).pop();
}

_updatePr(BuildContext context, double percentage, String message) {
  pr.update(
    progress: percentage,
    message: message,
    // progressWidget: Container(
    //     padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
    maxProgress: 100.0,
    progressTextStyle: TextStyle(
        color: Colors.transparent, fontSize: 0, fontWeight: FontWeight.w400),
    messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.w600),
  );
}

_onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      );
    },
  );
  new Future.delayed(new Duration(seconds: 3), () {
    Navigator.pop(context); //pop dialog
    // _login();
  });
}

_showSweetAlertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return RichAlertDialog(
          alertTitle: richTitle("Success"),
          alertSubtitle: richSubtitle("This is a Sucess alert"),
          alertType: RichAlertType.SUCCESS,
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

class CustomDialog {
  static void foo() {
    print("1234");
  }

  static void showCupertinowDialog(BuildContext context) {
    return _showCupertinoDialog(context);
  }

  static void showBasicAlertDialog(
      BuildContext context, String type, String msg) {
    return _showMaterialDialog(context, type, msg);
  }

  static void declarPr(BuildContext context) {
    return _pr(context);
  }

  static void showProgressDalogue(BuildContext context) {
    return _showPr(context);
  }

  static void hideProgressDialogue(BuildContext context) {
    return _hidePr(context);
  }

  static void updateProgressDialogue(
      BuildContext context, double percentage, String message) {
    return _updatePr(context, percentage, message);
  }

  static void onLoading(BuildContext context) {
    return _onLoading(context);
  }

  // https://github.com/JideGuru/rich-alert-dialogs
  static void showSweetAlertDialog(BuildContext context) {
    return _showSweetAlertDialog(context);
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:desasa/config/Keys.dart';
import 'package:desasa/config/Urls.dart';
import 'package:http/http.dart' as http;
import 'package:desasa/util/CustomDialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> attemptLogin(
    {BuildContext context, String email, String password}) async {
  CustomDialog.showProgressDalogue(context);

  String apiURL = Urls.LOGIN_URL;

  // MEMINTA DATA KE SERVER DENGAN KETENTUAN YANG DI ACCEPT ADALAH JSON

  var apiResult;
  try {
    apiResult = await http.post(apiURL, body: {
      "email": email,
      "password": password,
      "token": "hBXaklXbwBXYkl2byRmbhRWavJHZuFWYwlGZwBXY",
      "device_id": "test from flutter"
    });

    if (apiResult.statusCode == 200) {
      // print(apiResult.statusCode.toString().substring(0, 1));
      var data = null;

      try {
        CustomDialog.hideProgressDialogue(context);
        var jsonObject = json.decode(apiResult.body);

        data = jsonObject['data'];

        data['statusCode'] = apiResult.statusCode.toString();

        var error = data['error'];

        var message = data['message'];

        var isi = data['isi'];
        var session = data['session'];

        var statusCode = data['statusCode'];

        var menu = data['menu'];
        var host_name = data['host_name'];
        var host_id = data['host_id'];

        if (error == "YES") {
          CustomDialog.showBasicAlertDialog(context, "error", message);

          return null;
        } else if (error == "NO") {
          return saveDataLogin(
              isi, email, password, session, menu, host_id, host_name, data);
        }

        // return data;
        // print(error);
        // print(message);
        // print(isi);
        // print(session);
        // print(statusCode);
      } catch (error) {
        CustomDialog.hideProgressDialogue(context);

        CustomDialog.showBasicAlertDialog(
            context, "error", "Parsing JSON Login salah ! \n Hubungi IT");
        return null;
      }
    } else {
      CustomDialog.hideProgressDialogue(context);

      if (apiResult.statusCode.toString().substring(0, 1) == "4") {
        if (apiResult.statusCode.toString() == "404") {
          CustomDialog.showBasicAlertDialog(context, "error", "404 NOT FOUND");
        }
      }

      return null;
    }
  } catch (error) {
    CustomDialog.hideProgressDialogue(context);

    CustomDialog.showBasicAlertDialog(
        context, "error", "Gagal menghubungkan ! \n Periksa Koneksi Anda !");
    // print("error : $error");

    // print(error);
    return null;
  }
}

void saveDataLogin(var isi, String email, String password, String session,
    var menu, var host_id, var host_name, var data) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool(Keys.SESSION_STATUS, true);
  preferences.setString(Keys.KEY_USER, email);
  preferences.setString(Keys.KEY_PASS, password);
  preferences.setString(Keys.KEY_NIK, isi['NIK']);
  preferences.setString(Keys.KEY_REALNAME, isi['REALNAME']);
  preferences.setString(Keys.KEY_PROPIC, isi['PICTURE']);
  preferences.setString(Keys.KEY_ROLE_ID, isi['ROLE_ID']);
  preferences.setString(Keys.KEY_HOST_ID, isi['HOST_ID']);
  preferences.setString(Keys.KEY_HOST, isi['HOST']);
  preferences.setString(Keys.KEY_CRM_USERID, isi['CRM_USER_ID']);
  preferences.setString(Keys.KEY_DEPARTEMEN, isi['NAMA_DEPARTEMEN']);
  preferences.setString(Keys.KEY_TGL_LAHIR, isi['TGL_LAHIR']);
  preferences.setString(Keys.KEY_CODE, isi['CODE']);
  preferences.setString(Keys.KEY_POSTYPE, isi['POSTYPE']);
  preferences.setString(Keys.KEY_SESSION, session);

  print(data);
  print(isi);
  print(menu);
  print(host_id);
  print(host_name);

  print(preferences.getString(Keys.KEY_USER) ?? "No User");
  print(preferences.getString(Keys.KEY_PASS) ?? "No Pass");
  print(preferences.getString(Keys.KEY_NIK) ?? "No NIK");
  print(preferences.getString(Keys.KEY_REALNAME) ?? "No Nama");
  print(preferences.getString(Keys.KEY_HOST) ?? "No Host");

  return data;
}

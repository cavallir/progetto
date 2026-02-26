import 'package:flutter/material.dart';
import 'package:save_google_sheet/feedback_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'costanti.dart';

class FormController {
  final void Function(String) callback;

  static const STATUS_SUCCESS = "SUCCESS";
  FormController(this.callback);

  void submitForm(FeedBackForm feedBackForm) async {
    try {
      String stringa = URL + feedBackForm.toParams();

      await http.get(Uri.parse(URL + feedBackForm.toParams())).then((response) {
        //callback(convert.jsonDecode(response.body)['status']);
        callback(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  void submitCommandForm(FeedBackForm feedBackForm, String cmd) async {
    try {
      String stringa = URL + feedBackForm.cmdParams(cmd);
      await http
          .get(Uri.parse(URL + feedBackForm.cmdParams(cmd)))
          .then((response) {
        //callback(convert.jsonDecode(response.body)['status']);
        callback(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }
}

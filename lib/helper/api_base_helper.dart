import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:invo_weathrify/helper/errors.dart';
import 'package:invo_weathrify/helper/getx_helper.dart';
import 'package:invo_weathrify/helper/global_variables.dart';
import 'package:invo_weathrify/helper/urls.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> getMethod({required String url}) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    try {
      Uri urlValue = Uri.parse(Urls.baseURL + url);
      http.Response response = await http
          .get(urlValue, headers: header)
          .timeout(const Duration(seconds: 20));

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      return parsedJSON;
    } on SocketException {
      GlobalVariables.showLoader.value = false;
      GetXHelper.showSnackBar(message: Errors.noInternetError);
      throw Errors.noInternetError;
    } on TimeoutException {
      GlobalVariables.showLoader.value = false;
      GetXHelper.showSnackBar(message: Errors.timeOutException);
      throw Errors.timeOutException + url;
    } on FormatException catch (_) {
      GlobalVariables.showLoader.value = false;
      GetXHelper.showSnackBar(message: Errors.formatException);
      throw Errors.formatException;
    } catch (e) {
      GlobalVariables.showLoader.value = false;
      GetXHelper.showSnackBar(message: Errors.generalApiError);
      throw e.toString();
    }
  }
}

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invo_weathrify/helper/api_base_helper.dart';
import 'package:invo_weathrify/helper/getx_helper.dart';
import 'package:invo_weathrify/helper/global_variables.dart';
import 'package:invo_weathrify/helper/urls.dart';
import 'package:invo_weathrify/screens/home/weather_model.dart';
import 'package:invo_weathrify/screens/locations/locations_view.dart';

class HomeViewModel extends GetxController {
  Rx<WeatherModel> weatherModel = WeatherModel().obs;
  RxString location = 'Islamabad, Pakistan'.obs;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    getLastLocationAndUpdate();
    super.onReady();
  }

  getLastLocationAndUpdate() {
    ///Get Last Selected Location
    location.value = GetStorage().read('lastLocation') ?? 'Islamabad, Pakistan';

    ///Get Last Stored Data
    var data = GetStorage().read(location.value) ?? <String, dynamic>{};
    weatherModel.value = WeatherModel.fromJson(data);

    print(weatherModel.toJson());

    ///Update latest data
    getWeatherUpdate();
  }

  changeLocation() async {
    var result = await Get.to(() => LocationsView());

    ///Set New Location
    if (result != null) {
      location.value = result;
      GetStorage().write('lastLocation', location.value);
      getLastLocationAndUpdate();
    }
  }

  getWeatherUpdate() {
    String url = '${Urls.getWeatherData}q=${location.value}';
    GlobalVariables.showLoader.value = true;
    ApiBaseHelper().getMethod(url: url).then((parsedJson) {
      GlobalVariables.showLoader.value = false;
      if (parsedJson['cod'] == 200) {
        weatherModel.value = WeatherModel.fromJson(parsedJson);
        GetStorage().write(location.value, parsedJson);
        GetXHelper.showSnackBar(message: 'Weather updated successfully');
      } else {
        GetXHelper.showSnackBar(message: parsedJson['message']);
      }
    }).catchError((e) {
      print(e);
    });
  }

  String convertTimeStampToTime(int? timeStamp) {
    String time = 'N/A';
    if (timeStamp != null) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      time = DateFormat("hh:mm a").format(dateTime);
    }

    return time;
  }

  String getCurrentDate() {
    String date = '';
    DateTime dateTime = DateTime.now();

    date = DateFormat("EEEE | MMM dd").format(dateTime);

    return date;
  }
}

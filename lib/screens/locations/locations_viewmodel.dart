import 'package:get/get.dart';

class LocationsViewModel extends GetxController {
  List<String> allLocationsList = [];
  List<String> filteredLocationsList = [
    'Rawalpindi, Pakistan',
    'Islamabad, Pakistan',
    'Lahore, Pakistan',
    'Karachi, Pakistan',
    'Multan, Pakistan',
    'Faisalabad, Pakistan',
    'Quetta, Pakistan',
    'Peshawar, Pakistan',
    'Gujranwala, Pakistan',
    'Hyderabad, Pakistan',
  ].obs;

  @override
  void onReady() {
    allLocationsList.addAll(filteredLocationsList);
    super.onReady();
  }

  onSearchLocation(String value) {
    filteredLocationsList.clear();
    filteredLocationsList.addAll(allLocationsList.where(
      (e) => e.toLowerCase().contains(value.toLowerCase()),
    ));
  }

  onSelectLocation(int index) {
    Get.back(result: filteredLocationsList[index]);
  }
}

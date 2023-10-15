import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invo_weathrify/helper/theme_helper.dart';
import 'package:invo_weathrify/screens/locations/locations_viewmodel.dart';
import 'package:invo_weathrify/widgets/custom_textfields.dart';

class LocationsView extends StatelessWidget {
  LocationsView({super.key});

  final LocationsViewModel viewModel = Get.put(LocationsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [searchTxtField(), listView()],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('Locations'),
    );
  }

  Widget searchTxtField() {
    return CustomTextField(
      hint: 'Search Location...',
      prefixIcon: Icons.location_on_outlined,
      onChanged: (value) {
        viewModel.onSearchLocation(value);
      },
    );
  }

  Widget listView() {
    return Expanded(
      child: Obx(
        () => (viewModel.filteredLocationsList.isNotEmpty)
            ? ListView.separated(
                padding: const EdgeInsets.only(top: 20),
                itemBuilder: (context, index) {
                  return listViewItem(index);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: viewModel.filteredLocationsList.length)
            : const Center(
                child: Text('Sorry! No Location Found'),
              ),
      ),
    );
  }

  Widget listViewItem(int index) {
    return ListTile(
      onTap: () {
        viewModel.onSelectLocation(index);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Colors.white.withOpacity(0.2),
      leading: const Icon(
        Icons.location_on_outlined,
        color: Colors.white,
        size: 22,
      ),
      title: Text(
        viewModel.filteredLocationsList[index],
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

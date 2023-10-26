import 'dart:io';

import 'package:CarRescue/src/configuration/frontend_configs.dart';
import 'package:CarRescue/src/models/vehicle_item.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/car_view/widgets/add_car_view.dart';
import 'package:CarRescue/src/presentation/view/car_owner_view/car_view/widgets/car_card.dart';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CarListView extends StatefulWidget {
  final String userId;

  const CarListView({super.key, required this.userId});
  @override
  _CarListViewState createState() => _CarListViewState();
}

enum SortingOption { byName, defaultSort }

class _CarListViewState extends State<CarListView> {
  List<Vehicle> carData = [];
  SortingOption selectedSortingOption = SortingOption.defaultSort;
  String searchQuery = '';
  bool isLoading = true;
  bool isAscending = true;

  @override
  void initState() {
    super.initState();
    fetchCarOwnerCar(widget.userId).then((data) {
      final carList = (data['data'] as List<dynamic>)
          .map((carData) => Vehicle(
                id: carData['id'],
                manufacturer: carData['manufacturer'],
                licensePlate: carData['licensePlate'],
                status: carData['status'],
                vinNumber: carData['vinNumber'],
                type: carData['type'],
                color: carData['color'],
                manufacturingYear: carData['manufacturingYear'],
                carRegistrationFont: carData['carRegistrationFont'],
                carRegistrationBack: carData['carRegistrationBack'],
              ))
          .toList();

      setState(() {
        carData = carList;
        isLoading = false;
      });
    });
  }

  Future<Map<String, dynamic>> fetchCarOwnerCar(String userId) async {
    final String apiUrl =
        'https://rescuecapstoneapi.azurewebsites.net/api/Vehicle/GetAllOfUser?id=$userId';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data from API');
    }
  }

  List<Vehicle> sortCarsByName(List<Vehicle> cars, bool ascending) {
    return List.from(cars)
      ..sort((a, b) {
        final comparison = a.manufacturer.compareTo(b.manufacturer);
        return ascending ? comparison : -comparison;
      });
  }

  List<Vehicle> searchCars(List<Vehicle> cars, String query) {
    query = query.toLowerCase();
    return cars.where((car) {
      final manufacturer = car.manufacturer.toLowerCase();
      final licensePlate = car.licensePlate.toLowerCase();
      return manufacturer.contains(query) || licensePlate.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Vehicle> filteredCars = searchCars(carData, searchQuery);

    // Apply sorting when the user selects "Sort by Name"
    if (selectedSortingOption == SortingOption.byName) {
      filteredCars = sortCarsByName(filteredCars, isAscending);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Xe của tôi",
          style: TextStyle(
            color: FrontendConfigs.kPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (!isLoading) // Only show the sorting option button when data is loaded
            IconButton(
              onPressed: () {
                setState(() {
                  selectedSortingOption =
                      selectedSortingOption == SortingOption.byName
                          ? SortingOption.defaultSort
                          : SortingOption.byName;
                  // Toggle the sorting order
                  isAscending = !isAscending;
                });
              },
              icon: Icon(
                Icons.sort_by_alpha,
                color: FrontendConfigs.kIconColor,
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Column(
          children: [
            TextField(
              onChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              },
              decoration: InputDecoration(
                labelText: 'Tìm kiếm bằng tên hoặc biển số',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: filteredCars
                            .map((vehicle) => CarCard(vehicle: vehicle))
                            .toList(),
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddCarScreen(
                      userId: widget.userId,
                    )),
          );
          if (result != null && result) {
            _handleRefresh();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    try {
      final data = await fetchCarOwnerCar(widget.userId);
      final carList = (data['data'] as List<dynamic>)
          .map((carData) => Vehicle(
                id: carData['id'],
                manufacturer: carData['manufacturer'],
                licensePlate: carData['licensePlate'],
                status: carData['status'],
                vinNumber: carData['vinNumber'],
                type: carData['type'],
                color: carData['color'],
                manufacturingYear: carData['manufacturingYear'],
                carRegistrationFont: carData['carRegistrationFont'],
                carRegistrationBack: carData['carRegistrationBack'],

                //... your properties mapping
              ))
          .toList();

      setState(() {
        carData = carList;
        isLoading = false;
      });
    } catch (e) {
      print("Error during refresh: $e");
      // Optionally show a message to the user
    }
  }
}

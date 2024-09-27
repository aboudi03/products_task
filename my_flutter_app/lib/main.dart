import 'package:flutter/material.dart';
import 'features/home/presentation/views/home_view.dart';
import 'features/home/product_management/domain/models/product_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'License Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(
        productList: [], // Pass an empty list initially
        regionList: ['North America', 'Europe', 'Asia'], // List of regions
      ),
    );
  }
}

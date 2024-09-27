import 'package:flutter/material.dart';
import 'package:my_flutter_app/features/home/product_management/domain/models/product_model.dart';

import '../../product_management/data/presentation/views/product_form.dart';

class HomeView extends StatefulWidget {
  final List<Product> productList;
  final List<String> regionList;

  HomeView({Key? key, required this.productList, required this.regionList})
      : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? _selectedRegion;

  // Filter products based on the selected region
  List<Product> _getFilteredProducts() {
    if (_selectedRegion == null) {
      return widget.productList; // Show all products if no region is selected
    }
    return widget.productList
        .where((product) => product.regionId == _selectedRegion)
        .toList();
  }

  void _navigateToAddProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductForm(productList: widget.productList),
      ),
    ).then((_) {
      setState(() {}); // Refresh the view after returning from ProductForm
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      widget.productList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _getFilteredProducts();

    return Scaffold(
      appBar: AppBar(
        title: Text('License Management System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown Button to Select Region
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedRegion,
                    hint: Text('Select Region'),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRegion = newValue;
                      });
                    },
                    items: widget.regionList
                        .map<DropdownMenuItem<String>>((String region) {
                      return DropdownMenuItem<String>(
                        value: region,
                        child: Text(region),
                      );
                    }).toList(),
                  ),
                ),
                // Reset Button to Clear Region Filter
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _selectedRegion = null;
                    });
                  },
                  tooltip: 'Reset Region Filter',
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              _selectedRegion == null
                  ? 'All Products'
                  : 'Products in $_selectedRegion',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(child: Text('No products available.'))
                  : ListView.builder(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text(
                              'Price: \$${product.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteProduct(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProduct,
        child: Icon(Icons.add),
        tooltip: 'Add Product',
      ),
    );
  }
}

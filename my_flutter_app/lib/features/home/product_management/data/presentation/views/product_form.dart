import 'package:flutter/material.dart';
import 'package:my_flutter_app/core/utils/form_validators.dart';
import 'package:my_flutter_app/features/home/product_management/domain/models/product_model.dart';
import 'product_list_view.dart';

class ProductForm extends StatefulWidget {
  final List<Product> productList;
  final List<String> regionList; // Pass the list of regions

  ProductForm({
    Key? key,
    required this.productList,
    required this.regionList, // Required parameter for regions
  }) : super(key: key);

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController regionNameController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  String? _selectedRegion; // Variable to store selected region
  bool _showRegionAttributes = false; // Flag to show/hide region attributes

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: int.parse(idController.text),
        name: nameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        imageUrl: imageController.text,
        regionId: widget.regionList
            .indexOf(_selectedRegion!), // Get the index of the selected region
      );

      setState(() {
        widget.productList.add(newProduct);
      });

      // Clear the form after submission
      _clearForm();
    }
  }

  void _clearForm() {
    idController.clear();
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    imageController.clear();
    countryController.clear();
    regionNameController.clear();
    zipCodeController.clear();
    _selectedRegion = null; // Clear the selected region
    _showRegionAttributes = false; // Hide region attributes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Insert Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: idController,
                decoration: InputDecoration(labelText: 'Product ID'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    FormValidators.validateInteger(value, 'Product ID'),
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) =>
                    FormValidators.validateString(value, 'Product Name'),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    FormValidators.validateString(value, 'Description'),
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    FormValidators.validateDouble(value, 'Price'),
              ),
              TextFormField(
                controller: imageController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) =>
                    FormValidators.validateString(value, 'Image URL'),
              ),
              // Dropdown for selecting region
              DropdownButtonFormField<String>(
                value: _selectedRegion,
                decoration: InputDecoration(labelText: 'Select Region'),
                items: widget.regionList.map((region) {
                  return DropdownMenuItem<String>(
                    value: region,
                    child: Text(region),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRegion = value; // Set the selected region
                    // Show region attributes if a region is selected
                    _showRegionAttributes = value != null;
                  });
                },
                validator: (value) =>
                    FormValidators.validateDropdown(value, 'region'),
              ),
              if (_showRegionAttributes) ...[
                // Region attributes fields
                TextFormField(
                  controller: countryController,
                  decoration: InputDecoration(labelText: 'Country'),
                  validator: (value) =>
                      FormValidators.validateString(value, 'Country'),
                ),
                TextFormField(
                  controller: regionNameController,
                  decoration: InputDecoration(labelText: 'Region Name'),
                  validator: (value) =>
                      FormValidators.validateString(value, 'Region Name'),
                ),
                TextFormField(
                  controller: zipCodeController,
                  decoration: InputDecoration(labelText: 'Zip Code'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      FormValidators.validateInteger(value, 'Zip Code'),
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addProduct,
                child: Text('Insert Product'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductListView(productList: widget.productList),
                    ),
                  );
                },
                child: Text('View Products'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

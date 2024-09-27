import 'package:flutter/material.dart';
import 'package:my_flutter_app/core/utils/form_validators.dart';
import 'package:my_flutter_app/features/home/product_management/domain/models/product_model.dart';
import 'product_list_view.dart';

class ProductForm extends StatefulWidget {
  final List<Product> productList;

  ProductForm({Key? key, required this.productList}) : super(key: key);

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
  final TextEditingController regionIdController = TextEditingController();

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: int.parse(idController.text),
        name: nameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        imageUrl: imageController.text,
        regionId: int.parse(regionIdController.text),
      );

      setState(() {
        widget.productList.add(newProduct);
      });

      // Clear the form after submission
      idController.clear();
      nameController.clear();
      descriptionController.clear();
      priceController.clear();
      imageController.clear();
      regionIdController.clear();
    }
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
              TextFormField(
                controller: regionIdController,
                decoration: InputDecoration(labelText: 'Region ID'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    FormValidators.validateInteger(value, 'Region ID'),
              ),
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

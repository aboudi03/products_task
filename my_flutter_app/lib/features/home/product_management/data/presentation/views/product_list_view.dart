import 'package:flutter/material.dart';
import 'package:my_flutter_app/features/home/product_management/domain/models/product_model.dart';

class ProductListView extends StatefulWidget {
  final List<Product> productList;

  ProductListView({Key? key, required this.productList}) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  void _deleteProduct(int index) {
    setState(() {
      widget.productList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: ListView.builder(
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          final product = widget.productList[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _deleteProduct(index);
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyProductsScreen extends StatefulWidget {
  final String role; // Store or Online Store

  MyProductsScreen({required this.role});

  @override
  _MyProductsScreenState createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  List<Map<String, String>> products = [
    {
      'name': 'Swimming Goggles',
      'price': '\$25',
      'stock': '10',
      'category': 'Accessories',
    },
    {
      'name': 'Swim Suit',
      'price': '\$50',
      'stock': '5',
      'category': 'Clothing',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(product['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${product['price']}'),
                        Text('Stock: ${product['stock']} available'),
                        Text('Category: ${product['category']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // Implement edit functionality
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              products.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Implement Add Product Functionality
              },
              child: Text('Add Product'),
            ),
          ),
        ],
      ),
    );
  }
}

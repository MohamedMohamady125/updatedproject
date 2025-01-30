import 'package:flutter/material.dart';

class StoreProductsScreen extends StatelessWidget {
  final String storeName;

  StoreProductsScreen({required this.storeName, required String userRole});

  final List<Map<String, dynamic>> _products = [
    {
      'itemType': 'Training Fins',
      'photos': ['https://via.placeholder.com/150'],
      'price': '\$35',
      'description': 'High-quality training fins for swimmers.',
    },
    {
      'itemType': 'Swim Caps',
      'photos': ['https://via.placeholder.com/150'],
      'price': '\$10',
      'description': 'Durable swim caps available in multiple colors.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$storeName - Products'),
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Card(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product['photos'][0],
                    height: 150, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['itemType'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('Price: ${product['price']}'),
                      Text(
                        'Description: ${product['description']}',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Feature not available in Store view.')),
                          );
                        },
                        child: Text('Add to Cart'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

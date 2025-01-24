import 'package:flutter/material.dart';
import 'post_product_screen.dart';
import 'product_details_screen.dart';

class UsedSection extends StatelessWidget {
  final List<Map<String, dynamic>> _products = [
    {
      'itemType': 'Swimwear',
      'photos': ['https://via.placeholder.com/150'],
      'size': 'Medium',
      'price': '\$30',
      'location': 'New York, USA',
      'brand': 'Speedo',
      'condition': 'New',
      'description': 'Comfortable swimwear for training.',
      'phoneNumber': '123-456-7890',
    },
    {
      'itemType': 'Goggles',
      'photos': ['https://via.placeholder.com/150'],
      'size': 'Adjustable',
      'price': '\$20',
      'location': 'Los Angeles, USA',
      'brand': 'Arena',
      'condition': 'Used',
      'description': null,
      'phoneNumber': '987-654-3210',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return Card(
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product['photos'][0], height: 150, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['itemType'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Size: ${product['size']}'),
                      Text('Price: ${product['price']}'),
                      Text('Location: ${product['location']}'),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                        child: Text('More Details'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostProductScreen()),
          );
        },
        label: Text('Post Product'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

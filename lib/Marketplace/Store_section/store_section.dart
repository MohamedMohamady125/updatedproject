import 'package:flutter/material.dart';
import 'store_details_screen.dart';
import 'store_products_screen.dart';

class StoreSection extends StatelessWidget {
  final List<Map<String, dynamic>> _stores = [
    {
      'photo': 'https://via.placeholder.com/150',
      'name': 'Dive Shop',
      'location': 'San Diego, USA',
    },
    {
      'photo': 'https://via.placeholder.com/150',
      'name': 'Swim Club Store',
      'location': 'Miami, USA',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _stores.length,
      itemBuilder: (context, index) {
        final store = _stores[index];
        return Card(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(store['photo'], height: 150, fit: BoxFit.cover),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(store['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Location: ${store['location']}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreProductsScreen(storeName: store['name']),
                              ),
                            );
                          },
                          child: Text('View Products'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreDetailsScreen(store: store),
                              ),
                            );
                          },
                          child: Text('View Store Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

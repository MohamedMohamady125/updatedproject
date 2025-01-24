import 'package:flutter/material.dart';
import 'store_products_screen.dart';

class OnlineStoreSection extends StatelessWidget {
  final List<Map<String, dynamic>> _onlineStores = [
    {
      'photo': 'https://via.placeholder.com/150',
      'name': 'Swim Gear Online',
      'deliveryFee': '\$5',
      'deliveryTime': '2-3 days',
    },
    {
      'photo': 'https://via.placeholder.com/150',
      'name': 'Aqua Shop',
      'deliveryFee': '\$3',
      'deliveryTime': '1-2 days',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _onlineStores.length,
      itemBuilder: (context, index) {
        final store = _onlineStores[index];
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
                    Text('Delivery Fee: ${store['deliveryFee']}'),
                    Text('Delivery Time: ${store['deliveryTime']}'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoreProductsScreen(storeName: store['name']),
                          ),
                        );
                      },
                      child: Text('Show Products'),
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

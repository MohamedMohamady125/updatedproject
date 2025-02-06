import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  final String role; // Role of the user

  MyOrdersScreen({super.key, required this.role});

  final List<Map<String, String>> userOrders = [
    {
      'orderId': '001',
      'productName': 'Swimming Goggles',
      'status': 'Shipped',
      'date': 'March 5, 2024',
      'total': '\$25',
    },
    {
      'orderId': '002',
      'productName': 'Swimming Cap',
      'status': 'Delivered',
      'date': 'March 1, 2024',
      'total': '\$15',
    },
  ];

  final List<Map<String, String>> storeOrders = [
    {
      'orderId': '1001',
      'customerName': 'John Doe',
      'productName': 'Swim Suit',
      'status': 'Pending',
      'date': 'March 4, 2024',
      'total': '\$30',
    },
    {
      'orderId': '1002',
      'customerName': 'Alice Smith',
      'productName': 'Swim Fins',
      'status': 'Processing',
      'date': 'March 2, 2024',
      'total': '\$40',
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isStore = (role == 'Online Store');

    List<Map<String, String>> orders = isStore ? storeOrders : userOrders;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(isStore ? order['customerName']! : order['productName']!),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isStore ? 'Product: ${order['productName']}' : 'Order ID: ${order['orderId']}'),
                  Text('Date: ${order['date']}'),
                  Text('Status: ${order['status']}'),
                  Text('Total: ${order['total']}'),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward),
            ),
          );
        },
      ),
    );
  }
}

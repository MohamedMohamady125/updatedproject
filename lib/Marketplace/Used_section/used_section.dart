import 'package:flutter/material.dart';

class UsedSectionScreen extends StatefulWidget {
  @override
  _UsedSectionScreenState createState() => _UsedSectionScreenState();
}

class _UsedSectionScreenState extends State<UsedSectionScreen> {
  String? selectedItemType;
  RangeValues priceRange = RangeValues(0, 500);
  String? selectedLocation;
  String? selectedCondition;

  List<Map<String, String>> items = [
    {
      'name': 'Swimming Goggles',
      'itemType': 'Accessories',
      'price': '50',
      'location': 'New York',
      'condition': 'New',
    },
    {
      'name': 'Swim Suit',
      'itemType': 'Clothing',
      'price': '30',
      'location': 'Los Angeles',
      'condition': 'Used',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredItems = items.where((item) {
      return (selectedItemType == null || item['itemType'] == selectedItemType) &&
          (double.parse(item['price']!) >= priceRange.start &&
              double.parse(item['price']!) <= priceRange.end) &&
          (selectedLocation == null || item['location'] == selectedLocation) &&
          (selectedCondition == null || item['condition'] == selectedCondition);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Used Marketplace'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text('Filters'),
              children: [
                DropdownButtonFormField<String>(
                  value: selectedItemType,
                  onChanged: (value) {
                    setState(() {
                      selectedItemType = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Item Type'),
                  items: ['Accessories', 'Clothing', 'Equipment']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price Range: \$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}'),
                    RangeSlider(
                      values: priceRange,
                      min: 0,
                      max: 500,
                      divisions: 10,
                      onChanged: (values) {
                        setState(() {
                          priceRange = values;
                        });
                      },
                    ),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: selectedLocation,
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Location'),
                  items: ['New York', 'Los Angeles']
                      .map((loc) => DropdownMenuItem(
                            value: loc,
                            child: Text(loc),
                          ))
                      .toList(),
                ),
                DropdownButtonFormField<String>(
                  value: selectedCondition,
                  onChanged: (value) {
                    setState(() {
                      selectedCondition = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Condition'),
                  items: ['New', 'Used']
                      .map((cond) => DropdownMenuItem(
                            value: cond,
                            child: Text(cond),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item['name']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${item['itemType']}'),
                        Text('Price: \$${item['price']}'),
                        Text('Location: ${item['location']}'),
                        Text('Condition: ${item['condition']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

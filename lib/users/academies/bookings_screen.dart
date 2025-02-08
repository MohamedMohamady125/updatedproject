import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? existingBookings;

  const BookingsScreen({super.key, this.existingBookings}); // ✅ Accept bookings

  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedBranch = "All";

  late List<Map<String, dynamic>> bookings; // ✅ Stores bookings persistently

  final List<String> branches = [
    "All",
    "SR Padel x ZED",
    "Golf Porto",
    "Hacienda"
  ];

  @override
  void initState() {
    super.initState();
    bookings = widget.existingBookings ?? []; // ✅ Keeps previous bookings
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredBookings = bookings.where((booking) {
      return selectedBranch == "All" || booking['branch'] == selectedBranch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Date Picker Row
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10, // Show next 10 days
              itemBuilder: (context, index) {
                DateTime date = DateTime.now().add(Duration(days: index));
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selectedDate.day == date.day
                          ? Colors.blue
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.E().format(date), // Day name (Mon, Tue..)
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: selectedDate.day == date.day
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: selectedDate.day == date.day
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Branch Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: branches.map((branch) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBranch = branch;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color:
                          selectedBranch == branch ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      branch,
                      style: TextStyle(
                          color: selectedBranch == branch
                              ? Colors.white
                              : Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 10),

          // List of Bookings
          Expanded(
            child: filteredBookings.isEmpty
                ? const Center(
                    child: Text(
                      "No bookings available for this day.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: ListTile(
                          title: Text(
                            booking['service'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${booking['time']}\nClients: ${booking['clients'].length}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.add, color: Colors.blue),
                            onPressed: () {
                              _showClientList(context, booking['clients']);
                            },
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

  // Pop-up to show the list of clients
  void _showClientList(
      BuildContext context, List<Map<String, String>> clients) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Clients"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: clients.map((client) {
              return ListTile(
                title: Text(client['name']!),
                subtitle: Text(client['contact']!),
                leading: const Icon(Icons.person, color: Colors.blue),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}

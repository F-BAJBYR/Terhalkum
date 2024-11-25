import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservationsManagementScreen extends StatefulWidget {
  const ReservationsManagementScreen({super.key, required String title});

  @override
  ReservationsManagementScreenState createState() => ReservationsManagementScreenState();
}

class ReservationsManagementScreenState extends State<ReservationsManagementScreen> {
  final String apiUrl = 'http://l127.0.0.1/api/reservations.php'; // استبدل بعنوان الخادم الخاص بك
  List<dynamic> reservations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReservations();
  }

  Future<void> _fetchReservations() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          reservations = json.decode(response.body);
          isLoading = false;
        });
      } else {
        _showError('Failed to load reservations');
      }
    } catch (e) {
      _showError('Error: $e');
    }
  }

  Future<void> _addReservation() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': 'New Reservation',
          'date': DateTime.now().toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        _fetchReservations();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New reservation added!')),
        );
      } else {
        _showError('Failed to add reservation');
      }
    } catch (e) {
      _showError('Error: $e');
    }
  }

  Future<void> _deleteReservation(int id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl?id=$id'));
      if (response.statusCode == 200) {
        _fetchReservations();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reservation with ID $id deleted.')),
        );
      } else {
        _showError('Failed to delete reservation');
      }
    } catch (e) {
      _showError('Error: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الحجوزات'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : reservations.isEmpty
              ? const Center(child: Text('No reservations found.'))
              : ListView.builder(
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    final reservation = reservations[index];
                    return ListTile(
                      title: Text(reservation['name'] ?? 'Unknown'),
                      subtitle: Text('Date: ${reservation['date']}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteReservation(reservation['id']);
                        },
                      ),
                      onTap: () {
                        // معالجة النقر لعرض تفاصيل الحجز أو تعديله
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addReservation();
        },
        tooltip: 'Add New Reservation',
        child: const Icon(Icons.add),
      ),
    );
  }
}

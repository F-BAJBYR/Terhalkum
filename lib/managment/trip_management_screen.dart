import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TripManagementScreen extends StatelessWidget {
  const TripManagementScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'الرحلات',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Trip>>(
                future: fetchTrips(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error loading data'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No trips found'));
                  }

                  var trips = snapshot.data!;

                  return ListView.builder(
                    itemCount: trips.length,
                    itemBuilder: (context, index) {
                      var trip = trips[index];

                      return TripCard(trip: trip);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Trip>> fetchTrips() async {
    final response = await http.get(Uri.parse('http://127.0.0.1/api/trips.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((trip) => Trip.fromJson(trip)).toList();
    } else {
      throw Exception('Failed to load trips');
    }
  }
}

class Trip {
  final int id;
  final String tripName;
  final String startDate;
  final String endDate;
  final String destination;
  final double price;
  final String status;
  final int maxParticipants;
  final String description;

  Trip({
    required this.id,
    required this.tripName,
    required this.startDate,
    required this.endDate,
    required this.destination,
    required this.price,
    required this.status,
    required this.maxParticipants,
    required this.description,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['trip_id'],
      tripName: json['trip_name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      destination: json['destination'],
      price: json['price'].toDouble(),
      status: json['status'],
      maxParticipants: json['max_participants'],
      description: json['description'],
    );
  }
}

class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.directions_bus, color: Colors.blue),
        title: Text(trip.tripName),
        subtitle: Text(
          'Destination: ${trip.destination}\n'
          'Start Date: ${trip.startDate}\n'
          'End Date: ${trip.endDate}\n'
          'Price: ${trip.price} SR\n'
          'Status: ${trip.status}',
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripDetailScreen(trip: trip),
            ),
          );
        },
      ),
    );
  }
}

class TripDetailScreen extends StatelessWidget {
  final Trip trip;

  const TripDetailScreen({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الرحلة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              trip.tripName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Destination: ${trip.destination}'),
            Text('Start Date: ${trip.startDate}'),
            Text('End Date: ${trip.endDate}'),
            Text('Price: ${trip.price} SR'),
            Text('Status: ${trip.status}'),
            Text('Max Participants: ${trip.maxParticipants}'),
            const SizedBox(height: 16),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(trip.description),
          ],
        ),
      ),
    );
  }
}

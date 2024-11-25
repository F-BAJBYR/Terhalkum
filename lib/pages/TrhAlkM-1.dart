import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:terhalkum/Controller/user_dashboard.dart'; // Import for localizations

void main() {
  runApp(const TrhAlkM1App());
}

class TrhAlkM1App extends StatelessWidget {
  const TrhAlkM1App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TrhAlkM1',
      home: TrhAlkM1(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('ar', ''), // Arabic
      ],
    );
  }
}

class TrhAlkM1 extends StatefulWidget {
  const TrhAlkM1({super.key});

  @override
  TrhAlkM1State createState() => TrhAlkM1State();
}

class TrhAlkM1State extends State<TrhAlkM1> {
  late Future<List<Destination>> futureDestinations;

  String selectedCity = 'مكة المكرمة'; // المدينة الافتراضية
  DateTime selectedDate = DateTime.now(); // التاريخ الافتراضي
  int selectedPersons = 1; // عدد الأشخاص الافتراضي

  final List<String> cities = [
    'مكة المكرمة',
    'المدينة المنورة',
    'الرياض',
    'جدة',
    'الدمام',
    'الخبر',
  ];

  final List<int> persons = [1, 2, 3, 4, 5, 6, 7];

  @override
  void initState() {
    super.initState();
    futureDestinations = fetchDestinations();
  }

  Future<List<Destination>> fetchDestinations() async {
    final response = await http.get(Uri.parse('http://localhost/api/destinations.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Destination.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load destinations');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'تطبيق حجز السفر',
    home: Directionality(
      textDirection: TextDirection.rtl,  // Specifying right-to-left text direction correctly
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text('تطبيق حجز السفر'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildCategoryButtons(context),
              _buildSearchCard(),
              _buildNearbyDestinations(),
              _buildTravelTips(),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    ),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', ''),
      Locale('ar', ''), // Arabic
    ],
  );
}



  Widget _buildNearbyDestinations() {
    return FutureBuilder<List<Destination>>(
      future: futureDestinations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('لا توجد وجهات قريبة حالياً');
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'الوجهات القريبة',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.map((destination) {
                      return _buildDestinationCard(
                        destination.name,
                        destination.location,
                        destination.price,
                        destination.oldPrice,
                        destination.rating,
                        destination.imageUrl,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildDestinationCard(String name, String location, String price, String oldPrice, String rating, String imageUrl) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('SR$price', style: const TextStyle(fontSize: 16, color: Colors.green)),
                      const SizedBox(width: 5),
                      Text(
                        'SR$oldPrice',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 14),
                          const SizedBox(width: 2),
                          Text(rating, style: const TextStyle(fontSize: 12)),
                          const SizedBox(width: 2),
                          const Text('(32)', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          categoryButton(Icons.hotel, 'السكن', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrhAlkM1()), // Navigate to TrhAlkM1 screen
            );
          }),
          categoryButton(Icons.credit_card, 'الباقات', () {
            MaterialPageRoute(builder: (context) => const TrhAlkM()); // Define another action or screen navigation if necessary.
          }),
        ],
      ),
    );
  }

  Widget categoryButton(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 40, color: const Color.fromARGB(255, 103, 39, 176)),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'ابحث عن رحلتك',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            _buildCityDropdown(),
            const SizedBox(height: 10),
            _buildDatePicker(context),
            const SizedBox(height: 10),
            _buildPersonsDropdown(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('بحث', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedCity,
      items: cities.map((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(city, textAlign: TextAlign.right),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCity = newValue!;
        });
      },
      decoration: const InputDecoration(
        labelText: 'المدينة',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: DateFormat('yyyy-MM-dd').format(selectedDate),
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonsDropdown() {
    return DropdownButtonFormField<int>(
      value: selectedPersons,
      items: persons.map((int personCount) {
        return DropdownMenuItem<int>(
          value: personCount,
          child: Text('$personCount شخص', textAlign: TextAlign.right),
        );
      }).toList(),
      onChanged: (int? newValue) {
        setState(() {
          selectedPersons = newValue!;
        });
      },
      decoration: const InputDecoration(
        labelText: 'عدد الأشخاص',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTravelTips() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'نصائح للسفر',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 10),
          Text(
            'تحقق من حالة الطقس قبل السفر.',
            textAlign: TextAlign.right,
          ),
          Text(
            'احرص على حجز تذاكر السفر مسبقاً.',
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'البحث'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
      ],
      onTap: (int index) {
        // Handle bottom navigation item tap here if needed
      },
    );
  }
}

class Destination {
  final String name;
  final String location;
  final String price;
  final String oldPrice;
  final String rating;
  final String imageUrl;

  Destination({
    required this.name,
    required this.location,
    required this.price,
    required this.oldPrice,
    required this.rating,
    required this.imageUrl,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      name: json['name'],
      location: json['location'],
      price: json['price'],
      oldPrice: json['old_price'],
      rating: json['rating'],
      imageUrl: json['image_url'],
    );
  }
}

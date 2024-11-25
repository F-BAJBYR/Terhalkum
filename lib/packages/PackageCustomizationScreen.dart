import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: MaterialApp(
        home: PackageCustomizationScreen(),
      ),
    );
  }
}

class PackageCustomizationScreen extends StatefulWidget {
  const PackageCustomizationScreen({super.key});

  @override
  State<PackageCustomizationScreen> createState() => _PackageCustomizationScreenState();
}

class _PackageCustomizationScreenState extends State<PackageCustomizationScreen> {
  String? _startDate;
  String? _endDate;
  String? _time;
  String _selectedCity = 'الرياض'; // Default selected city

  // List of cities in Saudi Arabia
  final List<String> cities = [
    'الرياض',
    'جدة',
    'مكة',
    'المدينة',
    'الدمام',
    'الخبر',
    'الطائف',
    'تبوك',
    'حائل',
    'نجران',
    'جازان',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'تخصيص الباقة',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // City Selection Dropdown Card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Color(0xFF6F35A5)),
                title: DropdownButton<String>(
                  value: _selectedCity,
                  icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6F35A5)),
                  isExpanded: true,
                  underline: Container(),  // To remove the default underline
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCity = newValue!;
                    });
                  },
                  items: cities.map<DropdownMenuItem<String>>((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city, textAlign: TextAlign.right),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Start Date Picker (No trailing icon)
            CustomInfoCard(
              icon: Icons.calendar_today,
              text: _startDate ?? 'اختر تاريخ البداية',
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  setState(() {
                    _startDate = '${pickedDate.day} ${pickedDate.month} ${pickedDate.year}';
                  });
                }
              },
            ),
            // End Date Picker (No trailing icon)
            CustomInfoCard(
              icon: Icons.calendar_today,
              text: _endDate ?? 'اختر تاريخ النهاية',
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2030),
                );
                if (pickedDate != null) {
                  setState(() {
                    _endDate = '${pickedDate.day} ${pickedDate.month} ${pickedDate.year}';
                  });
                }
              },
            ),
            // Time Picker (No trailing icon)
            CustomInfoCard(
              icon: Icons.access_time,
              text: _time ?? 'اختر وقت الرحلة',
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  setState(() {
                    _time = pickedTime.format(context);
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            // Drop Down Card for people selection
            const CustomDropDownCard(),
            const Spacer(),
            // Bottom Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Here you can add functionality to submit the form
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xFF6F35A5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'تخصيص الباقة',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInfoCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onTap;

  const CustomInfoCard({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF6F35A5)),
          title: Text(text, textAlign: TextAlign.right),
        ),
      ),
    );
  }
}

class CustomDropDownCard extends StatefulWidget {
  const CustomDropDownCard({super.key});

  @override
  _CustomDropDownCardState createState() => _CustomDropDownCardState();
}

class _CustomDropDownCardState extends State<CustomDropDownCard> {
  String dropdownValue = '1 شخص';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.person, color: Color(0xFF6F35A5)),
        title: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF6F35A5)),
          elevation: 16,
          isExpanded: true,
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
          items: <String>[
            '1 شخص',
            '2 شخص',
            '3 شخص',
            '4 شخص',
            '5 شخص',
            '6 شخص',
            '7 شخص'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, textAlign: TextAlign.right),
            );
          }).toList(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:terhalkum/Controller/user_dashboard.dart';
import 'package:terhalkum/main.dart';

import 'package:terhalkum/Authentication/login.dart'; // Replace with the correct main import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set the direction globally to RTL
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 82, 58, 149), // Consistent primary color
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 82, 58, 149), // Button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
            ),
          ),
          textTheme: const TextTheme(
            displayLarge:
            TextStyle(fontSize: 28, fontWeight: FontWeight.bold, height: 1.4),
            bodyLarge: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

// SplashScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to OnboardingScreen after a delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/map.png',
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'صنع من حب تراثنا',
              style: TextStyle(
                fontSize: 18,
                color: Color.fromARGB(255, 82, 58, 149),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// OnboardingScreen
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/img/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'استعدوا لاستكشاف المملكة\nبطريقة جديدة و مثيرة',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'عن طريق الباقات المقدمة من ترحالكم \n يمكنك حجز رحلات تاريخية متكاملة حول\n المملكة العربية السعودية',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 5),
                        const CircleAvatar(
                            radius: 5,
                            backgroundColor: Color.fromARGB(255, 82, 58, 149)),
                        const SizedBox(width: 5),
                        CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.white.withOpacity(0.5)),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'تخطي',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const HotelBookingScreen()),
                            );
                          },
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// HotelBookingScreen
class HotelBookingScreen extends StatelessWidget {
  const HotelBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/img/hotel_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'احجز فندقك واحصل على\nرحلة متكاملة',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'مع خدمة حجز الفنادق يمكنك حجز السكن\nلرحلتك القادمة',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(width: 5),
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: Color.fromARGB(255, 82, 58, 149),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'تخطي',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(16),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const Homepage()),
                              );
                            },
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Homepage
class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/img/sunset.png', // Ensure it's the same image path as the original design
            fit: BoxFit.cover,
          ),
          // Dark overlay for better text visibility
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                const Text(
                  'قم بتصوير المعالم التاريخية\nخلال رحلتك واستمتع بقصص المملكة التاريخية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.5, // For better spacing between lines
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'توفّر لك خدمة اثرائيات بالذكاء الاصطناعي \n و تقنية الواقع المعزز  تجربة لا توصف لاستكشاف \n معالم المملكة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
                const Spacer(flex: 3),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to LoginPage when the button is pressed
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrhAlkM()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 82, 58, 149),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 20), // Button padding adjustment
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'ابدأ الآن',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                // White indicator bar at the bottom
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  height: 5,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

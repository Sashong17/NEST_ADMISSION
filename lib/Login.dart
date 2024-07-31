import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nest/Dashboard.dart';
import 'package:nest/Dashboardmaster.dart';
import 'package:nest/Dashboardview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
Future<void> main() async
{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  String adminEmail = "";
  String adminPassword = "";

  allowAdminToLogin() async {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking credentials, please wait...",
        style: TextStyle(
          fontSize: 36,
          color: Colors.white,
        ),
      ),
      backgroundColor: Color(0xFF0C4F9E),
      duration: Duration(seconds:2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentAdmin;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    )
        .then((fAuth) {
      currentAdmin = fAuth.user;
    }).catchError((onError) {
      final snackBar = SnackBar(
        content: Text(
          "Invalid Login Credentials",
          style: const TextStyle(
            fontSize: 36,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF0C4F9E),
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    if (currentAdmin != null) {
      // Check if the adminEmail matches the specific email ID
      if (adminEmail == 'enq&visit@thenest.school' && adminPassword =='enq&visit') {
        // Navigate to a specific page for the specific email ID
        // Replace 'SpecificPage' with the actual page you want to navigate to
        Navigator.push(context, MaterialPageRoute(builder: (c) =>  RDashboard()));
      }
      else if (adminEmail == 'admin@thenest.school' && adminPassword =='adminlog') {
        // Navigate to a specific page for the specific email ID
        // Replace 'SpecificPage' with the actual page you want to navigate to
        Navigator.push(context, MaterialPageRoute(builder: (c) =>  RDashboardmaster()));
      } else {
        // Navigate to the dashboard
        Navigator.push(context, MaterialPageRoute(builder: (c) => RDashboardview()));
      }
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text(
          "No record found, you are not an admin.",
          style: TextStyle(
            fontSize: 36,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF0C4F9E),
        duration: Duration(seconds: 6),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Image with Opacity
          Positioned.fill(
            child: Opacity(
              opacity: 0.3, // Adjust opacity value as needed (0.0 to 1.0)
              child: Image.asset(
                'assets/nes.jpg', // Update with your background image path
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 300.0),
              // Adjust top padding as needed
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (value) {
                        adminEmail = value;
                      },
                      onSubmitted: (value) {
                        allowAdminToLogin();
                      },
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            width: 2,
                          ),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.black54),
                        icon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      onChanged: (value) {
                        adminPassword = value;
                      },
                      onSubmitted: (value) {
                        allowAdminToLogin();
                      },
                      obscureText: true,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black45,
                            width: 2,
                          ),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black54),
                        icon: Icon(
                          Icons.lock_open,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30,),

                    ElevatedButton(
                      onPressed: () {
                        allowAdminToLogin();
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets
                            .symmetric(horizontal: 100, vertical: 20)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF0C4F9E)),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF0C4F9E)),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontSize: 20,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
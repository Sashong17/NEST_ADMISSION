import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nest/EnquiryAdd.dart';
import 'package:nest/EnquiryView.dart';
import 'package:nest/Login.dart';
import 'package:nest/MasterAdd.dart';
import 'package:nest/MasterView.dart';
import 'package:nest/VisitAdd.dart';
import 'package:nest/VisitView.dart';
import 'package:table_calendar/table_calendar.dart';
Future<void> main() async
{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: RDashboard(),
  ));
}





class RDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: DateRangePickerDemo(),
      ),
    );
  }
}

class DateRangePickerDemo extends StatefulWidget {
  @override
  _DateRangePickerDemoState createState() => _DateRangePickerDemoState();
}

class _DateRangePickerDemoState extends State<DateRangePickerDemo> {
  DateTime _selectedDay = DateTime.now(); // Initialize with the current time

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  Timestamp selectedTimestamp = Timestamp.fromDate(DateTime.now());
  DateTime? rangeEndDate;
  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July',
    'August', 'September', 'October', 'November', 'December'
  ];

  // Update _selectedDay when a new date is selected
  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDay = date;
    });
  }
  @override
  void initState() {
    super.initState();

    // Set the value of _selectedDay within the initState method
    _selectedDay = DateTime.now();

  }

  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2EAAFA), Color(0x2FF1F2F98)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              CircleAvatar(
                radius: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("assets/logo.png"),
                ),
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  showLogoutConfirmationDialog(context);
                },
                child: Text('LOGOUT'),
              ),
              SizedBox(height: 16),
              Divider(color: Colors.white),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                title: Text(
                  'Enquiry Log',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showenquirylog(context);
                },
              ),
              Divider(color: Colors.white),
              ListTile(
                leading: Icon(
                  Icons.accessibility,
                  color: Colors.white,
                ),
                title: Text(
                  'Visit Log',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showvisitlog(context);
                },
              ),
              Divider(color: Colors.white),
              ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                title: Text(
                  'Master Copy',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showmasterlog(context);
                  // Handle Master Copy tap
                },
              ),
              Divider(color: Colors.white),
              Spacer(),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/template.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),


                  child: Column(
                    children: [
                      SizedBox(height:20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(width:100),
                          // Spacer to push the calendar to the left
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0,25,0,0),
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.all(3.0),
                                width: 670,
                                height: 400,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                  ),
                                ),
                                child:  TableCalendar(
                                  calendarFormat: _calendarFormat,
                                  focusedDay: _focusedDay,
                                  firstDay: DateTime(2000),
                                  lastDay: DateTime(2101),
                                  selectedDayPredicate: (day) {
                                    return isSameDay(_selectedDay, day);
                                  },
                                  onDaySelected: (selectedDay, focusedDay) {
                                    setState(() {
                                      _selectedDay = selectedDay;
                                      _focusedDay = focusedDay;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),


                           //SizedBox(width: 40)
                          Container(
                            height: 120.0,
                            width: 120,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.blueAccent,
                                    child: Text(
                                      "ENQUIRY",
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    color: Colors.white54,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50.0,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 2.0,
                                            ),
                                          ),
                                          child:Center(
                                            child:
                                            FutureBuilder<int>(
                                              future: FirebaseFirestore.instance.collection("Enquiryform").get().then((querySnapshot) => querySnapshot.size),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return CircularProgressIndicator();
                                                }
                                                if (snapshot.hasError) {
                                                  return Text("Error: ${snapshot.error}");
                                                }
                                                if (!snapshot.hasData) {
                                                  return Text("No data available");
                                                }
                                                final count = snapshot.data!;

                                                return SingleChildScrollView( // Wrap the Column in SingleChildScrollView
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(" $count"),
                                                      // Add additional widgets here if needed
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 3.0),
                                        Center(
                                          child: Text(
                                            "Total no of enquiries",
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),





                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //SizedBox(width: 50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40,
                                width: 320,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                    child:
                                    FutureBuilder<int>(
                                      future: FirebaseFirestore.instance
                                          .collection("Enquiryform")
                                          .get()
                                          .then((querySnapshot) {
                                        int count = 0;
                                        querySnapshot.docs.forEach((doc) {
                                          final data = doc.data();
                                          final dateOfEnquiry = data['dateOfEnquiry']?.toDate();
                                          if (dateOfEnquiry != null) {
                                            final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfEnquiry);
                                            final selectedFormattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                                            if (formattedDate == selectedFormattedDate) {
                                              count++;
                                            }
                                          }
                                        });
                                        return count;
                                      }),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Container();
                                        }
                                        if (snapshot.hasError) {
                                          return Text("Error: ${snapshot.error}");
                                        }
                                        final count = snapshot.data!;

                                        return SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Total no of Leads Received : $count"),
                                              // Add additional widgets here if needed
                                            ],
                                          ),
                                        );
                                      },
                                    )

                                ),
                              ),
                              SizedBox(height: 15),
                              Row(crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                        child: FutureBuilder<int>(
                                          future: FirebaseFirestore.instance
                                              .collection("Enquiryform")
                                              .where("Source", whereIn: ["SM-Facebook", "SM-LinkedIn","SM-Instagram","SM-Twitter","SM-Campaign","Social Media"])
                                              .get()
                                              .then((querySnapshot) {
                                            int count = 0;
                                            querySnapshot.docs.forEach((doc) {
                                              final data = doc.data();
                                              final dateOfEnquiry = data['dateOfEnquiry']?.toDate();
                                              if (dateOfEnquiry != null) {
                                                final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfEnquiry);
                                                final selectedFormattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                                                if (formattedDate == selectedFormattedDate) {
                                                  count++;
                                                }
                                              }
                                            });
                                            return count;
                                          }),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return Container();
                                            }
                                            if (snapshot.hasError) {
                                              return Text("Error: ${snapshot.error}");
                                            }
                                            final count = snapshot.data!;

                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text("Social Media : $count"),
                                                  // Add additional widgets here if needed
                                                ],
                                              ),
                                            );
                                          },
                                        )

                                    ),
                              ),

                                  SizedBox(width:10),
                                  Container(
                                    height: 40,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                    ),

                                      child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                          child:
                                          FutureBuilder<int>(
                                            future: FirebaseFirestore.instance
                                                .collection("Enquiryform")
                                                .where("Source" , isEqualTo: "Google Search")
                                                .get()
                                                .then((querySnapshot) {
                                              int count = 0;
                                              querySnapshot.docs.forEach((doc) {
                                                final data = doc.data();
                                                final dateOfEnquiry = data['dateOfEnquiry']?.toDate();
                                                if (dateOfEnquiry != null) {
                                                  final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfEnquiry);
                                                  final selectedFormattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                                                  if (formattedDate == selectedFormattedDate) {
                                                    count++;
                                                  }
                                                }
                                              });
                                              return count;
                                            }),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Container();
                                              }
                                              if (snapshot.hasError) {
                                                return Text("Error: ${snapshot.error}");
                                              }
                                              final count = snapshot.data!;

                                              return SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("Google Search : $count"),
                                                    // Add additional widgets here if needed
                                                  ],
                                                ),
                                              );
                                            },
                                          )

                                      ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Container(
                                height: 40,
                                width: 320,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),

                                  child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                      child: FutureBuilder<int>(
                                        future: () async {
                                          final querySnapshot = await FirebaseFirestore.instance.collection("Enquiryform").where("Source", isEqualTo: "Refferal").get();
                                          return querySnapshot.size;
                                        }(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          }
                                          if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          }
                                          final count = snapshot.data ?? 0;

                                          return SingleChildScrollView( // Wrap the Column in SingleChildScrollView
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(" Referral:  $count"),
                                                // Add additional widgets here if needed
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                  ),

                              ),
                            ],
                          ),
                          //SizedBox(width:29),
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),

                                  child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                      child: FutureBuilder<int>(
                                        future: FirebaseFirestore.instance
                                            .collection("Enquiryform")
                                            .where("Source", isEqualTo: "Banner BS")
                                            .get()
                                            .then((querySnapshot) {
                                          int count = 0;
                                          querySnapshot.docs.forEach((doc) {
                                            final data = doc.data();
                                            final dateOfEnquiry = data['dateOfEnquiry']?.toDate();
                                            if (dateOfEnquiry != null) {
                                              final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfEnquiry);
                                              final selectedFormattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                                              if (formattedDate == selectedFormattedDate) {
                                                count++;
                                              }
                                            }
                                          });
                                          return count;
                                        }),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Container();
                                          }
                                          if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          }
                                          final count = snapshot.data!;

                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Banner : $count"),
                                                // Add additional widgets here if needed
                                              ],
                                            ),
                                          );
                                        },
                                      )

                                  ),

                          ),

                              SizedBox(height: 15),
                              Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),

                                  child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                      child:  FutureBuilder<int>(
                                        future: FirebaseFirestore.instance
                                            .collection("Enquiryform")
                                          .where("Category", isEqualTo: "Walk-in")
                                            .get()
                                            .then((querySnapshot) {
                                          int count = 0;
                                          querySnapshot.docs.forEach((doc) {
                                            final data = doc.data();
                                            final dateOfEnquiry = data['dateOfEnquiry']?.toDate();
                                            if (dateOfEnquiry != null) {
                                              final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfEnquiry);
                                              final selectedFormattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                                              if (formattedDate == selectedFormattedDate) {
                                                count++;
                                              }
                                            }
                                          });
                                          return count;
                                        }),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Container();
                                          }
                                          if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          }
                                          final count = snapshot.data!;

                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Walk-in : $count"),
                                                // Add additional widgets here if needed
                                              ],
                                            ),
                                          );
                                        },
                                      )

                                  ),

                              ),


                              SizedBox(height: 15),
                              Container(
                                height: 40,
                                width: 170,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                  child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                      child: FutureBuilder<int>(
                                        future: FirebaseFirestore.instance
                                            .collection("Enquiryform")
                                            .where("Source", isEqualTo: "Others")
                                            .get()
                                            .then((querySnapshot) {
                                          int count = 0;
                                          querySnapshot.docs.forEach((doc) {
                                            final data = doc.data();
                                            final dateOfEnquiry = data['dateOfEnquiry']?.toDate();
                                            if (dateOfEnquiry != null) {
                                              final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfEnquiry);
                                              final selectedFormattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                                              if (formattedDate == selectedFormattedDate) {
                                                count++;
                                              }
                                            }
                                          });
                                          return count;
                                        }),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Container();
                                          }
                                          if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          }
                                          final count = snapshot.data!;

                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Others : $count"),
                                                // Add additional widgets here if needed
                                              ],
                                            ),
                                          );
                                        },
                                      )

                                  ),

                              ),

                                 ],
                          ),
                          //SizedBox(width:29),
                          Column(
                            children: [
                              Container(
                                height: 40,
                                width: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                  child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                      child:  FutureBuilder<int>(
                                        future: FirebaseFirestore.instance
                                            .collection("Enquiryform")
                                          .where("Category", isEqualTo: "WhatsApp")
                                            .get()
                                            .then((querySnapshot) {
                                          int count = 0;
                                          querySnapshot.docs.forEach((doc) {
                                            final data = doc.data();
                                            final dateOfEnquiry = data['dateOfEnquiry']?.toDate();
                                            if (dateOfEnquiry != null) {
                                              final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfEnquiry);
                                              final selectedFormattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                                              if (formattedDate == selectedFormattedDate) {
                                                count++;
                                              }
                                            }
                                          });
                                          return count;
                                        }),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Container();
                                          }
                                          if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          }
                                          final count = snapshot.data!;

                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("WhatsApp : $count"),
                                                // Add additional widgets here if needed
                                              ],
                                            ),
                                          );
                                        },
                                      )

                                  ),

                          ),


                              SizedBox(height: 15),
                              Container(
                                height: 40,
                                width: 180,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                  child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(10,7,0,0),
                                      child:FutureBuilder<int>(
                                        future: FirebaseFirestore.instance
                                            .collection("Enquiryform")
                                            .where("Source", isEqualTo: "Brochure Download")
                                            .get()
                                            .then((querySnapshot) {
                                          int count = 0;
                                          querySnapshot.docs.forEach((doc) {
                                            final data = doc.data();
                                            final dateOfEnquiry = data['dateOfEnquiry']?.toDate();
                                            if (dateOfEnquiry != null) {
                                              final formattedDate = DateFormat('yyyy-MM-dd').format(dateOfEnquiry);
                                              final selectedFormattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);
                                              if (formattedDate == selectedFormattedDate) {
                                                count++;
                                              }
                                            }
                                          });
                                          return count;
                                        }),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Container();
                                          }
                                          if (snapshot.hasError) {
                                            return Text("Error: ${snapshot.error}");
                                          }
                                          final count = snapshot.data!;

                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Brochure Download : $count"),
                                                // Add additional widgets here if needed
                                              ],
                                            ),
                                          );
                                        },
                                      )

                                  ),

                              ),




                            ],
                          ),



                        ],
                      ),
                      SizedBox(height:20),
                    ],
                  ),

            ),
          ),
        ),
      ],
    );

  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                // Handle logout here
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return LoginScreen();
                },),);
              },
            ),
          ],
        );
      },
    );
  }


  void showenquirylog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enquiry Confirmation'),
          content: Text('What would you like to do?'),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                // Handle the "Add" action here
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return EnquiryForm();
                },),);
              },
            ),
            TextButton(
              child: Text('View'),
              onPressed: () {
                // Handle the "View" action here
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return EnquiryView();
                },),);
              },
            ),
          ],
        );
      },
    );
  }

  void showvisitlog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Visit Confirmation'),
          content: Text('What would you like to do?'),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return VisitAdd();
                },),);
              },
            ),
            TextButton(
              child: Text('View'),
              onPressed: () {
                // Handle the "View" action here
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return VisitView();
                },),);
              },
            ),
          ],
        );
      },
    );
  }
  void showmasterlog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Master Confirmation'),
          content: Text('What would you like to do?'),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return MasterAdd();
                },),);
              },
            ),
            TextButton(
              child: Text('View'),
              onPressed: () {
                // Handle the "View" action here
               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return MasterView();
                },),);
              },
            ),
          ],
        );
      },
    );
  }
}
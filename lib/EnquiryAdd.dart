import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nest/Dashboard.dart';
import 'firebase_options.dart';
class Student {
  DateTime? dateofenquiry;
}


Future<String> generateEnquiryNumber() async {
  final collRef = FirebaseFirestore.instance.collection('Enquiryform');

  // Query Firestore for the latest record
  final latestRecord = await collRef.orderBy('EnquiryNum', descending: true).limit(1).get();

  int _enquiryCounter = 1; // Initialize a counter

  // If there is a latest record, extract the counter from its ID and increment it
  if (latestRecord.docs.isNotEmpty) {
    final latestRecordData = latestRecord.docs.first.data();
    final latestRecordCounter = latestRecordData['EnquiryNum'].substring(3); // Extract the counter
    _enquiryCounter = int.tryParse(latestRecordCounter) ?? 0;
    _enquiryCounter++; // Increment the counter
  }

  // Generate a unique ID based on the current counter value
  String enquiryNumber = 'ENQ${_enquiryCounter.toString().padLeft(7, '0')}';
  print("enquirynumbergenerated ${enquiryNumber}");
  return enquiryNumber;
}
Future<void> main() async
{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: EnquiryForm(),
  ));
}


class EnquiryForm extends StatefulWidget {
  @override
  _EnquiryFormState createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<EnquiryForm> {
  String selectedCategory = 'Call';
  String selectedGrade = 'Pre-kg';
  String selectedSource = 'Select Source';
  String selectedStatus = 'No Response';
  List<String> emailDomains = ['gmail.com', 'yahoo.com', 'outlook.com', 'hotmail.com', 'icloud.com', 'aol.com'];
  List<String> categories = ['Call', 'Mail', 'Walk-in','WhatsApp'];
  List<String> grade = ['All','Pre-kg', 'LKG', 'UKG', 'GR1', 'GR2', 'GR3', 'GR4', 'GR5', 'GR6', 'GR7', 'GR8', 'GR9', 'GR10', 'GR11','GR12','M&M','Toddler','Brochure Download'];
  List<String> source = ['Select Source','Google Search', 'Ads on Website', 'Banner BS', 'Social Media', 'Hoarding/Display', 'Alumni/Student', 'Other', 'Newspaper Ad', 'Paper Inset', 'Referral', 'SM-Facebook', 'SM-Instagram', 'SM-Twitter', 'SM-LinkedIn', 'Leaflets', 'Campaign Search', 'SM-Campaign', 'Campaign Display/Ads on Web','Brochure Download'];
  List<String> status = ['No Response', 'TBF-Visit', 'Scheduled', 'Visited', 'Not prospective', 'Wrong', 'Fake', 'Not Interested', 'Toddler', 'Repeat', 'Admitted', 'NR3', 'Inclusive', 'Prospective NY', 'Google Meet'];
  bool isLoading = false;
  bool showAlertDialog = false;
  TextEditingController parentNameController = TextEditingController();
  TextEditingController parentphoneNumberController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController enquirynumberController = TextEditingController();
  String  enquiryNumber = '';
  List<String> countryCodes = ['+1', '+44', '+61', '+91', '+81', '+86', '+90']; // Example country codes
  String selectedCountryCode = '+91'; // Default selected country code
  String selectedEmailDomain = 'gmail.com'; // Default selected email domain

  Widget myCustomTextField(String labelText, String hintText, TextEditingController controller, {int? maxLines}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  TextFormField buildAlphabetOnlyTextField(
      String labelText, String hintText, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        final RegExp regex = RegExp(r'^[a-zA-Z ]+$'); // Allow both uppercase and lowercase letters and spaces
        if (!regex.hasMatch(value!)) {
          return 'Please enter only alphabets for $labelText';
        }
        return null;
      },
    );
  }

  Student student = Student();

  @override

  Future<dynamic> createData() async {
    // Simulate an async operation
    //await Future.delayed(Duration(seconds: 2));
    enquiryNumber = await generateEnquiryNumber();
    // Hide loading animation
    setState(() {
      isLoading = false;
      showAlertDialog = true;
    });

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Enquiryform').doc(enquiryNumber);
    DateTime doe=DateTime.now();
    //DateTime(2023, 11, 6, 12, 34, 56, 789)
    if (student.dateofenquiry!=null){
      doe = student.dateofenquiry!;
    }
    enquirylogData(doe);
    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Category": selectedCategory,
      "Grade" : selectedGrade,
      "Source": selectedSource,
      "Status": selectedStatus,
      "Parent_Name": parentNameController.text,
      "Phone_Number": parentphoneNumberController.text,
      "Email": emailAddressController.text,
      "School": schoolNameController.text,
      "Comments": commentsController.text,
      "dateOfEnquiry" : doe,
      "EnquiryNum" : enquiryNumber
    });
    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('created'));
  }

  Future<dynamic> enquirylogData(doe) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Enquirylog').doc(DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));

    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Category": selectedCategory,
      "Grade" : selectedGrade,
      "Source": selectedSource,
      "Status": selectedStatus,
      "Parent_Name": parentNameController.text,
      "Phone_Number":parentphoneNumberController.text,
      "Email": emailAddressController.text,
      "School": schoolNameController.text,
      "Comments": commentsController.text,
      "dateOfEnquiry" : doe,
      "EnquiryNum" : enquiryNumber,
      "Timestamp" : DateTime.now(),
      "Action" : "Entry",
    });
    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('created'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            showBackToPreviousPage(context);
            // Show the logout confirmation dialog
          },
        ),
        title: Text(
          'ENQUIRY LOG',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Signika',
            letterSpacing: 5,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0C4F9E),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/enquiryadd.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromRGBO(255, 255, 255, 0.7),
            colorBlendMode: BlendMode.modulate,
          ),
          SingleChildScrollView(
            child: Center(
              child:Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            'Mode of Enquiry:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16.0),
                          DropdownButton<String>(
                            value: selectedCategory,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            },
                            items: categories.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      buildAlphabetOnlyTextField('Parent\'s Name', 'Enter Parent\'s name', parentNameController),
                      SizedBox(height: 20.0),
                      buildTextField(
                        'Parent\'s Phone Number',
                        'Enter Parent\'s Phone number',
                        parentphoneNumberController,
                        maxLines:  1,
                      ),
                      
                      SizedBox(height: 20.0),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            'Grade Required:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16.0),
                          DropdownButton<String>(
                            value: selectedGrade,
                            onChanged: (String? newGrade) {
                              setState(() {
                                selectedGrade = newGrade!;
                              });
                            },
                            items: grade.map((String Grade) {
                              return DropdownMenuItem<String>(
                                value: Grade,
                                child: Text(Grade),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: TextEditingController(
                              text: student.dateofenquiry != null
                                  ? DateFormat('MMMM d, yyyy').format(student.dateofenquiry!)
                                  : '',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Date of Enquiry',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Date of Enquiry';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            'Source:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16.0),
                          DropdownButton<String>(
                            value: selectedSource,
                            onChanged: (String? newSource) {
                              setState(() {
                                selectedSource = newSource!;
                              });
                            },
                            items: source.map((String source) {
                              return DropdownMenuItem<String>(
                                value: source,
                                child: Text(source),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 35.0),
                      Row(
                        children: [
                          Text(
                            'Status:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16.0),
                          DropdownButton<String>(
                            value: selectedStatus,
                            onChanged: (String? newStatus) {
                              setState(() {
                                selectedStatus = newStatus!;
                              });
                            },
                            items: status.map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 35.0),
                      buildTextField('Name of the School', 'Enter School Name', schoolNameController),
                      SizedBox(height: 20.0),
                       buildTextField('Email Address', 'Enter Email Address', emailAddressController),

                      SizedBox(height: 20.0),
                      buildTextField('Comments', 'Enter Comments', commentsController),
                      SizedBox(width: 25.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            createData();
                            // Show loading animation
                            setState(() {
                              isLoading = true;
                            });

                            // Simulate an async operation
                            await Future.delayed(Duration(seconds: 2));

                            // Hide loading animation
                            setState(() {
                              isLoading = false;
                              showAlertDialog = true;
                            });

                            // You can show the alert dialog here
                          },
                          style: ElevatedButton.styleFrom(
                            onPrimary: Colors.black,
                            onSurface: Colors.grey,
                          ),

                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (showAlertDialog)
            Center(
              child: AlertDialog(
                title: Text('Success'),
                content: Text('Record Added successfully!'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        return EnquiryForm();
                      },),);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: student.dateofenquiry ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != student.dateofenquiry) {
      setState(() {
        student.dateofenquiry = picked;
      });
    }
  }

  Widget buildTextField(String labelText, String hintText, TextEditingController controller, {int? maxLines}) {
    return TextFormField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }

  void showBackToPreviousPage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Warning'),
            content: Text('Are you sure you want to go back? Any unsaved changes will be lost'),
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
                   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return RDashboard();
                },),);
                },
              ),
            ],
          );
          },
        );
    }
}
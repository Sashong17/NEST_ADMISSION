import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nest/Dashboard.dart';
import 'firebase_options.dart';

Future<void> main() async
{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: VisitAdd(),
  ));
}


class Student {
  DateTime? birthDate;
  DateTime? enquiryDate;
}
/*
Future<String> generateVisitNumber() async {
  final collRef = FirebaseFirestore.instance.collection('Visitform');

  // Query Firestore for the latest record
  final latestRecord = await collRef.orderBy('VisitNum', descending: true).limit(1).get();

  int _enquiryCounter = 1; // Initialize a counter

  // If there is a latest record, extract the counter from its ID and increment it
  if (latestRecord.docs.isNotEmpty) {
    final latestRecordData = latestRecord.docs.first.data();
    final latestRecordCounter = latestRecordData['VisitNum'].substring(3); // Extract the counter
    _enquiryCounter = int.tryParse(latestRecordCounter) ?? 0;
    _enquiryCounter++; // Increment the counter
  }

  // Generate a unique ID based on the current counter value
  String visitNumber = 'VIST${_enquiryCounter.toString().padLeft(7, '0')}';
  print("visitnumbergenerated ${visitNumber}");
  return visitNumber;
}
*/
// Future<String> generateVisitNumber() async {
//   final collRef = FirebaseFirestore.instance.collection('Visitform');
//
//   // Query Firestore for the latest record
//   final latestRecord = await collRef.orderBy('VisitNum', descending: true).limit(1).get();
//
//   int _VisitCounter = 1; // Initialize a counter
//
//   // If there is a latest record, extract the counter from its ID and increment it
//   if (latestRecord.docs.isNotEmpty) {
//     final latestRecordData = latestRecord.docs.first.data();
//     final latestRecordCounter = latestRecordData['VisitNum'].substring(3); // Extract the counter
//     _VisitCounter = int.tryParse(latestRecordCounter) ?? 0;
//     _VisitCounter++; // Increment the counter
//   }
//
//   // Generate a unique ID based on the current counter value
//   String VisitNumber = 'VIS${_VisitCounter.toString().padLeft(7, '0')}';
//   print("visitnumbergenerated ${VisitNumber}");
//   return VisitNumber;
// }

class VisitAdd extends StatefulWidget {
  @override
  _EnquiryFormState createState() => _EnquiryFormState();
}

class _EnquiryFormState extends State<VisitAdd> {
  String selectedGrade = 'None';
  String selectedSource = 'Select Source';
  String selectedStatus = 'None';
  String selectedFeedback = 'None';
  bool isLoading = false;
  bool showAlertDialog = false;

  List<String> feedback = ['None','Firm', 'Tentative', 'Admitted'];
  List<String> grade = ['None','Pre-kg', 'LKG', 'UKG', 'GR1', 'GR2', 'GR3', 'GR4', 'GR5', 'GR6', 'GR7', 'GR8', 'GR9', 'GR10','GR11','GR12'];
  List<String> source = ['Select Source','Google Search', 'Ads on Website', 'Banner BS', 'Social Media', 'Hoarding/Display', 'Alumni/Student', 'Other', 'Newspaper Ad', 'Paper Inset', 'Referral', 'SM-Facebook', 'SM-Instagram', 'SM-Twitter', 'SM-LinkedIn', 'Leaflets', 'Campaign Search', 'SM-Campaign', 'Campaign Display/Ads on Web'];
  List<String> status = ['None','TBF-Decision',
    'Schedule',
    'PKA/Interaction',
    'TBF- Application',
    'TBF-Fee',
    'NI-High fee',
    'NI-Transport',
    'NI-Infrastructure',
    'NI-Curriculum',
    'NI-Others',
    'Prospective',
    'Not Prospective',
    'Withdrawn',
    'Witheld',
    'Admitted',''
        'Scheduled'];
  List<String> emailDomains = ['gmail.com', 'yahoo.com', 'outlook.com', 'hotmail.com', 'icloud.com', 'aol.com'];
  TextEditingController childNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController fatherphoneNumberController  = TextEditingController();
  TextEditingController motherphoneNumberController = TextEditingController();
  TextEditingController visitNumberController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  //bool isLoading = false;
  //bool showAlertDialog = false;
  String  visitNumber = '';
  List<String> countryCodes = ['+1', '+44', '+61', '+91', '+81', '+86', '+90']; // Example country codes
  String selectedCountryCode = ''; // Default selected country code
  String selectedEmailDomain = 'gmail.com'; // Default selected email domain
  Student student = Student();


  Future<dynamic> VisitcreateData() async {
    // Simulate an async operation
    //await Future.delayed(Duration(seconds: 2));
     visitNumber = visitNumberController.text;
    // Hide loading animation
    setState(() {
      isLoading = false;
      showAlertDialog = true;
    });
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Visitform').doc(visitNumber);
    //DocumentReference documentReference = FirebaseFirestore.instance.collection('Visitform').doc(enquiryNumber);
    DateTime dove=DateTime.now();
    DateTime dob=DateTime.now();
    //DateTime(2023, 11, 6, 12, 34, 56, 789)
    if (student.enquiryDate!=null){
      dove = student.enquiryDate!;
    }
    if (student.birthDate!=null){
      dob = student.birthDate!;
    }

    visitlogData(dove,dob);
    Map<String, dynamic> studentsvisit = ({
      "VisitNum":visitNumber,
      "Childname" :childNameController.text,
      'DOB' :dob,
      "DateOfvisit":dove,
      'Comments': commentsController.text,
      "Fname" :fatherNameController.text,
      "FPh":'$selectedCountryCode ${fatherphoneNumberController.text}',
      "Feedback":selectedFeedback,
      "Mname":motherNameController.text,
      "MPh":'$selectedCountryCode ${motherphoneNumberController.text}',
      'Grade':selectedGrade,
      'Source':selectedSource,
      'Status':selectedStatus,
      "Email":'${emailAddressController.text}'

    });
    // send data to Firebase
    documentReference
        .set(studentsvisit)
        .whenComplete(() => print('created'));
  }

  Future<dynamic> visitlogData(dove,dob) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Visitlog').doc(DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));

    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "VisitNum":visitNumberController.text,
      "Childname" :childNameController.text,
      'DOB' :dob,
      "DateOfvisit":dove,
      'Comments': commentsController.text,
      "Fname" :fatherNameController.text,
      "FPh":fatherphoneNumberController.text,
      "Feedback":selectedFeedback,
      "Mname":motherNameController.text,
      "MPh":motherphoneNumberController.text,
      'Grade':selectedGrade,
      'Source':selectedSource,
      'Status':selectedStatus,
      "Email":emailAddressController.text,
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
          },
        ),
        title: Text(
          'VISIT LOG',
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
          Positioned.fill(
            child: Opacity(
              opacity: 0.7, // Adjust opacity value as needed (0.0 to 1.0)
              child: Image.asset(
                'assets/enquiryadd.png', // Update with your background image path
                fit: BoxFit.cover, // Adjust the fit as needed
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      buildTextField('Visit Number', 'Enter Visit Number', visitNumberController),

                      SizedBox(height: 20.0),
                      buildTextField('Child\'s Name', 'Enter Child\'s name', childNameController),
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: TextEditingController(
                              text: student.birthDate != null
                                  ? DateFormat('MMMM d, yyyy').format(student.birthDate!)
                                  : '',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Date of Birth',
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
                      buildTextField('Father\'s Name', 'Enter Father\'s name', fatherNameController),
                      SizedBox(height: 20.0),
                      buildTextField('Father\'s Phone Number', 'Enter Father\'s Phone Number', fatherphoneNumberController),
                      SizedBox(height: 20.0),
                      buildTextField('Mother\'s Name', 'Enter Mother\'s name', motherNameController),
                      SizedBox(height: 20.0),
                      buildTextField('Mother\'s Phone Number', 'Enter Mother\'s Phone number', motherphoneNumberController),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          Text(
                            'Grade :',
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
                      SizedBox(height: 20.0),
                      InkWell(
                        onTap: () {
                          _selectEnquiryDate(context);
                        },
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: TextEditingController(
                              text: student.enquiryDate != null
                                  ? DateFormat('MMMM d, yyyy').format(student.enquiryDate!)
                                  : '',
                            ),
                            decoration: InputDecoration(
                              labelText: 'Date of Visit',
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
                      buildTextField('Email Address', 'Enter Email Address', emailAddressController),
                      SizedBox(height: 20.0),
                      buildTextField('Comments', 'Enter Any Comments', commentsController),
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
                      Row(
                        children: [
                          Text(
                            'Feedback:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 16.0),
                          DropdownButton<String>(
                            value: selectedFeedback,
                            onChanged: (String? newFeedback) {
                              setState(() {
                                selectedFeedback = newFeedback!;
                              });
                            },
                            items: feedback.map((String feedback) {
                              return DropdownMenuItem<String>(
                                value: feedback,
                                child: Text(feedback),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(width: 16.0),
                      Center(
                      child: ElevatedButton(
                      onPressed: () async {
                        VisitcreateData();
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
                        return VisitAdd();
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
      initialDate: student.birthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != student.birthDate) {
      setState(() {
        student.birthDate = picked;
      });
    }
    Future<void> _showEditDialog() async {
      TextEditingController nameController = TextEditingController();
      TextEditingController valueController = TextEditingController();


      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Edit Item'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: fatherNameController,
                    decoration: InputDecoration(labelText: 'Father\'s Name'),
                  ),
                  TextField(
                    controller: fatherphoneNumberController,
                    decoration: InputDecoration(labelText: 'Father\'s Phonenumber'),
                  ),
                  TextField(
                    controller: motherNameController,
                    decoration: InputDecoration(labelText: 'Mother\'s Name'),
                  ),
                  TextField(
                    controller: motherphoneNumberController,
                    decoration: InputDecoration(labelText: 'Mother\'s Phonenumber'),
                  ),
                  TextField(
                    controller: commentsController,
                    decoration: InputDecoration(labelText: 'Comments'),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Status'),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Feedback'),
                  ),
                  TextField(
                    controller: emailAddressController,
                    decoration: InputDecoration(labelText: 'E-mail'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    final newName = nameController.text;
                    final newValue = int.tryParse(valueController.text);

                    if (newName.isNotEmpty) {
                      setState(() {

                      });



                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          );
        },
      );
    }
  }
  Future<void> _selectEnquiryDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: student.enquiryDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != student.enquiryDate) {
      setState(() {
        student.enquiryDate = picked;
      });
    }
  }

  Widget buildTextField(String labelText, String hintText, TextEditingController controller) {
    return Container(
      width: double.infinity, // Adjust the width to your desired value
      child: TextFormField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
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
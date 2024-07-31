import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nest/Dashboard.dart';
import 'package:nest/Dashboardview.dart';
import 'package:nest/Login.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class Student {
  DateTime? birthDate;
  DateTime? dateOfEnquiry;
  String? name;
  String? value;
}

Future<void> main() async
{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: VisitViewonly(),
  ));
}



class VisitViewonly extends StatefulWidget {
  @override
  _VisitViewState createState() => _VisitViewState();
}

class _VisitViewState extends State<VisitViewonly> {
  String selectedGrade = 'All';
  String selectedSource = 'All';
  String selectedStatus = 'All';
  String selectedFeedback = 'All';
  List<String> feedback = ['All','Firm', 'Tentative', 'Admitted'];
  List<String> grade = ['All','Pre-kg', 'LKG', 'UKG', 'GR1', 'GR2', 'GR3', 'GR4', 'GR5', 'GR6', 'GR7', 'GR8', 'GR9', 'GR10','GR11','GR12'];
  List<String> source = ['All','Google Search', 'Ads on Website', 'Banner BS', 'Social Media', 'Hoarding/Display', 'Alumni/Student', 'Other', 'Newspaper Ad', 'Paper Inset', 'Referral', 'SM-Facebook', 'SM-Instagram', 'SM-Twitter', 'SM-LinkedIn', 'Leaflets', 'Campaign Search', 'SM-Campaign', 'Campaign Display/Ads on Web'];
  List<String> status = ['All','TBF-Decision',
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
        'Admitted','Scheduled'];  TextEditingController gradeController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  TextEditingController childNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController fatherphoneNumberController = TextEditingController();
  TextEditingController motherphoneNumberController = TextEditingController();
  TextEditingController visitNumberController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController enquirerNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Student student = Student();


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
          'VISIT LOG- VIEW',
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
      body: Column(
        children: [
          // Top Container (Form)
          Container(
            color: Color(0xFF0C4F9E),
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Visit Number Row
                    // First Row (Grade and Date of Enquiry)
                    Row(
                      children: [
                        Text(
                          'Grade:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 20.0),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedGrade,
                          onChanged: (String? newGrade) {
                            setState(() {
                              selectedGrade = newGrade!;
                            });
                          },
                          items: grade.map((String grade) {
                            return DropdownMenuItem<String>(
                              value: grade,
                              child: Text(
                                grade,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),

                      ],
                    ),

                    // Second Row (Source, Status, and Firm)
                    Row(
                      children: [
                        Text(
                          'Source:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 10.0),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedSource,
                          onChanged: (String? newSource) {
                            setState(() {
                              selectedSource = newSource!;
                              sourceController.text = newSource;
                            });
                          },
                          items: source.map((String source) {
                            return DropdownMenuItem<String>(
                              value: source,
                              child: Text(
                                source,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 40.0),
                        Text(
                          'Status:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 12.0),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedStatus,
                          onChanged: (String? newStatus) {
                            setState(() {
                              selectedStatus = newStatus!;
                              statusController.text = newStatus;
                            });
                          },
                          items: status.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(
                                status,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 30),
                        Text(
                          'Feedback:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 20.0),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedFeedback,
                          onChanged: (String? newFeedback) {
                            setState(() {
                              selectedFeedback = newFeedback!;
                              feedbackController.text = newFeedback;
                            });
                          },
                          items: feedback.map((String Grade) {
                            return DropdownMenuItem<String>(
                              value: Grade,
                              child: Text(
                                Grade,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Container (Image and DataTable)
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/viewtemp.png"),
                  // Replace with your image
                  fit: BoxFit.fitWidth,
                ),
              ), // Set the scroll direction to horizontal
              child: Scrollbar(
                controller: _scrollController,
                thickness: 15,
                thumbVisibility: true,
                trackVisibility: true,
                radius: const Radius.circular(20),
                interactive: true,

                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Visitform')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }

                          List<DataRow> dataRows = [];

                          snapshot.data!.docs.forEach((doc) {
                            var data = doc.data() as Map<String, dynamic>;

                  //bool check gradematch
                            bool gradeMatch = selectedGrade.isEmpty ||
                                data['Grade'] == selectedGrade||
                                'All' == selectedGrade;
                            print("gradeMatch ${gradeMatch}");

                  //bool check Sourcematch
                            bool sourceMatch = selectedSource.isEmpty ||
                                data['Source'] == selectedSource||
                                'All' == selectedSource;
                            print("sourceMatch ${sourceMatch}");

                  //bool check Statusmatch
                            bool statusMatch = selectedStatus.isEmpty ||
                                data['Status'] == selectedStatus||
                                'All' == selectedStatus;
                            print("statusMatch ${statusMatch}");

                  //bool check feedbackmatch
                            bool feedbackMatch = selectedFeedback.isEmpty ||
                                data['Feedback'] == selectedFeedback ||
                                'All' == selectedFeedback;
                            print("feedbackMatch ${feedbackMatch}");

                            if (gradeMatch &&
                                statusMatch &&
                                sourceMatch &&
                                feedbackMatch
                            ) {
                              String str1 = 'this is an example of a single-line string';
                              print(str1);

                              dataRows.add(
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(data['VisitNum'])),
                                      DataCell(Text(data['Fname'])),
                                      DataCell(Text(data['FPh'])),
                                      DataCell(Text(data['Mname'])),
                                      DataCell(Text(data['MPh'])),
                                      DataCell( SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Container(
                                          width: 350,

                                          // Set the width of the DataCell
                                          child: Text(
                                            data['Comments'],softWrap: true, // Enable text wrapping
                                          ),),
                                      ),),
                                      DataCell(Text(data['Status'])),
                                      DataCell(Text(data['Feedback'])),
                                      DataCell(Text(data['Email'])),

                                    ],
                                  ));
                            }
                          });

                          return DataTable(
                            dataRowHeight: 125,
                            columns: <DataColumn>[
                              DataColumn(label: Text('Visit Number')),
                              DataColumn(label: Text('Father\'s Name')),
                              DataColumn(label: Text('Father\'s Phone Number')),
                              DataColumn(label: Text('Mother\'s Name')),
                              DataColumn(label: Text('Mother\'s Phone Number')),
                              DataColumn(label: Text('Comments')),
                              DataColumn(label: Text('Status')),
                              DataColumn(label: Text('Feedback')),
                              DataColumn(label: Text('E-mail')),
                            ],
                            rows: dataRows,
                          );
                        },
                      )),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
  Future<void> _showEditDialog(data) async {

    visitNumberController.text=data['VisitNum'] ?? '';
    fatherNameController.text=data['Fname'] ?? '';
    fatherphoneNumberController.text=data['FPh'] ?? '';
    motherNameController.text=data['Mname'] ?? '';
    motherphoneNumberController.text=data['MPh'] ?? '';
    commentsController.text=data['Comments'] ?? '';
    statusController.text=data['Status'] ?? '';
    feedbackController.text=data['Feedback'] ?? '';
    emailAddressController.text=data['Email'] ?? '';
    gradeController.text= data['Grade'];
    sourceController.text= data['Source'];



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
                  decoration: InputDecoration(labelText: 'Father\'s Phone Number'),
                ),
                TextField(
                  controller: motherNameController,
                  decoration: InputDecoration(labelText: 'Mother\'s Name'),
                ),
                TextField(
                  controller: motherphoneNumberController,
                  decoration: InputDecoration(labelText: 'Mother\'s Phone Number'),
                ),
                TextField(
                  controller: commentsController,
                  decoration: InputDecoration(labelText: 'Comments'),
                ),


                Row(
                  children: [
                    Text('Grade:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: gradeController),
                    ),
                    SizedBox(width:55),
                    ElevatedButton(
                      onPressed: () {
                        _showGradeDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Status:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: statusController),
                    ),
                    SizedBox(width:55),
                    ElevatedButton(
                      onPressed: () {
                        _showStatusDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Feedback:'),
                    SizedBox(width:10),
                    Container(
                      width:100,
                      child: TextField(
                          controller: feedbackController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showFeedbackDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Source:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: sourceController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showSourceDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                TextField(
                  controller: emailAddressController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),
                TextField(
                  controller: emailAddressController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
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
                onPressed: () async {
                  updateData(data);
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return VisitViewonly();
                  },),);
                },

                child: Text('Save'),
              ),
            ],
          ),

        );

      },
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
  }
  Future<dynamic> updateData(data) async {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Visitform').doc(visitNumberController.text);
    updatelogData();
    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "VisitNum":visitNumberController.text,
      "Childname" :childNameController.text,
      'Comments': commentsController.text,
      "Fname" :fatherNameController.text,
      "FPh":fatherphoneNumberController.text,
      "Feedback":feedbackController.text,
      "Mname":motherNameController.text,
      "MPh":motherphoneNumberController.text,
      "Grade": gradeController.text,
      "Source":sourceController.text,
      "Status":statusController.text,
      "Email":emailAddressController.text
    });
    // send data to Firebase
    documentReference
        .update(students)
        .whenComplete(() => print('data updated'));
  }
  void showBackToPreviousPage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Are you sure you want to go back?'),
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
                Navigator.push(
                  context, MaterialPageRoute(builder: (BuildContext context) {
                  return RDashboardview();
                }),);
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showFeedbackDialog(BuildContext context) async {
    String? selectedFeedback = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Feedback'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: feedback.map((feedbackOption) {
                return ListTile(
                  title: Text(feedbackOption),
                  onTap: () {
                    Navigator.of(context).pop(feedbackOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedFeedback != null) {
      setState(() {
        // Update the selected grade with the user's choice
        feedbackController.text = selectedFeedback;
      });
    }
  }
  Future<void> _showStatusDialog(BuildContext context) async {
    String? selectedStatus = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Status'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: status.map((statusOption) {
                return ListTile(
                  title: Text(statusOption),
                  onTap: () {
                    Navigator.of(context).pop(statusOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedStatus != null) {
      setState(() {
        // Update the selected grade with the user's choice
        statusController.text = selectedStatus;
      });
    }
  }
  Future<void> _showGradeDialog(BuildContext context) async {
    String? selectedGrade = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Grade'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: grade.map((statusOption) {
                return ListTile(
                  title: Text(statusOption),
                  onTap: () {
                    Navigator.of(context).pop(statusOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedGrade != null) {
      setState(() {
        // Update the selected grade with the user's choice
        gradeController.text = selectedGrade;
      });
    }
  }
  Future<void> _showSourceDialog(BuildContext context) async {
    String? selectedSource = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Source'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: source.map((sourceOption) {
                return ListTile(
                  title: Text(sourceOption),
                  onTap: () {
                    Navigator.of(context).pop(sourceOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedSource != null) {
      setState(() {
        // Update the selected grade with the user's choice
        sourceController.text = selectedSource;
      });
    }
  }
  Future<dynamic> updatelogData() async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Visitlog').doc(
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));

    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "VisitNum": visitNumberController.text,
      "Childname": childNameController.text,
      'Comments': commentsController.text,
      "Fname": fatherNameController.text,
      "FPh": fatherphoneNumberController.text,
      "Feedback": feedbackController.text,
      "Mname": motherNameController.text,
      "MPh": motherphoneNumberController.text,
      'Grade': gradeController.text,
      'Source': sourceController.text,
      'Status': statusController.text,
      "Email": emailAddressController.text,
      //"dateOfEnquiry" : DateFormat("dd-MMM-yyy").parse(enquirydateController.text),
      "Timestamp": DateTime.now(),
      "Action": "Updated"
    });
    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('created'));
  }
}

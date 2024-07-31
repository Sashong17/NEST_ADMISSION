import 'package:flutter/material.dart';
import 'package:nest/Dashboard.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/single_child_widget.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';
class Student {
  DateTime? birthDate;
  DateTime? dateOfEnquiry;
  DateTime? dateofvisit;
  String? name;
  String? value;
}

Future<void> main() async
{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: VisitView(),
  ));
}



class VisitView extends StatefulWidget {
  @override
  _VisitViewState createState() => _VisitViewState();
}

class _VisitViewState extends State<VisitView> {
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
    'Admitted',
    'Scheduled'];  TextEditingController gradeController = TextEditingController();
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
  TextEditingController visitDateController = TextEditingController();
  TextEditingController enquirydateController = TextEditingController();
  Map<String, bool> _checkboxValues = {};
  List<String> emaillist=[];


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
                        SizedBox(width: 30.0),
                        ElevatedButton(
                            onPressed: () {
                              _sendEmailToAll(emaillist);
                              // Add your onPressed logic here
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white, // Background color
                              onPrimary: Colors.black, // Text color
                            ),
                            child: Text(
                              'Send E-mail',
                              style: TextStyle(
                                color: Colors.black, // Text color
                              ),
                            ),
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
                        SizedBox(width: 40.0),
                        InkWell(
                          onTap: () async {
                            await _selectDate2(
                                context); // Wait for date selection
                          },
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.white),
                              SizedBox(width: 6.0),
                              SizedBox(width: 8.0),
                              Text(
                                student.dateofvisit != null
                                    ? DateFormat('MMMM d, yyyy').format(
                                    student.dateofvisit!)
                                    : 'Date of Visit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
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
                  image: AssetImage("assets/template.png"),
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
                      _checkboxValues.putIfAbsent(data['Email'], ()=>false);
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

                      var dateValue = data['DateOfvisit'];
                      DateTime? dateMatch;

                      print("dateValue ${dateValue}");

                      if (dateValue is Timestamp) {
                        dateMatch = dateValue.toDate();
                      } else {
                        // Handle cases where 'dateOfEnquiry' does not contain a valid timestamp
                        dateMatch =
                        null; // or set a default date or handle the error as needed
                      }
                      print("dateMatch ${dateMatch}");
                      //print("dateMatch ${dateMatch}");
                      // Replace 'dateValue' with the field name that contains the date value in your Firestore document
                      /*DateTime? dateValue = data['dateOfEnquiry']?.toDate();
                                          bool dateMatch = dateValue != null &&
                                              dateValue.isBefore(DateTime
                                                  .now()); // Modify this condition as needed*/
                      //bool dateIsValid = true;

                      bool dateIsValid1 = dateMatch != null && dateMatch
                          .isBefore(DateTime.now()) &&
                          dateMatch == student.dateofvisit;
                      print("dateIsValid1 before if ${dateIsValid1}");
                      bool dateIsValid2 = student.dateofvisit == null;
                      bool dateIsValid = dateIsValid1 || dateIsValid2;
                      print("dateIsValid2 after if ${dateIsValid2}");
                      //bool dateIsValid = (dateMatch != null) || ((dateMatch != null) && dateMatch.isBefore(DateTime.now()) && dateMatch == student.dateofenquiry);
                      print("dateIsValid after if ${dateIsValid}");
                      print("dateselected ${student.dateofvisit}");


                      if (gradeMatch &&
                      statusMatch &&
                      sourceMatch &&
                      feedbackMatch &&
                      dateIsValid
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
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showCommentsEditDialog(context, data);
                            },
                          ),
                        ),
                      DataCell(Text(data['Status'])),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showStatusEditDialog(context, data);
                            },
                          ),
                        ),
                      DataCell(Text(data['Feedback'])),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showFeedbackEditDialog(context, data);
                            },
                          ),
                        ),
                      DataCell(Text(data['Email'])),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _showEditDialog(data);
                            },
                          ),
                        ),
                        DataCell(
                            Checkbox(
                              value: _checkboxValues[data['Email']] ?? false,
                              onChanged: (bool? value) {
                                setState(() {
                                  _checkboxValues[data['Email']] = value ?? false;
                                  if (value!) {
                                    emaillist.add(data['Email']);
                                    print("updated");
                                    print(emaillist);
                                  } else {
                                    emaillist.removeWhere((item) => item == data['Email']);
                                    print("removed");
                                    print(emaillist);
                                  }
                                });
                              },
                            ),
                            ),
                      ],
                      ));
                      }
                      });

                      return DataTable(
                        dividerThickness: 3.5,
                      dataRowHeight: 125,
                      columns: <DataColumn>[
                      DataColumn(label: Text('Visit Number')),
                      DataColumn(label: Text('Father\'s Name')),
                      DataColumn(label: Text('Father\'s Phone Number')),
                      DataColumn(label: Text('Mother\'s Name')),
                      DataColumn(label: Text('Mother\'s Phone Number')),
                      DataColumn(label: Text('Comments')),
                        DataColumn(label: Text('')),
                      DataColumn(label: Text('Status')),
                        DataColumn(label: Text('')),
                      DataColumn(label: Text('Feedback')),
                        DataColumn(label: Text('')),
                      DataColumn(label: Text('E-mail')),
                      DataColumn(label: Text('Edit')),
                        DataColumn(label: Text('Check Box')),
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
    visitDateController.text =
        DateFormat('dd-MMM-yyy').format(data['DateOfvisit'].toDate()) ?? '';


    dobController.text = DateFormat('dd-MMM-yyy').format(data['DOB'].toDate()) ?? '';



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
                  controller: dobController,
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
                    return VisitView();
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
  Future<void> _showCommentsEditDialog(BuildContext context, Map<String, dynamic> data) async {
    commentsController.text = data['Comments'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Comments'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: commentsController,
                decoration: InputDecoration(labelText: 'Comments'),
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
                // Update the comments in Firestore
                data['Comments'] = commentsController.text;
                await updateCommentsData(data);

                // Trigger a rebuild of the EnquiryView widget
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showMomnameEditDialog(BuildContext context, Map<String, dynamic> data) async {
    motherNameController.text = data['Mname'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: motherNameController,
                decoration: InputDecoration(labelText: 'Mom Name'),
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
                // Update the comments in Firestore
                data['Mname'] = motherNameController.text;
                await updateCommentsData(data);

                // Trigger a rebuild of the EnquiryView widget
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showMomPhoneEditDialog(BuildContext context, Map<String, dynamic> data) async {
    motherphoneNumberController.text = data['MPh'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: motherphoneNumberController,
                decoration: InputDecoration(labelText: 'Mom Phone Number'),
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
                // Update the comments in Firestore
                data['MPh'] = motherphoneNumberController.text;
                await updateCommentsData(data);

                // Trigger a rebuild of the EnquiryView widget
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showfatherphoneEditDialog(BuildContext context, Map<String, dynamic> data) async {
    fatherphoneNumberController.text = data['FPh'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: fatherphoneNumberController,
                decoration: InputDecoration(labelText: 'Mom Name'),
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
                // Update the comments in Firestore
                data['MPh'] = fatherphoneNumberController.text;
                await updateCommentsData(data);

                // Trigger a rebuild of the EnquiryView widget
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showfathernameDialog(BuildContext context, Map<String, dynamic> data) async {
    fatherNameController.text = data['Fname'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: fatherNameController,
                decoration: InputDecoration(labelText: 'Father Name'),
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
                // Update the comments in Firestore
                data['Fname'] = fatherNameController.text;
                await updateCommentsData(data);

                // Trigger a rebuild of the EnquiryView widget
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _showVisitNumEditDialog(BuildContext context, Map<String, dynamic> data) async {
    visitNumberController.text = data['VisitNum'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: visitNumberController,
                decoration: InputDecoration(labelText: 'Visit Num'),
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
                // Update the comments in Firestore
                data['Visit Num'] = visitNumberController.text;
                await updateCommentsData(data);

                // Trigger a rebuild of the EnquiryView widget
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showStatusEditDialog(BuildContext context, Map<String, dynamic> data) async {
    statusController.text= data['Status'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Status:'),
              SizedBox(width:30),
              Container(
                width:100,
                child: TextField(
                    controller: statusController),
              ),
              SizedBox(height:50),
              ElevatedButton(
                onPressed: () {
                  _showStatusDialog(context);
                },
                child: Text('Change'),
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
                // Update the comments in Firestore
                data['Status'] = statusController.text;
                await updateStatusData(data);

                // Trigger a rebuild of the EnquiryView widget
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateStatusData(Map<String, dynamic> data) async {
    // Update the status in Firestore
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Visitform').doc(data['VisitNum']);
    Map<String, dynamic> updatedData = {
      "Status": data['Status'],
    };
    await documentReference.update(updatedData);
  }
  Future<void> _showFeedbackEditDialog(BuildContext context, Map<String, dynamic> data) async {
    feedbackController.text= data['Feedback'] ?? '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Feedback'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Feedback:'),
              SizedBox(width:30),
              Container(
                width:100,
                child: TextField(
                    controller: feedbackController),
              ),
              SizedBox(height:50),
              ElevatedButton(
                onPressed: () {
                  _showFeedbackDialog(context);
                },
                child: Text('Change'),
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
                // Update the comments in Firestore
                data['Feedback'] = feedbackController.text;
                await updateFeedbackData(data);

                // Trigger a rebuild of the EnquiryView widget
                setState(() {});

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateFeedbackData(Map<String, dynamic> data) async {
    // Update the status in Firestore
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Visitform').doc(data['VisitNum']);
    Map<String, dynamic> updatedData = {
      "Feedback": data['Feedback'],
    };
    await documentReference.update(updatedData);
  }
  Future<dynamic> updateCommentsData(Map<String, dynamic> data) async {
    // Update the comments in Firestore
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Visitform').doc(data['VisitNum']);
    Map<String, dynamic> updatedData = {
      "Comments": data['Comments'],
    };
    await documentReference.update(updatedData);
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
  Future<void> _selectDate2(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: student.dateofvisit ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != student.dateofvisit) {
      setState(() {
        student.dateofvisit = picked;
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
      "Email":emailAddressController.text,
      "DOB": DateFormat("dd-MMM-yyy").parse(
          dobController.text)
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
                  return RDashboard();
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
      "DateOfvisit" : DateFormat("dd-MMM-yyy").parse(visitDateController.text),
      "Timestamp": DateTime.now(),
      "Action": "Updated"
    });
    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('created'));
  }
  _sendEmailToAll(List<String> emailList) async {
    //List<String> emailList = data.map((item) => item['email'] ?? '').toList();
    print(emailList);
    String emails = emailList.join(', ');
    print(emails);
    final Uri params = Uri(
      scheme: 'https',
      host: 'mail.google.com',
      path: '/mail/',
      queryParameters: {
        'view': 'cm',
        'to': emails,
        // Replace with the recipient's email address

        // Set your email body here
      },
      //add subject and body here
    );

    var url = params.toString();

    try {
      await launchUrl(params);
    } catch (e) {
      throw 'Could not launch email';
    }
    /*if (await canLaunchUrl()) {
      await launch('mailto:$emails');
    } else {
      throw 'Could not launch email';
    }*/
  }
}


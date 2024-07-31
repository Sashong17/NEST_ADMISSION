import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nest/Dashboard.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';

class Student {
  DateTime? dateofenquiry;
}
Future<void> main() async
{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: EnquiryView(),
  ));
}

class EnquiryView extends StatefulWidget {
  @override
  _EnquiryViewState createState() => _EnquiryViewState();
}

class _EnquiryViewState extends State<EnquiryView> {
  String selectedCategory = 'All';
  String selectedGrade = 'All';
  String selectedSource = 'All';
  String selectedStatus = 'All';
  List<String> categories = ['Call', 'Mail', 'Walk-in', 'WhatsApp', 'All'];
  List<String> grade = ['All','Pre-kg', 'LKG', 'UKG', 'GR1', 'GR2', 'GR3', 'GR4', 'GR5', 'GR6', 'GR7', 'GR8', 'GR9', 'GR10', 'GR11','GR12','M&M','Toddler','Brochure Download'];
  List<String> source = [
    'All',
    'Google Search',
    'Ads on Website',
    'Banner BS',
    'Social Media',
    'Hoarding/Display',
    'Alumni/Student',
    'Other',
    'Newspaper Ad',
    'Paper Inset',
    'Referral',
    'SM-Facebook',
    'SM-Instagram',
    'SM-Twitter',
    'SM-LinkedIn',
    'Leaflets',
    'Campaign Search',
    'SM-Campaign',
    'Campaign Display/Ads on Web'
    'Brochure Download',
  ];
  List<String> status = [
    'All',
    'No Response',
    'TBF-Visit',
    'Scheduled',
    'Visited',
    'Not prospective',
    'Wrong',
    'Fake',
    'Not Interested',
    'Toddler',
    'Repeat',
    'Admitted',
    'NR3',
    'Inclusive',
    'Prospective NY',
    'Google Meet'
  ];
  TextEditingController categoryController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController parentNameController = TextEditingController();
  TextEditingController parentphoneNumberController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController enquirynumberController = TextEditingController();
  TextEditingController enquirydateController = TextEditingController();
  Map<String, bool> _checkboxValues = {};
  List<String> emaillist=[];


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
          'ENQUIRY LOG- VIEW',
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

                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Row
                      Row(
                        children: [
                          Text(
                            'Mode of Enquiry:',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(width: 15.0),
                          DropdownButton<String>(
                            dropdownColor: Colors.black,
                            value: selectedCategory,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                                categoryController.text = newValue;
                              });
                            },
                            items: categories.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(
                                  category,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(width: 200.0),
                          Text(
                            'Grade Required:',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox(width: 10.0),
                          DropdownButton<String>(
                            dropdownColor: Colors.black,
                            value: selectedGrade,
                            onChanged: (String? newGrade) {
                              setState(() {
                                selectedGrade = newGrade!;
                                gradeController.text = newGrade;
                              });
                            },
                            items: grade.map((String Grade) {
                              return DropdownMenuItem<String>(
                                value: Grade,
                                child: Text(
                                  Grade,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(width: 60.0),
                          InkWell(
                            onTap: () async {
                              await _selectDate(
                                  context); // Wait for date selection
                            },
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.white),
                                SizedBox(width: 6.0),
                                SizedBox(width: 8.0),
                                Text(
                                  student.dateofenquiry != null
                                      ? DateFormat('MMMM d, yyyy').format(
                                      student.dateofenquiry!)
                                      : 'Date of Enquiry',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),


                        ],

                      ),


                      // Second Row (Additional Row)
                      Row(
                        children: [
                          Text(
                            'Source:',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ), SizedBox(width: 90.0),
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
                          SizedBox(width: 80.0),
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
                          SizedBox(width: 80.0),
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
                        ],
                      ),

                      // Add more rows here...
                    ],
                  ),
                ),
          ),

          // Bottom Container (Image)

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/template.png"),
                  // Replace with your image
                  fit: BoxFit.fitWidth,

                ),
              ),
                child: Scrollbar(
                  controller: _scrollController,
                  thickness: 15,
                  thumbVisibility: true,
                  trackVisibility: true,
                  radius: const Radius.circular(20),
                  interactive: true,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection:Axis.horizontal ,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,



                          //    trash
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Enquiryform')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircularProgressIndicator();
                              }

                              List<DataRow> dataRows = [];

                              snapshot.data!.docs.forEach((doc) {
                                var data = doc.data() as Map<String, dynamic>;
                                _checkboxValues.putIfAbsent(data['Email'], ()=>false);
                                bool categoryMatch = selectedCategory.isEmpty ||
                                    data['Category'] == selectedCategory ||
                                    'All' == selectedCategory;

                                print("categoryMatch ${categoryMatch}");
                                bool gradeMatch = selectedGrade.isEmpty ||
                                    data['Grade'] == selectedGrade ||
                                    'All' == selectedGrade;

                                print("gradeMatch ${gradeMatch}");
                                bool statusMatch = selectedStatus.isEmpty ||
                                    data['Status'] == selectedStatus ||
                                    'All' == selectedStatus;


                                print("statusMatch ${statusMatch}");
                                bool sourceMatch = selectedSource.isEmpty ||
                                    data['Source'] == selectedSource ||
                                    'All' == selectedSource;

                                print("sourceMatch ${sourceMatch}");


                                var dateValue = data['dateOfEnquiry'];
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
                                    dateMatch == student.dateofenquiry;
                                print("dateIsValid1 before if ${dateIsValid1}");
                                bool dateIsValid2 = student.dateofenquiry == null;
                                bool dateIsValid = dateIsValid1 || dateIsValid2;
                                print("dateIsValid2 after if ${dateIsValid2}");
                                //bool dateIsValid = (dateMatch != null) || ((dateMatch != null) && dateMatch.isBefore(DateTime.now()) && dateMatch == student.dateofenquiry);
                                print("dateIsValid after if ${dateIsValid}");
                                print("dateselected ${student.dateofenquiry}");

                                //Add Category match in if

                                if (gradeMatch &&
                                    statusMatch &&
                                    sourceMatch &&
                                    categoryMatch &&
                                    dateIsValid
                                ) {
                                  String str1 = 'this is an example of a single-line string';
                                  print(str1);
                                  //final DateTime date1 = DateTime.fromMillisecondsSinceEpoch( * 1000);
                                  //DateFormat dt = data['dateOfEnquiry'];
                                  //final result1 = '${dt.year}-${dt.month}-${dt.day} (${dt.hour}:${dt.minute}:${dt.second}})';
                                  //print(result);
                                  //var date1 = new DateTime.fromMillisecondsSinceEpoch(data['dateOfEnquiry'] * 1000);
                                  //DateFormat('yMMMMEEEEd').format(date1)

                                  dataRows.add(
                                      DataRow(

                                        cells: <DataCell>[

                                          DataCell(Text(data['Parent_Name'])),
                                          DataCell(Text(data['Phone_Number'])),
                                          DataCell(Text(data['Grade'])),
                                          DataCell( SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Container(
                                              width: 350,
                                              height: 500,
                                              // Set the width of the DataCell
                                              child: Text(
                                                data['Comments'],softWrap: true, // Enable text wrapping
                                              ),),
                                          ),),
                                          DataCell(
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                _showCommentsEditDialog(context,data);
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
                                          //DataCell(Text(data['medium'])),
                                          DataCell(Text(DateFormat('yMMMMEEEEd').format(
                                              data['dateOfEnquiry'].toDate()))),
                                          DataCell(Text(data['Source'])),


                                          DataCell(Text(data['School'])),

                                          DataCell(Text(data['Email'])),
                                          DataCell(Text(data['Category'])),
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
                                dataRowHeight: 125,
                                columns: <DataColumn>[

                                  DataColumn(label: Text('Parent\'s Name')),
                                  DataColumn(label: Text('Phone Number')),
                                  DataColumn(label: Text('Grade')),
                                  DataColumn(label: Text('Comments')),
                                  DataColumn(label: Text('')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('')),
                                  //DataColumn(label: Text('Medium')),
                                  DataColumn(label: Text('Date of Enquiry')),
                                  DataColumn(label: Text('Source')),

                                  DataColumn(label: Text('Name of the School')),

                                  DataColumn(label: Text('E-Mail')),
                                  DataColumn(label: Text('Mode of Enquiry')),
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

  Future<void> _showEditDialog(data) async {
    parentNameController.text = data['Parent_Name'] ?? '';
    parentphoneNumberController.text = data['Phone_Number']?.toString() ?? '';
    commentsController.text = data['Comments'] ?? '';
    emailAddressController.text = data['Email'] ?? '';
    gradeController.text = data['Grade'] ?? '';
    sourceController.text= data['Source'] ?? '';
    categoryController.text = data['Category'] ?? '';
    statusController.text = data['Status'] ?? '';
    schoolNameController.text = data['School'] ?? '';
    enquirydateController.text = DateFormat('dd-MMM-yyy').format(data['dateOfEnquiry'].toDate()) ?? '';
    enquirynumberController.text = data['EnquiryNum'] ?? '';
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
                  controller: parentNameController,
                  decoration: InputDecoration(labelText: 'Parent\'s Name'),
                ),
                TextField(
                  controller: parentphoneNumberController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                ),

                TextField(
                  controller: schoolNameController,
                  decoration: InputDecoration(labelText: 'Name of the School'),
                ),
                TextField(
                  controller: emailAddressController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),
                Row(
                  children: [
                    Text('Grade:'),
                    SizedBox(width: 30),
                    Container(
                      width: 100,
                      child: TextField(
                          controller: gradeController),
                    ),
                    SizedBox(width: 55),
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
                    Text('Mode of Enquiry:'),
                    SizedBox(width:5),
                    Container(
                      width:50,
                      child: TextField(
                          controller: categoryController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showCategoryDialog(context);
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
                  controller: enquirydateController,
                  decoration: InputDecoration(labelText: 'Enquiry Date'),
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
                  Navigator.push(
                    context, MaterialPageRoute(builder: (BuildContext context) {
                    return EnquiryView();
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


  Future<dynamic> updateData(data) async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Enquiryform').doc(
        enquirynumberController.text);
    updatelogData();
    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Category": categoryController.text,
      "Grade": gradeController.text,
      "Source": sourceController.text,
      "Status": statusController.text,
      "Parent_Name": parentNameController.text,
      "Phone_Number": parentphoneNumberController.text,
      "Email": emailAddressController.text,
      "School": schoolNameController.text,
      "Comments": commentsController.text,
      "dateOfEnquiry": DateFormat("dd-MMM-yyy").parse(enquirydateController.text)
    });
    // send data to Firebase
    documentReference
        .update(students)
        .whenComplete(() =>
        print("enquirydateController.text ${enquirydateController.text}"));
    //print("enquirydateController ${enquirydateController}");
    //print("enquirydateController.text ${enquirydateController.text}");
    //print('data updated'));
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
    FirebaseFirestore.instance.collection('Enquiryform').doc(data['EnquiryNum']);
    Map<String, dynamic> updatedData = {
      "Status": data['Status'],
    };
    await documentReference.update(updatedData);
  }

  Future<dynamic> updateCommentsData(Map<String, dynamic> data) async {
    // Update the comments in Firestore
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Enquiryform').doc(data['EnquiryNum']);
    Map<String, dynamic> updatedData = {
      "Comments": data['Comments'],
    };
    await documentReference.update(updatedData);
  }
  Future<dynamic> updatelogData() async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Enquirylog').doc(
        DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));

    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Category": selectedCategory,
      "Grade": selectedGrade,
      "Source": selectedSource,
      "Status": selectedStatus,
      "Parent_Name": parentNameController.text,
      "Phone_Number": parentphoneNumberController.text,
      //'$selectedCountryCode ${parentphoneNumberController.text}',
      "Email": emailAddressController.text,
      //'${emailAddressController.text}@${selectedEmailDomain}',
      "School": schoolNameController.text,
      "Comments": commentsController.text,
      "dateOfEnquiry": DateFormat("dd-MMM-yyy").parse(enquirydateController.text),
      "EnquiryNum": enquirynumberController.text,
      "Timestamp": DateTime.now(),
      "Action": "Updated",
    });
    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('created'));
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
  Future<void> _showCategoryDialog(BuildContext context) async {
    String? selectedCategory = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Mode of Enquiry'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: categories.map((categoryOption) {
                return ListTile(
                  title: Text(categoryOption),
                  onTap: () {
                    Navigator.of(context).pop(categoryOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedCategory != null) {
      setState(() {
        // Update the selected grade with the user's choice
        categoryController.text = selectedCategory;
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

  void showBackToPreviousPage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Are you sure you want to go back?'
          ),
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

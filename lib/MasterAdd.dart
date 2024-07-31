import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nest/Dashboard.dart';
import 'package:nest/Dashboardmaster.dart';
//import 'package:nest/Dashboard.dart';
import 'firebase_options.dart';
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MasterAdd());
}


class MasterAdd extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: MasterCopyadmissions(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Student {
  DateTime? birthDate;
  DateTime? admissionDate;
  DateTime? payment1Date;
  DateTime? payment2Date;
}

class MasterCopyadmissions extends StatelessWidget {
  TextEditingController usnController = TextEditingController();
  @override
  String adminEmail = "";
  String adminPassword = "";
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar( leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color:Colors.white),
          onPressed: () {
            showBackToPreviousPage(context);
            // Show the logout confirmationdialog
          },
        ),
          title: Text(
            'MASTER COPY',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Signika',
              letterSpacing: 5,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xFF0C4F9E),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'ADMISSIONS',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'ADMINISTRATION',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            admissions(),
            administration(),
          ],
        ),
      ),
    );
  }
}
class administration extends StatefulWidget {
  @override
  _administrationState createState() => _administrationState();
}

class _administrationState extends State<administration> {
  TextEditingController usnController = TextEditingController();
  Student student = Student();
  String feeOption = '';
  String sem1feeOption= '';
  String sem2feeOption= '';
  String admitLetterOption= '';
  String idCardsOption= '';
  String notebooksOption= '';
  String uniformOption= '';
  String textBooksOption= '';
  TextEditingController allergyController = TextEditingController();
  TextEditingController specialController = TextEditingController();
  TextEditingController healthController = TextEditingController();

  TextEditingController DOAController = TextEditingController();
  TextEditingController DOP1Controller = TextEditingController();
  TextEditingController DOP2Controller = TextEditingController();
  String photoOption = '';
  String HealthOption = '';
  String SplNeedOption = '';
  String AllerygyOption = '';
  String documentsOption= '';
  String utOption= '';
  String parentqOption= '';
  String mediaOption= '';
  bool isLoading = false;
  bool showAlertDialog = false;


  Future<dynamic> createAdminData() async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Masterform').doc(usnController.text);
    adminlogData();
    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Fee" : feeOption,
      "Sem1Fee" : sem1feeOption,
      "DOA" : DOAController.text,
      "DOP1" : DOP1Controller.text,
      "Sem2Fee" : sem2feeOption,
      "DOP2" : DOP2Controller.text,
      "Photo" : photoOption,
      "Documents" : documentsOption,
      "UT" : utOption,
      "ParentQ" : parentqOption,
      "HN" : HealthOption,
      "Health" : healthController.text,
      "SN" : SplNeedOption,
      "Special" : specialController.text,
      "AN" : AllerygyOption,
      "Allergy" : allergyController.text,
      "Media" : mediaOption,
      "AdminL" : admitLetterOption,
      "ID" : idCardsOption,
      "NBooks" : notebooksOption,
      "Uniform" : uniformOption,
      "TBooks" : textBooksOption

    });
    // send data to Firebase
    documentReference
        .update(students)
        .whenComplete(() => print('created'));

  }


  Future<dynamic> adminlogData() async {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Masterlog').doc(DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));
    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Operation":"Administration Entry",
      "Fee" : feeOption,
      "Sem1Fee" : sem1feeOption,
      "DOA" : DOAController.text,
      "DOP1" : DOP1Controller.text,
      "Sem2Fee" : sem2feeOption,
      "DOP2" : DOP2Controller.text,
      "Photo" : photoOption,
      "Documents" : documentsOption,
      "UT" : utOption,
      "ParentQ" : parentqOption,
      "HN" : HealthOption,
      "Health" : healthController.text,
      "SN" : SplNeedOption,
      "Special" : specialController.text,
      "AN" : AllerygyOption,
      "Allergy" : allergyController.text,
      "Media" : mediaOption,
      "AdminL" : admitLetterOption,
      "ID" : idCardsOption,
      "NBooks" : notebooksOption,
      "Uniform" : uniformOption,
      "TBooks" : textBooksOption


    });
    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('logcreated'));
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children:[
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
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:40),
                      buildTextField('USN', 'Enter USN', usnController),
                      SizedBox(height:40),
                      Container(
                        child:Center(
                          child: Text("FEE DETAILS(ADM)",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Fee Committee',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: feeOption,
                              onChanged: (value) {
                                setState(() {
                                  feeOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: feeOption,
                              onChanged: (value) {
                                setState(() {
                                  feeOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Sem 1 Fee Payment',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Paid'),
                              value: 'Paid',
                              groupValue: sem1feeOption,
                              onChanged: (value) {
                                setState(() {
                                  sem1feeOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Not Paid'),
                              value: 'Not Paid',
                              groupValue: sem1feeOption,
                              onChanged: (value) {
                                setState(() {
                                  sem1feeOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Concession'),
                              value: 'Concession',
                              groupValue: sem1feeOption,
                              onChanged: (value) {
                                setState(() {
                                  sem1feeOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      SizedBox(height: 20),
                      buildTextField('Date of Admission', 'Enter Date if Admission ',DOAController ),
                      SizedBox(height:20),
                      buildTextField('Date of Payment 1', 'Enter Date of Payment1', DOP1Controller ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Sem 2 Fee Payment',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Paid'),
                              value: 'Paid',
                              groupValue: sem2feeOption,
                              onChanged: (value) {
                                setState(() {
                                  sem2feeOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Not Paid'),
                              value: 'Not Paid',
                              groupValue: sem2feeOption,
                              onChanged: (value) {
                                setState(() {
                                  sem2feeOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Concession'),
                              value: 'Concession',
                              groupValue: sem2feeOption,
                              onChanged: (value) {
                                setState(() {
                                  sem2feeOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      buildTextField('Date of Payment 2', 'Enter Date of Payment 2', DOP2Controller),
                      SizedBox(height:40),
                      Container(
                        child:Center(
                          child: Text("DOCUMENTS SUBMISSION STATUS",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Photo',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: photoOption,
                              onChanged: (value) {
                                setState(() {
                                  photoOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: photoOption,
                              onChanged: (value) {
                                setState(() {
                                  photoOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Documents',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: documentsOption,
                              onChanged: (value) {
                                setState(() {
                                  documentsOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: documentsOption,
                              onChanged: (value) {
                                setState(() {
                                  documentsOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'U/T',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: utOption,
                              onChanged: (value) {
                                setState(() {
                                  utOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: utOption,
                              onChanged: (value) {
                                setState(() {
                                  utOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Parent Questionnaire',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: parentqOption,
                              onChanged: (value) {
                                setState(() {
                                  parentqOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: parentqOption,
                              onChanged: (value) {
                                setState(() {
                                  parentqOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:40),
                      Container(
                        child:Center(
                          child: Text("SPECIFIC NEEDS",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Health Needs',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: HealthOption,
                              onChanged: (value) {
                                setState(() {
                                  HealthOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: HealthOption,
                              onChanged: (value) {
                                setState(() {
                                  HealthOption= value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:15),
                      buildTextField('Health Needs', '', healthController),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Special Needs',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: SplNeedOption,
                              onChanged: (value) {
                                setState(() {
                                  SplNeedOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: SplNeedOption,
                              onChanged: (value) {
                                setState(() {
                                  SplNeedOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      buildTextField('Special Needs', '', specialController),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Allergy Needs',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: AllerygyOption,
                              onChanged: (value) {
                                setState(() {
                                  AllerygyOption= value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: AllerygyOption,
                              onChanged: (value) {
                                setState(() {
                                  AllerygyOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      buildTextField('Allergy Needs', '', allergyController),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                'Media Consent',
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Yes'),
                              value: 'Yes',
                              groupValue: mediaOption,
                              onChanged: (value) {
                                setState(() {
                                  mediaOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('No'),
                              value: 'No',
                              groupValue: mediaOption,
                              onChanged: (value) {
                                setState(() {
                                  mediaOption = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:40),
                      Container(
                        child:Center(
                          child: Text("ADMISSION DETAILS(ADM)",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                "Admit Letter",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Given'),
                              value: 'Given',
                              groupValue: admitLetterOption,
                              onChanged: (value) {
                                setState(() {
                                  admitLetterOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Pending'),
                              value: 'Pending',
                              groupValue: admitLetterOption,
                              onChanged: (value) {
                                setState(() {
                                  admitLetterOption = value!;
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                "ID Cards",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Given'),
                              value: 'Given',
                              groupValue: idCardsOption,
                              onChanged: (value) {
                                setState(() {
                                  idCardsOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Pending'),
                              value: 'Pending',
                              groupValue: idCardsOption,
                              onChanged: (value) {
                                setState(() {
                                  idCardsOption = value!;
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                "Note Books",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Given'),
                              value: 'Given',
                              groupValue: notebooksOption,
                              onChanged: (value) {
                                setState(() {
                                  notebooksOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Pending'),
                              value: 'Pending',
                              groupValue: notebooksOption,
                              onChanged: (value) {
                                setState(() {
                                  notebooksOption = value!;
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                "Uniform",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Given'),
                              value: 'Given',
                              groupValue: uniformOption,
                              onChanged: (value) {
                                setState(() {
                                  uniformOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Pending'),
                              value: 'Pending',
                              groupValue: uniformOption,
                              onChanged: (value) {
                                setState(() {
                                  uniformOption = value!;
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height:20),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10.0,10,0,0),
                              child: Text(
                                "Text Books",
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                              ),
                            ),
                            RadioListTile(
                              title: Text('Given'),
                              value: 'Given',
                              groupValue: textBooksOption,
                              onChanged: (value) {
                                setState(() {
                                  textBooksOption = value!;
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text('Pending'),
                              value: 'Pending',
                              groupValue: textBooksOption,
                              onChanged: (value) {
                                setState(() {
                                  textBooksOption = value!;
                                });
                              },
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height:40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            createAdminData();
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
                        return MasterAdd();
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


  Future<void> _select2Date(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: student.admissionDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != student.admissionDate) {
      setState(() {
        student.admissionDate = picked;
      });
    }
  }

  Future<void> _select3Date(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: student.payment1Date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != student.payment1Date) {
      setState(() {
        student.payment1Date = picked;
      });
    }
  }

  Future<void> _select4Date(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: student.payment2Date ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (picked != null && picked != student.payment2Date) {
      setState(() {
        student.payment2Date = picked;
      });
    }
  }

  Widget buildTextField(String labelText, String hintText, TextEditingController controller) {
    return Container(
      width: double.infinity, // Adjust the width to your desired value
      child: TextFormField(
        maxLines: null,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
class admissions extends StatefulWidget {
  @override
  _admissionsState createState() => _admissionsState();
}

class _admissionsState extends State<admissions> {
  TextEditingController studentNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  TextEditingController fatherNumberController = TextEditingController();
  TextEditingController motherNumberController = TextEditingController();
  TextEditingController emergencyNumberController = TextEditingController();
  TextEditingController emergencycontactController = TextEditingController();
  TextEditingController parentAddressController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController applicationnoController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  TextEditingController DOAController = TextEditingController();
  TextEditingController DOP1Controller = TextEditingController();
  TextEditingController DOP2Controller = TextEditingController();
  TextEditingController usnController = TextEditingController();
  String selectedGrade = 'PKG1';
  List<String> grade = ['PKG1','PKG2', 'LKG1','LKG2','LKG3', 'UKG1', 'GR1', 'GR2', 'GR3', 'GR4', 'GR5', 'GR6', 'GR7', 'GR8', 'GR9', 'GR10', 'PKG'];
  Student student = Student();
  bool isLoading2 = false;
  bool showAlertDialog2 = false;
  String? selectedYear= '2023-2024'; // Initialize as null

  List<String> academicYears = [];



  @override
  void initState() {
    super.initState();
    // Set the initial selected year to the latest year in the list
    academicYears = generateAcademicYears(100);

    /*if (academicYears.isNotEmpty) {
      // Set the initial selected year to the first year in the list
      selectedYear = academicYears[0];
    }*/

  }

  Future<dynamic> createAdmissionData() async {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Masterform').doc(usnController.text);

    admissionlogData();

    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "StuName" : studentNameController.text,
      "Grade" : selectedGrade,
      "AYear" : selectedYear,
      "DOB" : DOBController.text,
      "BlGrp" : bloodgroupController.text,
      "FName" : fatherNumberController.text,
      "MName" : motherNumberController.text,
      "FPh" : fatherNumberController.text,
      "MPh" : motherNumberController.text,
      "ECName" : emergencycontactController.text,
      "ECPh" : emergencyNumberController.text,
      "PAddr" : parentAddressController.text,
      "Email" : emailAddressController.text,
      "AppNum" : applicationnoController.text,
      "USN" : usnController.text,
      "Fee" : "",
      "Sem1Fee" : "",
      "DOA" : DOAController.text,
      "DOP1" : DOP1Controller.text,
      "Sem2Fee" : "",
      "DOP2" : DOP2Controller.text,
      "Photo" : "",
      "Documents" : "",
      "UT" : "",
      "ParentQ" : "",
      "HN" : "",
      "Health" : "",
      "SN" : "",
      "Special" : "",
      "AN" : "",
      "Allergy" : "",
      "Media" : "",
      "AdminL" :"",
      "ID" : "",
      "NBooks" : "",
      "Uniform" : "",
      "TBooks" : ""

    });
    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('created'));
  }


  Future<dynamic> admissionlogData() async {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Masterlog').doc(DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now()));
    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Operation":"Admission Entry",
      "StuName" : studentNameController.text,
      "Grade" : selectedGrade,
      "AYear" : selectedYear,
      "DOB" : DOBController.text,
      "BlGrp" : bloodgroupController.text,
      "FName" : fatherNumberController.text,
      "MName" : motherNumberController.text,
      "FPh" : fatherNumberController.text,
      "MPh" : motherNumberController.text,
      "ECName" : emergencycontactController.text,
      "ECPh" : emergencyNumberController.text,
      "PAddr" : parentAddressController.text,
      "Email" : emailAddressController.text,
      "AppNum" : applicationnoController.text,
      "USN" : usnController.text

    });
    // send data to Firebase
    documentReference
        .set(students)
        .whenComplete(() => print('logcreated'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children:[
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
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:40),
                      buildTextField('USN', 'Enter USN', usnController),
                      SizedBox(height:10),
                      Container(
                        child:Center(
                          child: Text("STUDENT DETAILS",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      buildTextField('Application Number:', '', applicationnoController),
                      SizedBox(height:20),
                      buildTextField('Student\'s name:', 'Enter Student\'s name', studentNameController),
                      SizedBox(height:20),
                      Row(
                        children: [
                          Text(
                            'Grade:',
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
                          SizedBox(width: 50),
                          Text(
                            'Academic Year:',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 50),
                          DropdownButton<String>(
                            value: selectedYear,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedYear = newValue;
                              });
                            },
                            items: academicYears.map((String year) {
                              return DropdownMenuItem<String>(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                          ),

                        ],
                      ),
                      SizedBox(height: 20.0),
                      SizedBox(height: 20),
                      buildTextField('Date of Birth', 'Enter Blood Group', DOBController),
                      SizedBox(height: 20),
                      buildTextField('Blood Group', 'Enter Blood Group', bloodgroupController),
                      SizedBox(height:40),
                      Container(
                        child:Center(
                          child: Text("CONTACT DETAILS",
                            style:TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      buildTextField('Father\'s Name', '', fatherNameController),
                      SizedBox(height:20),
                      buildTextField('Mother\'s Name', '', motherNameController),
                      SizedBox(height:20),
                      buildTextField('Father\'s Mobile Number', '', fatherNumberController),
                      SizedBox(height:20),
                      buildTextField('Mother\'s Mobile Number', '', motherNumberController),
                      SizedBox(height:20),
                      buildTextField('Emergency Contact Name', '', emergencycontactController),
                      SizedBox(height:20),
                      buildTextField('Emergency Contact Number', '', emergencyNumberController),
                      SizedBox(height:20),
                      buildTextField('Parent address', '', parentAddressController),
                      SizedBox(height:20),
                      buildTextField('Email address', '', emailAddressController),
                      SizedBox(height:40),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            createAdmissionData();
                            // Show loading animation
                            setState(() {
                              isLoading2 = true;
                            });

                            // Simulate an async operation
                            await Future.delayed(Duration(seconds: 2));

                            // Hide loading animation
                            setState(() {
                              isLoading2 = false;
                              showAlertDialog2 = true;
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
          if (isLoading2)
            Center(
              child: CircularProgressIndicator(),
            ),
          if (showAlertDialog2)
            Center(
              child: AlertDialog(
                title: Text('Success'),
                content: Text('Record Added successfully!'),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                        return MasterAdd();
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
  List<String> generateAcademicYears(int count) {
    final List<String> years = [];
    int startYear = 2010; // Set the starting year to 2010

    for (int i = 0; i < count; i++) {
      final endYear = startYear + 1;
      final academicYear = '$startYear-$endYear';
      years.add(academicYear);
      startYear++;
    }

    return years;
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
  String adminEmail = "";
  String adminPassword = "";
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Warning'),
        content: Text('Are you sure you want to go back?'
            ' Any unsaved changes will be lost'),
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
              Navigator.push(context, MaterialPageRoute(builder: (c) =>  RDashboard()));
            },
          ),
        ],
      );
    },
  );
}
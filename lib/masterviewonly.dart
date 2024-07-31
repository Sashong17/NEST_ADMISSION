import 'package:flutter/material.dart';
//import 'package:nest/Dashboard.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nest/Dashboard.dart';
import 'package:nest/Dashboardmaster.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    home: MasterViewonly(),
  ));
}
class MasterViewonly extends StatefulWidget {
  @override
  _MasterViewState createState() => _MasterViewState();
}
class _MasterViewState extends State<MasterViewonly> {
  String selectedGrade = 'All';
  String selectedAllergy = 'All';
  String selectedHealth = 'All';
  String adminEmail = "";
  String adminPassword = "";
  String selectedSplNeeds = 'All';
  String selectedMedia = 'All';
  List<String> grade = ['All','PKG1','PKG2', 'LKG1','LKG2','LKG3', 'UKG1', 'GR1', 'GR2', 'GR3', 'GR4', 'GR5', 'GR6', 'GR7', 'GR8', 'GR9', 'GR10', 'PKG'];
  List<String> Health = ['All','Yes','No'];
  List<String> Media = ['All','Yes','No'];
  List<String> Allergy = ['All','Yes','No'];
  List<String> SplNeeds = ['All','Yes','No'];
  List<String> textbook = ['All','Yes','No'];
  List<String> notebook = ['All','Yes','No'];
  List<String> ID = ['All','Yes','No'];
  List<String> Uniform = ['All','Yes','No'];
  List<String> AdmitL = ['All','Yes','No'];
  List<String> ParentQ = ['All','Yes','No'];
  List<String> UT = ['All','Yes','No'];
  List<String> Docs = ['All','Yes','No'];
  List<String> Photo = ['All','Yes','No'];
  List<String> Sem1 = ['All','Yes','No'];
  List<String> Sem2 = ['All','Yes','No'];
  List<String> Fee = ['All','Yes','No'];
  TextEditingController gradeController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController healthController = TextEditingController();
  TextEditingController allergyController = TextEditingController();
  TextEditingController SplNeedsController = TextEditingController();
  TextEditingController MediaController = TextEditingController();
  TextEditingController USNNumController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherNumberController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController fatherNumberController = TextEditingController();
  TextEditingController bloodgroupController = TextEditingController();
  TextEditingController emergencycontactController = TextEditingController();
  TextEditingController emergencyNumberController = TextEditingController();
  TextEditingController parentAddressController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController applicationnoController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  TextEditingController DOAController = TextEditingController();
  TextEditingController DOP1Controller = TextEditingController();
  TextEditingController DOP2Controller = TextEditingController();
  TextEditingController textbookControllerr = TextEditingController();
  TextEditingController notebooksOptionController = TextEditingController();
  TextEditingController idCardsOptionController = TextEditingController();
  TextEditingController uniformOptionController = TextEditingController();
  TextEditingController admintLController = TextEditingController();
  TextEditingController parentqOptionController = TextEditingController();
  TextEditingController mediaOptionController = TextEditingController();
  TextEditingController utOptionController = TextEditingController();
  TextEditingController documentsOptionController = TextEditingController();
  TextEditingController photoOptionController = TextEditingController();
  TextEditingController sem1feeOptionController = TextEditingController();
  TextEditingController sem2feeOptionController = TextEditingController();
  TextEditingController feeOptionController = TextEditingController();
  TextEditingController textbookController= TextEditingController();




  bool isLoading = false;
  bool showAlertDialog = false;
  bool isLoading2 = false;
  bool showAlertDialog2 = false;
  Student student = Student();
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
          'MASTER COPY- VIEW',
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

                        SizedBox(width: 5.0),
                        // Add some space between the Grade and Student Name
                        Expanded(
                          child: Container(
                            width: 50,
                            child: TextFormField(
                              controller: studentNameController,
                              decoration: InputDecoration(
                                labelText: 'Student Name',
                                labelStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0), // Adjust the border radius
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        // Add some space between the Grade and Student Name
                        Expanded(
                          child: Container(
                            width: 50,
                            child: TextFormField(
                              controller: USNNumController,
                              decoration: InputDecoration(
                                labelText: 'USN Number',
                                labelStyle: TextStyle(color: Colors.white),
                                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0), // Adjust the border radius
                                ),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 25.0),
                        Text(
                          'Academic Year:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 20),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedYear,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedYear = newValue;
                            });
                          },
                          items: academicYears.map((String year) {
                            return DropdownMenuItem<String>(
                              value: year,
                              child: Text(
                                year,
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
                        SizedBox(width: 20),
                        Text(
                          'Health Needs:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 10.0),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedHealth,
                          onChanged: (String? newhealth) {
                            setState(() {
                              selectedHealth = newhealth!;
                              healthController.text = newhealth!;
                            });
                          },
                          items: Health.map((String health) {
                            return DropdownMenuItem<String>(
                              value: health,
                              child: Text(
                                health,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          'Allergy Needs:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 12.0),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedAllergy,
                          onChanged: (String? newAllergy) {
                            setState(() {
                              selectedAllergy = newAllergy!;
                              allergyController.text = newAllergy;
                            });
                          },
                          items: Allergy.map((String Allergy) {
                            return DropdownMenuItem<String>(
                              value: Allergy,
                              child: Text(
                                Allergy,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 20.0),
                        Text(
                          'Special Needs:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 20.0),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedSplNeeds,
                          onChanged: (String? newSplNeeds) {
                            setState(() {
                              selectedSplNeeds = newSplNeeds!;
                              SplNeedsController.text = newSplNeeds;
                            });
                          },
                          items: SplNeeds.map((String SplNeeds) {
                            return DropdownMenuItem<String>(
                              value: SplNeeds,
                              child: Text(
                                SplNeeds,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Media Consent:',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        SizedBox(width: 10.0),
                        DropdownButton<String>(
                          dropdownColor: Colors.black,
                          value: selectedMedia,
                          onChanged: (String? newmedia) {
                            setState(() {
                              selectedMedia = newmedia!;
                              MediaController.text = newmedia!;
                            });
                          },
                          items: Media.map((String media) {
                            return DropdownMenuItem<String>(
                              value: media,
                              child: Text(
                                media,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),

                        SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: () async {

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
                            padding: EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                              'Filter',
                              style: TextStyle(
                                fontSize: 11.0,
                                color: Colors.black,
                              ),
                            ),
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
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('Masterform').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Return a loading indicator while waiting for data.
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot
                              .error}'); // Handle the error case.
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return Text(
                              'No data available'); // Handle the case where data is null or not available.
                        }
                        else {
                          List<DataRow> dataRows = [];

                          snapshot.data!.docs.forEach((doc) {
                            var data = doc.data() as Map<String, dynamic>;

//bool check gradematch
                            bool gradeMatch = selectedGrade.isEmpty ||
                                data['Grade'] == selectedGrade ||
                                'All' == selectedGrade;
                            print("gradeMatch ${gradeMatch}");

                            bool HealthMatch = selectedHealth.isEmpty ||
                                data['HN'] == selectedHealth ||
                                'All' == selectedHealth;
                            print("HealthMatch ${HealthMatch}");

                            bool AllergyMatch = selectedAllergy.isEmpty ||
                                data['AN'] == selectedAllergy ||
                                'All' == selectedAllergy;
                            print("AllergyMatch ${AllergyMatch}");
                            bool SplNeedsMatch = selectedSplNeeds.isEmpty ||
                                data['SN'] == selectedSplNeeds ||
                                'All' == selectedSplNeeds;
                            print("SNMatch ${SplNeedsMatch}");
                            bool MediaMatch = selectedMedia.isEmpty ||
                                data['Media'] == selectedMedia ||
                                'All' == selectedMedia;
                            print("MediaMatch ${MediaMatch}");
                            bool GYMatch = data['AYear'] == selectedYear;
                            print("GradeYearMatch ${GYMatch}");
                            bool StudentMatch = (studentNameController.text == "" || (studentNameController.text != null ) &&
                                data['StuName'] == studentNameController.text) ;
                            print("StudentMatch ${StudentMatch}");
                            bool USNMatch = (USNNumController.text == "" || (USNNumController.text != null ) &&
                                data['USN'] == USNNumController.text) ;
                            print("StudentMatch ${StudentMatch}");


                            if (gradeMatch &&
                                HealthMatch &&
                                AllergyMatch &&
                                SplNeedsMatch &&
                                MediaMatch &&
                                GYMatch &&
                                StudentMatch &&
                                USNMatch
                            ) {
                              String str1 = 'this is an example of a single-line string';
                              print(str1);
                              dataRows.add(
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text(data["USN"])),  //1
                                      DataCell(Text(data["StuName"])), //2
                                      DataCell(Text(data["Allergy"])),
                                      DataCell(Text(data["Special"])),
                                      DataCell(Text(data["HN"])),
                                      DataCell(Text(data["FName"])),
                                      DataCell(Text(data["FPh"])),
                                      DataCell(Text(data["MName"])),
                                      DataCell(Text(data["MPh"])),
                                      DataCell(Text(data["BlGrp"])),
                                      DataCell(Text(data["ECName"])),
                                      DataCell(Text(data["ECPh"])),
                                      DataCell(Text(data["PAddr"])),
                                      DataCell(Text(data["Email"])),
                                      DataCell(Text(data["AppNum"])),
                                      DataCell(Text(data["Grade"])),
                                      DataCell(Text(data["DOB"])),// Provide a default value for null dates

                                      DataCell(Text(data["TBooks"])),
                                      DataCell(Text(data["NBooks"])),
                                      DataCell(Text(data["ID"])),
                                      DataCell(Text(data["Uniform"])),
                                      DataCell(Text(data["AdminL"])),
                                      DataCell(Text(data["ParentQ"])),
                                      DataCell(Text(data["Media"])),
                                      DataCell(Text(data["UT"])),
                                      DataCell(Text(data["Documents"])),
                                      DataCell(Text(data["Photo"])),
                                      DataCell(Text(data["Sem1Fee"])),
                                      DataCell(Text(data["Sem2Fee"])),
                                      DataCell(Text(data["Fee"])),
                                      DataCell(Text(data["DOA"])),
                                      DataCell(Text(data["DOP1"])),
                                      DataCell(Text(data["DOP2"])),

                                    ],
                                  ));
                            }
                          });

                          return DataTable(
                            columns: <DataColumn>[
                              DataColumn(label: Text('USN Number')),
                              DataColumn(label: Text('Student Name')),
                              DataColumn(label: Text('Allergy')),
                              DataColumn(label: Text('Special')),
                              DataColumn(label: Text('Health')),
                              DataColumn(label: Text('Father\'s Name')),
                              DataColumn(label: Text('Father\'s Phone Number')),
                              DataColumn(label: Text('Mother\'s Name')),
                              DataColumn(label: Text('Mother\'s Phone Number')),
                              DataColumn(label: Text('Blood Group')),
                              DataColumn(label: Text('Emergency Contact Name')),
                              DataColumn(label: Text('Emergency Contact Number')),
                              DataColumn(label: Text('Parent Address')),
                              DataColumn(label: Text('E-mail')),
                              DataColumn(label: Text('Application Number')),
                              DataColumn(label: Text('Grade')),
                              DataColumn(label: Text('Date of Birth')),
                              DataColumn(label: Text('Text Books')),
                              DataColumn(label: Text('Note Books')),
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Uniform')),
                              DataColumn(label: Text('Admit Letter')),
                              DataColumn(label: Text('Parent Questionnaire')),
                              DataColumn(label: Text('Media')),
                              DataColumn(label: Text('U/T')),
                              DataColumn(label: Text('Documents')),
                              DataColumn(label: Text('Photo')),
                              DataColumn(label: Text('Sem1 Fee')),
                              DataColumn(label: Text('Sem2 Fee')),
                              DataColumn(label: Text('Fee')),
                              DataColumn(label: Text('Date of Admission')),
                              DataColumn(label: Text('Date of Payment1')),
                              DataColumn(label: Text('Date of Payment2')),
                            ],
                            rows: dataRows,
                          );
                        }
                      }
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(data) async {
    USNNumController.text=data["USN"] ?? '';
    studentNameController.text=data["StuName"] ?? '';
    allergyController.text=data["Allergy"];
    SplNeedsController.text=data["Special"] ?? '';
    healthController.text=data["HN"] ?? '';
    motherNameController.text=data["MName"] ?? '';
    motherNumberController.text=data["MPh"] ?? '';
    fatherNameController.text=data["FName"]?? '';
    fatherNumberController.text=data["FPh"] ?? '';
    bloodgroupController.text=data["BlGrp"]?? '';
    emergencycontactController.text=data["ECName"] ?? '';
    emergencyNumberController.text=data["ECPh"]?? '';
    parentAddressController.text=data["PAddr"]?? '';
    emailAddressController.text=data["Email"]?? '';
    applicationnoController.text=data["AppNum"]?? '';
    gradeController.text=data["Grade"]?? '';
    DOBController.text = data['DOB'];
    DOAController.text = data['DOA'];
    DOP1Controller.text = data['DOP1'];
    DOP2Controller.text = data['DOP2'];
    textbookController.text=data["TBooks"]?? '';
    notebooksOptionController.text=data["NBooks"]?? '';
    idCardsOptionController.text=data["ID"]?? '';
    uniformOptionController.text=data["Uniform"]?? '';
    admintLController.text=data["AdminL"]?? '';
    parentqOptionController.text=data["ParentQ"]?? '';
    mediaOptionController.text=data["Media"]?? '';
    utOptionController.text=data["UT"]?? '';
    documentsOptionController.text=data["Documents"]?? '';
    photoOptionController.text=data["Photo"]?? '';
    sem1feeOptionController.text=data["Sem1Fee"]?? '';
    sem2feeOptionController.text=data["Sem2Fee"]?? '';
    feeOptionController.text=data["Fee"]?? '';
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
                  controller: USNNumController,
                  decoration: InputDecoration(labelText: 'USN Number'),
                ),
                TextField(
                  controller: studentNameController,
                  decoration: InputDecoration(labelText: 'Student Name'),
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
                    Text('Allergy'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: allergyController),
                    ),
                    SizedBox(width:55),
                    ElevatedButton(
                      onPressed: () {
                        _showAllergyDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Special Needs:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: SplNeedsController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showSplNeedsDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Health Needs:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: SplNeedsController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showhealthDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Media Consent'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: mediaOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showmediaDialog(context);                  },
                      child: Text('Change'),
                    ),
                  ],
                ),

                TextField(
                  controller: motherNameController,
                  decoration: InputDecoration(labelText: 'Mother\'s Name'),
                ),
                TextField(
                  controller: motherNumberController,
                  decoration: InputDecoration(labelText: 'Mother\'s Phone Number'),
                ),
                TextField(
                  controller: fatherNameController,
                  decoration: InputDecoration(labelText: 'Father\'s Name'),
                ),
                TextField(
                  controller: fatherNumberController,
                  decoration: InputDecoration(labelText: 'Father\'s Phone Number'),
                ),
                TextField(
                  controller: bloodgroupController,
                  decoration: InputDecoration(labelText: 'Blood Group'),
                ),
                TextField(
                  controller: emergencycontactController,
                  decoration: InputDecoration(labelText: 'Emergency Contact Name'),
                ),
                TextField(
                  controller: emergencyNumberController,
                  decoration: InputDecoration(labelText: 'Emergency Contact Number'),
                ),
                TextField(
                  controller: parentAddressController,
                  decoration: InputDecoration(labelText: 'Parent Address'),
                ),
                TextField(
                  controller: emailAddressController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                ),
                TextField(
                  controller: applicationnoController,
                  decoration: InputDecoration(labelText: 'Application Number'),
                ),
                TextField(
                  controller: DOBController,
                  decoration: InputDecoration(labelText: 'Date Of Birth'),

                ),
                TextField(
                  controller: DOAController,
                  decoration: InputDecoration(labelText: 'Date Of Admission'),

                ),
                TextField(
                  controller: DOP1Controller,
                  decoration: InputDecoration(labelText: 'Date Of Payment 1'),
                ),
                TextField(
                  controller: DOP2Controller,
                  decoration: InputDecoration(labelText: 'Date Of Payment 2'),
                ),
                Row(
                  children: [
                    Text('TextBooks:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: textbookController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showtextbookDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Notebooks:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: notebooksOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showNotebookDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('ID Card:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: idCardsOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showIDDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Uniform:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: uniformOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showUniformDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Admit Letter:'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: admintLController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showAdmitLDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Parent Questionnaire'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: parentqOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showParentQDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text('UT'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: utOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showUTDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Documents'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: documentsOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showDocumentsDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Photo'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: photoOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showPhotoDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Sem 1 Fee'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller:sem1feeOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showSem1Dialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Sem 2 Fee'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: sem2feeOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showSem2Dialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Fee'),
                    SizedBox(width:30),
                    Container(
                      width:100,
                      child: TextField(
                          controller: feeOptionController),
                    ),
                    SizedBox(width:50),
                    ElevatedButton(
                      onPressed: () {
                        _showFeeDialog(context);
                      },
                      child: Text('Change'),
                    ),
                  ],
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
                    return MasterViewonly();
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
  Future<void> _showSplNeedsDialog(BuildContext context) async {
    String? selectedSplNeeds = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select SplNeeds'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: SplNeeds.map((SplNeedsOption) {
                return ListTile(
                  title: Text(SplNeedsOption),
                  onTap: () {
                    Navigator.of(context).pop(SplNeedsOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedSplNeeds != null) {
      setState(() {
        // Update the selected grade with the user's choice
        SplNeedsController.text = selectedSplNeeds;
      });
    }
  }
  Future<void> _showAllergyDialog(BuildContext context) async {
    String? selectedAllergy = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Allergy'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Allergy.map((AllergyOption) {
                return ListTile(
                  title: Text(AllergyOption),
                  onTap: () {
                    Navigator.of(context).pop(AllergyOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedAllergy != null) {
      setState(() {
        // Update the selected grade with the user's choice
        allergyController.text = selectedAllergy;
      });
    }
  }
  Future<void> _showNotebookDialog(BuildContext context) async {
    String? selectedNotebook = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Notebook'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: notebook.map((notebookOption) {
                return ListTile(
                  title: Text(notebookOption),
                  onTap: () {
                    Navigator.of(context).pop(notebookOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedNotebook != null) {
      setState(() {
        // Update the selected notebook with the user's choice
        notebooksOptionController.text = selectedNotebook;
      });
    }
  }

  Future<void> _showhealthDialog(BuildContext context) async {
    String? selectedHealth = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Health'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Health.map((HealthOption) {
                return ListTile(
                  title: Text(HealthOption),
                  onTap: () {
                    Navigator.of(context).pop(HealthOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedHealth != null) {
      setState(() {
        // Update the selected grade with the user's choice
        healthController.text = selectedHealth;
      });
    }
  }
  Future<void> _showmediaDialog(BuildContext context) async {
    String? selectedMedia = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Media '),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Media .map((MediaOption) {
                return ListTile(
                  title: Text(MediaOption),
                  onTap: () {
                    Navigator.of(context).pop(MediaOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedMedia  != null) {
      setState(() {
        // Update the selected grade with the user's choice
        mediaOptionController.text = selectedMedia ;
      });
    }
  }
  Future<void> _showtextbookDialog(BuildContext context) async {
    String? selectedtextbook = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select TextBook'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: textbook.map((textbookOption) {
                return ListTile(
                  title: Text(textbookOption),
                  onTap: () {
                    Navigator.of(context).pop(textbookOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedtextbook != null) {
      setState(() {
        // Update the selected grade with the user's choice
        textbookController.text = selectedtextbook;
      });
    }
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
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (c) => RDashboardmaster()));
              },

            ),
          ],
        );
      },
    );
  }
  Future<void> _showAdmitLDialog(BuildContext context) async {
    String? selectedAdmitL = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select AdmitL'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: AdmitL.map((admitLOption) {
                return ListTile(
                  title: Text(admitLOption),
                  onTap: () {
                    Navigator.of(context).pop(admitLOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedAdmitL != null) {
      setState(() {
        // Update the selected AdmitL with the user's choice
        admintLController.text = selectedAdmitL;
      });
    }
  }
  Future<void> _showParentQDialog(BuildContext context) async {
    String? selectedParentQ = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select ParentQ'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ParentQ.map((parentQOption) {
                return ListTile(
                  title: Text(parentQOption),
                  onTap: () {
                    Navigator.of(context).pop(parentQOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedParentQ != null) {
      setState(() {
        // Update the selected ParentQ with the user's choice
        parentqOptionController.text = selectedParentQ;
      });
    }
  }
  Future<void> _showDocumentsDialog(BuildContext context) async {
    String? selectedDocuments = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Documents'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Docs.map((documentOption) {
                return ListTile(
                  title: Text(documentOption),
                  onTap: () {
                    Navigator.of(context).pop(documentOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedDocuments != null) {
      setState(() {
        // Update the selected documents with the user's choice
        documentsOptionController.text = selectedDocuments;
      });
    }
  }
  Future<void> _showPhotoDialog(BuildContext context) async {
    String? selectedPhoto = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Photo Option'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Photo.map((photoOption) {
                return ListTile(
                  title: Text(photoOption),
                  onTap: () {
                    Navigator.of(context).pop(photoOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedPhoto != null) {
      setState(() {
        // Update the selected photo option with the user's choice
        photoOptionController.text = selectedPhoto;
      });
    }
  }
  Future<void> _showSem1Dialog(BuildContext context) async {
    String? selectedSem1 = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Sem1'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Sem1.map((sem1Option) {
                return ListTile(
                  title: Text(sem1Option),
                  onTap: () {
                    Navigator.of(context).pop(sem1Option);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedSem1 != null) {
      setState(() {
        // Update the selected Sem1 with the user's choice
        sem1feeOptionController.text = selectedSem1;
      });
    }
  }
  Future<void> _showSem2Dialog(BuildContext context) async {
    String? selectedSem2 = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Sem2'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Sem2.map((sem2Option) {
                return ListTile(
                  title: Text(sem2Option),
                  onTap: () {
                    Navigator.of(context).pop(sem2Option);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedSem2 != null) {
      setState(() {
        // Update the selected Sem2 with the user's choice
        sem2feeOptionController.text = selectedSem2;
      });
    }
  }
  Future<void> _showFeeDialog(BuildContext context) async {
    String? selectedFee = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Fee'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Fee.map((feeOption) {
                return ListTile(
                  title: Text(feeOption),
                  onTap: () {
                    Navigator.of(context).pop(feeOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedFee != null) {
      setState(() {
        // Update the selected fee with the user's choice
        feeOptionController.text = selectedFee;
      });
    }
  }
  Future<void> _showUTDialog(BuildContext context) async {
    String? selectedUT = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select UT'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: UT.map((UTOption) {
                return ListTile(
                  title: Text(UTOption),
                  onTap: () {
                    Navigator.of(context).pop(UTOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedUT != null) {
      setState(() {
        // Update the selected UT with the user's choice
        utOptionController.text = selectedUT;
      });
    }
  }
  Future<void> _showIDDialog(BuildContext context) async {
    String? selectedID = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select ID'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: ID.map((IDOption) {
                return ListTile(
                  title: Text(IDOption),
                  onTap: () {
                    Navigator.of(context).pop(IDOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedID != null) {
      setState(() {
        // Update the selected ID with the user's choice
        idCardsOptionController.text = selectedID;
      });
    }
  }
  Future<void> _showUniformDialog(BuildContext context) async {
    String? selectedUniform = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Uniform'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Uniform.map((uniformOption) {
                return ListTile(
                  title: Text(uniformOption),
                  onTap: () {
                    Navigator.of(context).pop(uniformOption);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );

    if (selectedUniform != null) {
      setState(() {
        // Update the selected uniform with the user's choice
        uniformOptionController.text = selectedUniform;
      });
    }
  }
  Future<dynamic> updateData(data) async {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('Masterform').doc(USNNumController.text);
    // create Map to send data in key:value pair form
    Map<String, dynamic> students = ({
      "Grade":gradeController.text,
      "StuName":studentNameController.text,
      "HN":healthController.text,
      "Allergy":allergyController.text,
      "Special":SplNeedsController.text,
      "Media":MediaController.text,
      "USN":USNNumController.text,
      "MName":motherNameController.text,
      "MPh":motherNumberController.text,
      "FName":fatherNameController.text,
      "Fph":fatherNumberController.text,
      "BlGrp":bloodgroupController.text,
      "ECName":emergencycontactController.text,
      "ECPh":emergencyNumberController.text,
      "PAddr":parentAddressController.text,
      "Email":emailAddressController.text,
      "AppNum":applicationnoController.text,
      "TBooks":textbookController.text,
      "NBooks":notebooksOptionController.text,
      "ID":idCardsOptionController.text,
      "Uniform":uniformOptionController.text,
      "AdminL":admintLController.text,
      "ParentQ":parentqOptionController.text,
      "Media":mediaOptionController.text,
      "UT":utOptionController.text,
      "Documents":documentsOptionController.text,
      "Photo":photoOptionController.text,
      "Sem1Fee":sem1feeOptionController.text,
      "Sem2Fee":sem2feeOptionController.text,
      "Fee":feeOptionController.text,
      "DOA": DOAController.text,
      "DOP1": DOP1Controller.text,
      "DOP2":
      DOP2Controller.text
    });
    // send data to Firebase
    documentReference
        .update(students)
        .whenComplete(() => print('data updated'));
  }
}


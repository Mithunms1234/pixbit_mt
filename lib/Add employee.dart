import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  GlobalKey<FormState> nameKey = GlobalKey<FormState>();

  Future<dynamic> designations()
  async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    var token = await sharedpref.getString("access_token");

    print(token);

    Map<String, String> header = {
      'Accept': 'application/json',
      'Authorization': "Bearer ${token.toString()}"
    };
    var designationResponse = await get(Uri.parse("http://training.pixbit.in/api/designations"),headers: header);
    var responseBody = jsonDecode(designationResponse.body);
    print(responseBody["data"]["data"][1]["name"]);
            ListItem.clear();
    for(int i=0; i<= responseBody["data"]["data"].length; i++)
      {
        ListItem.add(responseBody["data"]["data"][i]["name"]);
        print(responseBody["data"]["data"][i]["name"]);
      }
    return responseBody;
  }

  String? valueChooseDesignation;
  List<String> ListItem = [];
  String? valueChooseGender;
  List<String> ListItemGender = ["Male","Female","Transgender"];

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController dateB = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController gender = TextEditingController();
  File? profPhoto;
  File? profCamara;

  addEmployee() async {
    DateTime date = DateTime.now();
    String dateFormat = "${date.day}-${date.month}-${date.year}";
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    var token = await sharedpref.getString("access_token");
    var request = MultipartRequest(
        "POST", Uri.parse("http://training.pixbit.in/api/employees"));
    request.fields["first_name"] = firstName.text;
    request.fields["last-name"] = lastName.text;
    request.fields["mobile"] = mobileNumber.text;
    request.fields["email"] = email.text;
    request.fields["present_address"] = address.text;

    request.fields["date_of_birth"] = dateB.text;
    request.fields["designation_id"] = valueChooseDesignation!;
    request.fields["gender"] = valueChooseGender!;
    request.fields["join_date"] = dateFormat;
    request.fields["landline"] = "11111111";
    request.fields["permanent_address"] = address.text;
    request.fields["status"] = "permanent";
    request.headers["Accept"] = "application/json";
    request.headers["Authorization"] = token!;

    request.files.add(MultipartFile.fromBytes(
        "profile_picture", File(profPhoto!.path).readAsBytesSync(),
        filename: profPhoto!.path));
    request.files.add(MultipartFile.fromBytes(
        "resume", File(profPhoto!.path).readAsBytesSync(),
        filename: profPhoto!.path));

    request.send().then((response) {
      print(response.statusCode);
    });
  }

  dates()
  async {
    var datee = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950, 12, 30),
        lastDate: DateTime.now());
    if (datee != null) {
      setState(() {
        dateB.text =
            DateFormat('dd-MM-yyyy').format(datee);
      });
    }
  }



  @override
  Widget build(BuildContext context) {


    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenH / 10),
        child: AppBar(
          title: Text("Employee", style: TextStyle(color: Colors.black)),
          leading: IconButton(onPressed: () {
              print(nameKey.currentState!.validate());
          }, icon: Icon( Icons.arrow_back_ios_new_rounded, color: Colors.black)),
          backgroundColor: const Color(0xffe4f0f6),
        ),
      ),
      body: FutureBuilder(future: designations(),
        builder: (context,snapshot) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: nameKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: screenW / 2,
                        child: Stack(children: [
                          CircleAvatar(

                              radius: screenW / 4.5),
                          FloatingActionButton(
                            onPressed: () async {
                              ImagePicker Imagepicker = ImagePicker();
                              XFile? image = await Imagepicker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  profPhoto = File(image!.path);
                                });
                              }
                            },
                            child: Icon(Icons.edit),
                            backgroundColor: Colors.white54,
                          )
                        ]),
                      ),
                    ),
                    Text(
                      "First name",
                      style: TextStyle(
                          fontSize: screenW / 21, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter your First name";
                          }
                        },
                        controller: firstName,
                        decoration: InputDecoration(
                          labelText: 'Enter Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenH / 40,
                    ),
                    Text(
                      "Last name",
                      style: TextStyle(
                          fontSize: screenW / 21, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter Last name";
                          }
                        },
                        controller: lastName,
                        decoration: InputDecoration(
                          labelText: 'Enter Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenH / 40,
                    ),
                    Text(
                      "Mobile Number",
                      style: TextStyle(
                          fontSize: screenW / 21, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter mobile number";
                          }
                          if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                            return 'Mobile number should be 10 digits';
                          }
                        },
                        controller: mobileNumber,
                        decoration: InputDecoration(
                          labelText: 'Enter Mobile Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenH / 40,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                          fontSize: screenW / 21, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter Email";
                          }
                          if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                        },
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Enter Mail Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenH / 40,
                    ),
                    Text(
                      "Address",
                      style: TextStyle(
                          fontSize: screenW / 21, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        validator: (value) {
                        if (value!.isEmpty) {
                          return "enter address";
                        }
                      },
                        controller: address,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Enter address',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenH / 40,
                    ),
                    Text(
                      "Date of birth",
                      style: TextStyle(
                          fontSize: screenW / 21, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField( validator: (value) {
                        if (value!.isEmpty) {
                          return "please enter date of birth";
                        }
                      },
                        onTap: () {
                        dates();
                      },
                        controller: dateB,
                        readOnly: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: ()  {
                                dates();
                              },
                              icon: Icon(Icons.calendar_today_rounded)),
                          labelText: 'DOB',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenH / 40,
                    ),
                    Text(
                      "Designation",
                      style: TextStyle(
                          fontSize: screenW / 21, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),border: Border.all(color: Colors.black,width: 0.7)),
                        height: screenH/15,width: double.infinity,
                        child: DropdownButtonFormField(
                            enableFeedback: false,
                            hint: Text(valueChooseDesignation != null ? "$valueChooseDesignation" : "Select one"),
                            borderRadius: BorderRadius.circular(5),
                            value: valueChooseDesignation,
                            items: ListItem.map((valueItem) {
                              return DropdownMenuItem(alignment: Alignment.center,
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                            onChanged: (newvalue) {
                              setState(() {
                                valueChooseDesignation = newvalue;
                                print(valueChooseDesignation);

                              });
                            },
                            validator: (value) {
                      if (value!.isEmpty) {
                      return "select designation";
                      }
                      },
                        ),
                      )
                    ),
                    SizedBox(
                      height: screenH / 40,
                    ),
                    Text(
                      "Gender",
                      style: TextStyle(
                          fontSize: screenW / 21, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child:  Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),border: Border.all(color: Colors.black,width: 0.7)),
                        height: screenH/15,width: double.infinity,
                        child: DropdownButtonFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "select gender";
                              }
                            },   enableFeedback: false,
                            hint: Text(valueChooseGender != null ? "$valueChooseGender" : "Select one"),
                            borderRadius: BorderRadius.circular(5),
                            value: valueChooseGender,
                            items: ListItemGender.map((valueItem) {
                              return DropdownMenuItem(
                              alignment: Alignment.center,
                                value: valueItem,
                                child: Text(valueItem),
                              );
                            }).toList(),
                            onChanged: (newvalue) {
                              setState(() {
                                valueChooseGender = newvalue;
                                print(valueChooseGender);

                              });
                            }
                        ),
                      )
                    ),
                    SizedBox(
                      height: screenH / 70,
                    ),
                    Center(
                      child: SizedBox(
                        width: screenW / 1.2,
                        height: screenH / 16,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue[900])),
                            onPressed: () {
                              print("d");

                              var s = nameKey.currentState!.validate();
                                if (s == true) {
                                  print("t");
                                addEmployee();
                                 }
                                else {
                                  print("u");

                                  print("not working");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Center(
                                        child: Text(
                                            "credential doesn't match",
                                            style: TextStyle(
                                                color: Colors.red))),
                                    backgroundColor: Colors.white,
                                  ));
                                }
                              },

                            child: Text("Save",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600))),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

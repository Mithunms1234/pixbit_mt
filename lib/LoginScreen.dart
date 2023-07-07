import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Employee.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> namekey = GlobalKey<FormState>();

  loginapi() async {
    var body = {"email": username.text, "password": password.text};
    var response = await post(Uri.parse("http://training.pixbit.in/api/login"),
        body: body);
    var responseBody = jsonDecode(response.body);
    print(responseBody);

    if (responseBody["message"] == "User Logged in") {
      SharedPreferences sharedpref = await SharedPreferences.getInstance();
      await sharedpref.setString(
          "access_token", responseBody["data"]["access_token"]);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Empoloyee(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(
            child: Text("credential doesn't match",
                style: TextStyle(color: Colors.red))),
        backgroundColor: Colors.white,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: screenH,
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: screenW,
                    child: Padding(
                      padding:
                          EdgeInsets.fromLTRB(screenW / 8, screenH / 5, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome Back",
                              style: TextStyle(
                                  fontSize: screenW / 12,
                                  fontWeight: FontWeight.bold)),
                          Text("Please login to your account",
                              style: TextStyle(fontSize: screenW / 20)),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    color: const Color(0xffe4f0f6),
                    child: Form(
                      key: namekey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenW / 18,
                                right: screenW / 18,
                                top: screenH / 19),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white70),
                              height: screenH / 13,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenW / 23,
                                    right: 0,
                                    top: screenH / 100),
                                child: TextFormField(
                                  controller: username,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "please enter the username";
                                    }
                                    if (v.contains(" ")) {
                                      return "username should not contain space";
                                    }

                                    var alpbt = RegExp(r'^[a-zA-Z0-9.@]+$');
                                    if (!alpbt.hasMatch(v)) {
                                      return 'Invalid characters. Only alphanumeric characters are allowed';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: "Username",
                                      icon: Icon(Icons.mail_outline,
                                          color: Colors.black),
                                      enabledBorder: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenW / 18,
                                right: screenW / 18,
                                top: screenH / 37),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white70),
                              height: screenH / 13,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenW / 23,
                                    right: 0,
                                    top: screenH / 100),
                                child: TextFormField(
                                  controller: password,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return "please enter the password";
                                    }
                                    if (v.length < 5) {
                                      return "password is too short";
                                    }
                                    var passwordRegex =
                                        RegExp(r'^[a-zA-Z0-9@]+$');
                                    if (!passwordRegex.hasMatch(v)) {
                                      return "Invalid characters. Only alphanumeric characters and @ are allowed";
                                    }
                                  },
                                  decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.black),
                                      hintText: "Password",
                                      icon:
                                          Icon(Icons.key, color: Colors.black),
                                      enabledBorder: InputBorder.none),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenH / 20),
                          SizedBox(
                            width: screenW / 1.15,
                            height: screenH / 17,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.blue[900])),
                                onPressed: () {
                                  var s = namekey.currentState!.validate();
                                  if (s == true) {
                                    loginapi();
                                  } else {
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
                                child: Text("Sign in",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

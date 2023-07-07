import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pixbit_mt/Add%20employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Employee details screen.dart';

class Empoloyee extends StatefulWidget {
  const Empoloyee({super.key});

  @override
  State<Empoloyee> createState() => _EmpoloyeeState();
}

class _EmpoloyeeState extends State<Empoloyee> {
  Future<dynamic> getEmployee() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    var token = await sharedpref.getString("access_token");

    print(token);

    Map<String, String> header = {
      'Accept': 'application/json',
      'Authorization': "Bearer ${token.toString()}"
    };
    var response = await get(
        Uri.parse("http://training.pixbit.in/api/employees"),
        headers: header);

    return jsonDecode(response.body);
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
          leading: IconButton(
            onPressed: () {

            },
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          ),
          backgroundColor: const Color(0xffe4f0f6),
        ),
      ),
      body: FutureBuilder(
        future: getEmployee(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return Center(child: CircularProgressIndicator());
            }
          if(snapshot.hasData)
          {
            return ListView.builder(
              itemCount: snapshot.data["data"]["data"].length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: screenH / 10,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return EmpoyeeDetailsScreen(name: snapshot.data["data"]["data"][index]["first_name"],
                            address: snapshot.data["data"]["data"][index]["present_address"],contactNumber: snapshot.data["data"]["data"][index]["mobile"],
                          dateOfBirth: snapshot.data["data"]["data"][index]["date_of_birth"],gender: snapshot.data["data"]["data"][index]["gender"],
                            position: snapshot.data["data"]["data"][index]["status"],image: snapshot.data["data"]["data"][index]["profile_image"],email: snapshot.data["data"]["data"][index]["email"],
                          );
                        },
                      ));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(snapshot.data["data"]["data"][index]["profile_image"]),
                    ),
                    title:
                    Text("${snapshot.data["data"]["data"][index]["first_name"]}", style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text("${snapshot.data["data"]["data"][index]["mobile"]}"),
                  ),
                );
              },
            );
          }
          else {
            return Text("no employee");
          }
        }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[900],
        tooltip: 'Increment',
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AddEmployee();
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

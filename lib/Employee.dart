import 'package:flutter/material.dart';
import 'package:pixbit_mt/Add%20employee.dart';

import 'Employee details screen.dart';

class Empoloyee extends StatefulWidget {
  const Empoloyee({super.key});

  @override
  State<Empoloyee> createState() => _EmpoloyeeState();
}

class _EmpoloyeeState extends State<Empoloyee> {

  api()
  {

  }

  @override
  Widget build(BuildContext context) {
    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
      PreferredSize(  preferredSize: Size.fromHeight(screenH/10),
      child: AppBar(
        title: Text("Employee",style: TextStyle(color: Colors.black)),
        leading: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black),
          backgroundColor: const Color(0xffe4f0f6),
        ),
      ),
      body: ListView.builder(itemCount: 15,
      itemBuilder: (context, index) {
         return SizedBox(height: screenH/10,
       child: ListTile(onTap: () {
         Navigator.of(context).push(
             MaterialPageRoute(
               builder: (context) {
                 return
                   EmpoyeeDetailsScreen();
               },)
         );
       },
            leading:
            CircleAvatar(backgroundImage: NetworkImage(""),),
          title: Text("Name",style: TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text("number"),
        ),
         );
      },
        ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.blue[900],
        tooltip: 'Increment',
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return
                    AddEmployee();
                },)
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

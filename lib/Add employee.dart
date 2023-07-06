import 'package:flutter/material.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(width: screenW/2,
                  child: Stack(children: [
                    CircleAvatar(backgroundImage: NetworkImage(""),radius: screenW/4.5),
                    FloatingActionButton(
                      onPressed: () {

                    },child: Icon(Icons.edit),backgroundColor: Colors.white54,)
                  ]
                  ),
                ),
              ),
              Text("First name",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
SizedBox(height: screenH/40,),
              Text("Last name",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Name',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenH/40,),
              Text("Mobile Number",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Mobile Number',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenH/40,),
              Text("Email",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Mail Address',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenH/40,),
              Text("Address",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Enter address',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenH/40,),
              Text("Date of birth",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '08/11/2001',
                    icon: IconButton(onPressed: () {
                      
                    }, icon: Icon(Icons.date_range)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenH/40,),
              Text("Designation",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'select one',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenH/40,),
              Text("Gender",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Select one',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenH/70,),
              Center(
                child: SizedBox(width: screenW/1.2,height: screenH/16,
                  child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue[900])),
                      onPressed: () {

                      },
                      child:Text("Save",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600))
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

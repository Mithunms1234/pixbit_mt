import 'package:flutter/material.dart';

class EmpoyeeDetailsScreen extends StatefulWidget {
  const EmpoyeeDetailsScreen({super.key});

  @override
  State<EmpoyeeDetailsScreen> createState() => _EmpoyeeDetailsScreenState();
}

class _EmpoyeeDetailsScreenState extends State<EmpoyeeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
      PreferredSize(  preferredSize: Size.fromHeight(screenH/10),
        child: AppBar(
          title: Text("Name of employee",style: TextStyle(color: Colors.black)),
          leading: Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black),
          backgroundColor: const Color(0xffe4f0f6),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: screenH/15,right: screenW/10,left: screenW/10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundImage: NetworkImage(""),radius: screenW/5),
              ],
            ),
            SizedBox(height: screenH/39,),
            Text("Name",style: TextStyle(fontSize: screenW/14,fontWeight: FontWeight.bold),
            ),
            Text("position",style: TextStyle(fontSize: screenW/19),),
            SizedBox(height: screenH/30),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenW/2.5,height: screenH/6,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text("Contact Number",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
                      ),
                      Text("+916546546544",style: TextStyle(fontSize: screenW/23),
                      ),
                      SizedBox(height: screenH/25,),
                      Text("Date of birth",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
                      ),
                      Text("12-02-2001",style: TextStyle(fontSize: screenW/23),
                      ),
                    ],))
                  ],
                ),

                Column(
                  children: [
                    SizedBox(width: screenW/2.5,height: screenH/6,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text("Date of birth",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
                      ),
                      Text("12-02-2001",style: TextStyle(fontSize: screenW/23),
                      ),
                          SizedBox(height: screenH/25,),
                          Text("Gender",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
                          ),
                          Text("Male",style: TextStyle(fontSize: screenW/23),
                          ),
                    ]),),
                  ],
                ),
              ],
            ),
            Row(children: [
              SizedBox(height: screenH/25,),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address",style: TextStyle(fontSize: screenW/21,fontWeight: FontWeight.bold),
                  ),
                  Text(".............................................",style: TextStyle(fontSize: screenW/23),
                  ),
                ],
              ),
            ],)
          ],
        ),
      ),
    );
  }
}

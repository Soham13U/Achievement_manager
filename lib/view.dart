import 'package:ach/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewProfile extends StatefulWidget {
  String uid;
  ViewProfile(String uid) {
    this.uid = uid;
    print('uid4 ' + this.uid);
  }
  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserInfo>>(context);
   // final user = Provider.of<QuerySnapshot>(context);
    //print('users:');
    //print(users.documents);
    print('uid:' + widget.uid);
    UserInfo finaluser = UserInfo();
    //for (var doc in user.documents) {
      //if (doc.data['uid'] == widget.uid) {
        //if (doc.data['check'] == 'true') {
    if (users != null)
      users.forEach((user) {
        print(user.name);
        print(user.id);
        if (user.uid == widget.uid) {
          finaluser = user;
        }
      });
    print('Final Name:' + finaluser.name);

    if (finaluser.check == 'true') {
      return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text('Profile details'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SizedBox(height: 30),
                    Center(
                      child: CircleAvatar(    
                        radius:90.0,
                        child: ClipOval(
                          child: Image.network(
                            (finaluser.image!=null)?
                                                //fullPathImage+'?alt=media' : " ",
                                                //fit: BoxFit.fill

                            '${finaluser.image}' + '?alt=media': " ",
                        fit: BoxFit.fill,
                        ),
                        ),
                      ),
                    ),

                SizedBox(height: 40),
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  finaluser.name,
                  style: TextStyle(
                    color: Colors.lightBlue[200],
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Id',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  finaluser.id,
                  style: TextStyle(
                    color: Colors.lightBlue[200],
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Year of Admission',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  finaluser.course,
                  style: TextStyle(
                    color: Colors.lightBlue[200],
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'CGPA',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  finaluser.department,
                  style: TextStyle(
                    color: Colors.lightBlue[200],
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
               
                SizedBox(height: 30),
                Text(
                  'Instituename',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  finaluser.instituename,
                  style: TextStyle(
                    color: Colors.lightBlue[200],
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Bio',
                  style: TextStyle(
                    color: Colors.grey,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  finaluser.seating,
                  style: TextStyle(
                    color: Colors.lightBlue[200],
                    fontSize: 28.0,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: Colors.grey[400],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      finaluser.email,
                      style: TextStyle(
                          color: Colors.grey[400],
                          letterSpacing: 1.0,
                          fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.phone,
                      color: Colors.grey[400],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      finaluser.no,
                      style: TextStyle(
                          color: Colors.grey[400],
                          letterSpacing: 1.0,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text('Profile details'),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Text(
                'Name',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10),
              Text(
                finaluser.name,
                style: TextStyle(
                  color: Colors.lightBlue[200],
                  fontSize: 28.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Id',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 10),
              Text(
                finaluser.id,
                style: TextStyle(
                  color: Colors.lightBlue[200],
                  fontSize: 28.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    finaluser.email,
                    style: TextStyle(
                        color: Colors.grey[400],
                        letterSpacing: 1.0,
                        fontSize: 18.0),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Update your profile for more details',
                style: TextStyle(
                    color: Colors.grey[400],
                    letterSpacing: 1.0,
                    fontSize: 18.0),
              ),
            ],
          ),
        ),
      );
    }
    return Container();
  }
}
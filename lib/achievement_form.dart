import 'dart:async';

import 'dart:io';
import 'package:ach/achievement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ach/update.dart';

import 'user.dart';
import 'user.dart';


class AchievementForm extends StatefulWidget {
  @override
  _AchievementFormState createState() => _AchievementFormState();
  
}

class _AchievementFormState extends State<AchievementForm> {
  File _image;


  final picker = ImagePicker();

 
    // ignore: non_constant_identifier_names
    TextEditingController ach_image = TextEditingController();
    TextEditingController category = TextEditingController();
    TextEditingController description = TextEditingController();
    // ignore: non_constant_identifier_names
    File Image;
    String imgurl;
    
    FirebaseAuth auth = FirebaseAuth.instance;
    sendData() async {
     
       FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
       print(firebaseUser.uid.toString());
       var image = FirebaseStorage.instance.ref().child(Image.path);
       var task =  image.putFile(Image);
       imgurl = await  (await task.onComplete).ref.getDownloadURL();
       await Firestore.instance.collection("final_ach").document().setData({'ach_image':imgurl.toString(),'category':category.text.toString(),'description':description.text.toString(),'uid':firebaseUser.uid.toString(),'email':firebaseUser.email.toString()});
     
    
     
    }

    Future getImage() async{

      var img = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        Image = img;
      });
    }

  @override
  Widget build(BuildContext context) {

    final formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Achievements'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          

              child: Form(key: formkey,
              child: Column(
              children: <Widget>[
              
              Padding(
              padding: EdgeInsets.all(25),
              child:InkWell(
                onTap: () => getImage(),
                child: CircleAvatar(
                radius:100,
                backgroundImage:Image != null ? FileImage(Image): NetworkImage("null"), 
              ),),),
              
              Container(
              
              padding: EdgeInsets.all(25),
              child: TextFormField(
                controller: ach_image,
                validator:(value)
                {
                  if(value.isEmpty)
                  {
                    return "it is empty";
                  }
                  else
                  {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "image"
                ),
              )                
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 10, bottom: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.deepPurple),
                ),
                child: TextFormField(
                  controller: category,
                  validator:(value)
                  {
                  if(value.isEmpty)
                  {
                    return "it is empty";
                  }
                  else
                  {
                    return null;
                  }
                },
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  style: TextStyle(fontSize: 18),
                  
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 8),
                    hintText: 'Category',
                  ),
                
                ),
              ),
               Container(
                margin: EdgeInsets.only(top: 40),
                child: Text(
                  'Decription',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 400,
                margin: EdgeInsets.only(top: 10, bottom: 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.deepPurple),
                ),
                child: TextFormField(
                  controller: description,
                validator:(value)
                {
                  if(value.isEmpty)
                  {
                    return "it is empty";
                  }
                  else
                  {
                    return null;
                  }
                },
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 8),
                    hintText: 'Decription....',
                  ),
                ),
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Color(0xff2F1E54),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  sendData();
                },
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Color(0xff2F1E54),
                child: Text(
                  'Show Achievements',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>Achievement()));
                },
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }
}


                               

 

// Container(
//   padding: EdgeInsets.all(10),
//   width: MediaQuery.of(context).size.width,
//   height: 250,
//   decoration: BoxDecoration(
//     border: Border.all(color: Colors.black, width: 5),
//     borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(40),
//         bottomRight: Radius.circular(40)),
//     shape: BoxShape.rectangle,
//     color: Colors.white,
//     image: DecorationImage(
//       fit: BoxFit.contain,
//       image: AssetImage('images/certificate.jpg'),
//     )
//   ),
// ),
// Padding(
//   padding: EdgeInsets.only(top: 10, left: 330),
//   child: CircleAvatar(
//     backgroundColor: Colors.black54,
//     child: IconButton(
//       icon: Icon(
//         Icons.camera_alt,
//         color: Colors.white,
//       ),
//       onPressed: () {},
//     ),
//   ),
// ),

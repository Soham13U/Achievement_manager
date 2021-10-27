import 'package:ach/database.dart';
import 'package:ach/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  String uid;
  int cnt = 0;
  ProfilePage({this.uid});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
  if (value.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}

final TextStyle PLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  File _image;
  int flag=0;
  final List<String> _institute = [
    'CSPIT',
    'DEPSTAR',
    'I2IM',
    'CMPICA',
    'RPCP',
    'PDPIAS',
    'MTIN',
    'ARIP',
    'CIPS'
  ];
  var _currentItemSelected;
  final List<String> _department = [
    '> 9.0',
    '7.5 to 9.0',
    '< 7.5'
  ];
  

  var _currentSelected;
  String _username, _course, _areaofexpertise, _contact, _seating, _email,productImage,_id;
  

 
  
  @override
  Widget build(BuildContext context) {
    List gender = ["Male", "Female"];
    String select;
    Row addRadioButton(int btnValue, String title) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: gender[btnValue],
            groupValue: select,
            onChanged: (value) {
              setState(() {
                print(value);
                select = value;
              });
            },
          ),
          Text(title)
        ],
      );
    }
   var fullPathImage;
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
       
    
    }
   
      /*String fileName;
      Future uploadPic(BuildContext context) async{
       fileName = basename(_image.path);
       StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
       StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
       setState(() {
          print("Profile Picture uploaded");
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
       });
    }*/
      //String part1 = 'https://console.firebase.google.com/project/facexpo-441ae/storage/facexpo-441ae.appspot.com/';
      //fullpath = part1+fileName;
      
    return StreamBuilder<UserInfo>(
        stream: DatabaseService(uid2: widget.uid).userInfo,

        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserInfo userInfo = snapshot.data;
            fullPathImage = userInfo.image;
            if (widget.cnt == 0) {
              _username = userInfo.name;
              _currentItemSelected = userInfo.instituename;
              _currentSelected = userInfo.department;
              _course = userInfo.course;
              _email = userInfo.email;
              _id = userInfo.id;
              _seating = userInfo.seating;
              _areaofexpertise = userInfo.expertise;
              _contact = userInfo.no;
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xff2F1E54),
                leading: IconButton(
                    icon: Icon(FontAwesomeIcons.arrowLeft),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                title: Text('Edit Profile'),
              ),
              resizeToAvoidBottomPadding: false,
              body:
                  // Builder(
                  // builder: (context) =>
                  //   Container(
                  // child:

                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[

                  // SizedBox(
                  //   height: 20.0,
                  // ),
                 SingleChildScrollView(
                                      child: Container(
                                        height: 1000,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Form(
                              key: _formKey,
                            
                            child:Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: Container(
                            
                              child: new ConstrainedBox(
                                constraints: new BoxConstraints(),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: CircleAvatar(
                                              radius: 100,
                                              backgroundColor: Color(0xff2F1E54),
                                              child: ClipOval(
                                                child: new SizedBox(
                                                

                                                  width: 180.0,
                                                  height: 180.0,
                                                  
                                                   child: 
                                                    
                                                 (_image != null)
                                                      ? Image.file(
                                                          _image,
                                                          fit: BoxFit.fill,
                                                        )

                                                      : Image.network(
                                                        (userInfo.image!=null)?
                                                          userInfo.image+'?alt=media': " ",
                                                          fit: BoxFit.fill
                                                        ),
                                                     // NetworkImage(userInfo.image),
                                                 
                                                ),
                                                
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 60.0),
                                          child: IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.camera,
                                              size: 30.0,
                                            ),
                                            onPressed: () {
                                              flag=1;
                                              getImage();
                                              widget.cnt++;
                                             
                                             
                                             
                                              //print(fullPathImage);
                                            
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextFormField(
                                      initialValue: userInfo.name,
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Please type Name';
                                        }
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          _username = val;
                                          widget.cnt++;
                                        });
                                      },
                                      //onFieldSubmitted: (input) => _username = input,
                                      decoration: InputDecoration(
                                          labelText: 'Username', labelStyle: PLabelStyle),
                                    ),
                                    Row(children: <Widget>[
                                      Text(
                                        'Institue Name',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      DropdownButton<String>(
                                        value:
                                            _currentItemSelected ?? userInfo.instituename,
                                        items:
                                            _institute.map((String dropDownStringItem) {
                                          return DropdownMenuItem<String>(
                                            value: dropDownStringItem,
                                            child: Text(dropDownStringItem),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                           this. _currentItemSelected = val;
                                            widget.cnt++;

                                          });
                                        },
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(children: <Widget>[
                                      Text(
                                        'CGPA',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'OpenSans',
                                            fontSize: 16.0),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      DropdownButton<String>(
                                        value: _currentSelected ?? userInfo.department,
                                        items:
                                            _department.map((String dropDownStringItem) {
                                          return DropdownMenuItem<String>(
                                            value: dropDownStringItem,
                                            child: Text(dropDownStringItem),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          setState(() {
                                           this. _currentSelected = val;
                                            widget.cnt++;
                                          });
                                        },
                                        
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFormField(
                                      initialValue: userInfo.course,
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Please type Year of admission';
                                        }
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          _course = val;
                                          userInfo.course = val;
                                          widget.cnt++;
                                        });
                                      },
                                      //onFieldSubmitted: (input) => _course = input,
                                      decoration: InputDecoration(
                                          labelText: 'Year of admission', labelStyle: PLabelStyle),
                                    ),
                                    TextFormField(
                                      initialValue: userInfo.email,
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Please type email';
                                        }
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          _email = val;
                                          userInfo.email = val;
                                          widget.cnt++;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'email', labelStyle: PLabelStyle),
                                    ),
                                    TextFormField(
                                      initialValue: userInfo.id,
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return 'Please type id';
                                        }
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          _id = val;
                                          userInfo.id = val;
                                          widget.cnt++;
                                        });
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Id', labelStyle: PLabelStyle),
                                    ),
                                    TextFormField(
                                      initialValue: userInfo.seating,
                                      validator: (input) {
                                        if (input.isEmpty) {
                                          return '';
                                        }
                                      },
                                      onChanged: (val) {
                                        setState(() {
                                          _seating = val;
                                          userInfo.seating = val;
                                          widget.cnt++;
                                        });
                                      },
                                      //onFieldSubmitted: (input) => _seating = input,
                                      decoration: InputDecoration(
                                          labelText: 'Bio', labelStyle: PLabelStyle),
                                    ),
                                   
                                    TextFormField(
                                      initialValue: userInfo.no,
                                      decoration: InputDecoration(
                                          labelText: 'Contact no.',
                                          labelStyle: PLabelStyle),
                                      keyboardType: TextInputType.phone,
                                      validator: validateMobile,
                                      onChanged: (val) {
                                        setState(() {
                                          _contact = val;
                                          userInfo.no = val;
                                          widget.cnt++;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          color: Color(0xff2F1E54),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          elevation: 4.0,
                                          splashColor: Colors.blueGrey,
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          ),
                                        ),
                                        RaisedButton(
                                          color: Color(0xff2F1E54),
                                          
                                          onPressed: () async {
                                             if(flag==1){
                                                DateTime now = DateTime.now();
                                            String nuevoformato =
                                                DateFormat('kk:mm:ss:MMMMd').format(now);
                                            var fullImageName = 'nomfoto-$nuevoformato' + '.jpg';
                                            var fullImageName2 = 'nomfoto-$nuevoformato' + '.jpg';

                                            final StorageReference ref =
                                                FirebaseStorage.instance.ref().child(fullImageName);
                                            final StorageUploadTask task = ref.putFile(_image);

                                            var part1 =
                                                'https://firebasestorage.googleapis.com/v0/b/achievements-7f19b.appspot.com/o/'; 
                                              
                                            fullPathImage = part1 + fullImageName2;
                                            flag=0;
                                             }
                                             
                                            if(_formKey.currentState.validate()){
                                             
                                           // Image.network(fullPathImage);
                                           print(fullPathImage);
                                            print(_username);
                                            print(_course);
                                            print(_contact);
                                            print(_areaofexpertise);
                                            print(_currentItemSelected);
                                            print(_currentSelected);
                                            print(_department);
                                            print(_seating);
                                            
                                            await DatabaseService().updateUser(
                                                //'$fullpath' ?? userInfo.image,
                                                fullPathImage ?? userInfo.image,
                                                _username ?? userInfo.name,
                                                widget.uid,
                                                _currentItemSelected ?? userInfo.instituename,
                                                _currentSelected ?? userInfo.department,
                                                _course ?? userInfo.course,
                                                _seating ?? userInfo.seating,
                                                //_areaofexpertise ?? userInfo.expertise,
                                                _contact ?? userInfo.no,
                                                _email ?? userInfo.email,
                                                _id ?? userInfo.id);
                                            print('done');
                                            Navigator.pop(context);

                                          }
                                          
                                         },
                                          elevation: 4.0,
                                          splashColor: Colors.blueGrey,
                                          child: Text(
                                            'Submit',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                ),
              ),
                          ),
                        ],
                      ),
                    ),
                  ),
              //     ],
              //   ),
              // ),
              //  ),
                  );
            
          } else {
            print('Error in doc');
          }
        });
  }
}

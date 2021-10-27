import 'package:ach/Login.dart';
import 'package:ach/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String error = '';
  bool showSpinner = false;
String _name, _email = '', _password= '';
 List designation = ["Admin" , "Student"];
  bool checkEmail(String email) {
    print(email.substring(email.length - 7));
    if (email.substring(email.length - 7) == '.edu.in')
      return true;
    else if (email.substring(email.length - 6) == '.ac.in')
      return true;
    else
      return false;
  }

 final Authservice _auth = Authservice();

 
 String select;
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: Theme.of(context).primaryColor,
          value: designation[btnValue],
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
              child: Container(

          child: Column(

            children: <Widget>[

        

              Container(

                child: Form(
   
                 key: _formKey,
                 child: Column(

                   children: <Widget>[
                         SizedBox(height:80),
                         Text('SignUp',style: TextStyle(

                      color: Color(0xff2F1E54),
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold
                      
                      )),
                         SizedBox(height:10),
                    
                    Padding(
                      padding:EdgeInsets.fromLTRB(30, 50, 30, 10),
                       child: Column(children: [
                          Container(

                       child: TextFormField(
                         onChanged: (val){
                           setState(() {
                             _name =val;
                           });
                         },
                         validator: (input)
                         {
                            if(input.isEmpty)

                            return 'Enter Name';
                         },

                            decoration: InputDecoration(

                              labelText: 'Name',
                               labelStyle: TextStyle( color: Color(0xff2F1E54),),
                              prefixIcon:Icon(Icons.person,
                               color: Color(0xff2F1E54),),
                            ),


                            

                         
                       ),
                     ),
                        SizedBox(height:10),
                         Container(

                       child: TextFormField(
                         
                         onChanged: (val){
                           setState(() {
                             _email=val;
                           });
                         },
                         validator: (input)
                         {
                            if(input.isEmpty)

                            return 'Enter Email';
                         },

                            decoration: InputDecoration(

                              labelText: 'Email',
                               labelStyle: TextStyle( color: Color(0xff2F1E54),),
                              prefixIcon:Icon(Icons.email,
                               color: Color(0xff2F1E54),)
                            ),

                            //onSaved: (input) => _email = input

                         
                       ),
                     ),
                        SizedBox(height:10),
                     Container(

                       child: TextFormField(
                          onChanged: (val){
                           setState(() {
                             _password =val;
                           });
                         },
                         validator: (input)
                         {
                            if(input.length < 6)

                            return 'Provide Minimum 6 Character';
                         },

                            decoration: InputDecoration(

                              labelText: 'Password',
                               labelStyle: TextStyle( color: Color(0xff2F1E54),),
                              prefixIcon:Icon(Icons.lock,
                               color: Color(0xff2F1E54),),
                            ),
                            obscureText: true,


                         //   onSaved: (input) => _password = input

                         
                       ),
                     ),
                       ],),
                    ),
                        SizedBox(height:10),
                      Row(
                children: <Widget>[
                   SizedBox(width:20),
                  Text(
                      
                    'Designation',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 16.0),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  addRadioButton(0, 'Admin'),
                  addRadioButton(1, 'Student'),
                ],
              ),
                     SizedBox(height:20),

                     RaisedButton(
                       padding: EdgeInsets.fromLTRB(70,10,70,10),
                       onPressed: () async {
                  String finalname = _name;
                  if (checkEmail(_email)) {
                    print(_email);
                    print(_password);
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        _email, _password, finalname);
                    if (result == null) {
                      print('Error');
                    } else {
                      Navigator.pop(context);
                      print('Sucess');
                      //runApp(Temp());
                      //Navigator.pushNamed(context, '/temp');
                    }
                  } else {
                    setState(() {
                      error = 'please Sign up with college id';
                    });
                  }
                },
                      child: Text('SignUp',style: TextStyle(

                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                      
                      )),

                      color: Color(0xff2F1E54),
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(20.0),
                      ),
                     
                     )
                   ],
                 ),

                ),
              ),
              SizedBox(height:10),
              GestureDetector(
                         onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => Login()));
                  },
                        child: OutlineButton(
                          btnText: "Login",
                        ),
                      )
             
            ],
          ),
        ),
      )
      
    );
  }
}


class OutlineButton extends StatefulWidget {
  final String btnText;
  OutlineButton({this.btnText});
  @override
  _OutlineButtonState createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
    padding: EdgeInsets.fromLTRB(10,10,10,10),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff2F1E54), width: 2),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(color: Color(0xff2F1E54), fontSize: 15),
        ),
      ),
    );
  }
}



                      
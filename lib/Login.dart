import 'package:ach/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ach/SignUp.dart';
import 'package:ach/database.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

final formKey =new GlobalKey<FormState>();
  String _email ='', _password='';
  //Auth object
   final Authservice _auth = Authservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
              child: Container(

          child: Column(

            children: <Widget>[

              Container(

                height: 300,
                child: Image(image: AssetImage("images/login.jpg"),
                fit: BoxFit.contain,
                ),
              ),

              Container(

                child: Form(
   
                 key: formKey,
                 child: Column(

                   children: <Widget>[
               SizedBox(height:25),
                     Padding(
                       padding: EdgeInsets.fromLTRB(30,0,30,0),
                       child: Column(
                         children: [
                           Container(

                       child: TextFormField(
                         onChanged: (val){
                           _email = val;
                         },
                         validator: (input)
                         {
                            if(input.isEmpty)

                            return 'Enter Email';
                          
                         },

                            decoration: InputDecoration(

                              labelText: 'Email',
                              labelStyle: TextStyle( color: Color(0xff2F1E54),),
                              focusColor: Color(0xff2F1E54),
                              prefixIcon:Icon(
                                Icons.email,
                                color: Color(0xff2F1E54),)
                              

                            ),

                          //  onSaved: (input) => _email = input

                         
                       ),
                     ),
                       SizedBox(height:10),
                     Container(

                       child: TextFormField(
                         onChanged: (val){
                           _password = val;
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


                           // onSaved: (input) => _password = input

                         
                       ),
                     ),
                         ],
                       ),),
                     SizedBox(height:20),

                     RaisedButton(
                       padding: EdgeInsets.fromLTRB(70,10,70,10),
                      onPressed:   () async {
                    print(_email);
                    print(_password);
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(_email, _password);
                    if (result == null) {
                      print('Error');
                    } else {
                      print('Sucess');
                      //Navigator.pushNamed(context, '/temp');
                    }
                  },
                      child: Text('LOGIN',style: TextStyle(

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
                            builder: (context) => SignUp()));
                  },
                        child: OutlineButton(
                          btnText: "Create New Account",
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



                      
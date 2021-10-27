import 'package:flutter/material.dart';
import 'package:ach/Login.dart';
import 'SignUp.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {

  navigateToLogin()async{

    Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
  }

   navigateToRegister()async{

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Column(
          children: <Widget>[

            SizedBox(height: 90.0),

            Container(
              height: 300,
              width: 300,

              child: Image(image: AssetImage("images/logo2.png"),
              fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 20.0),
            RichText(
              
              text: TextSpan(
               
                children: <TextSpan>[
                  TextSpan(
                    text: 'Achievement Manager', style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color:Color(0xff2F1E54))
                  )
                ]
              ) 
            ),
            SizedBox(height: 30.0),

            

           


            Row( mainAxisAlignment: MainAxisAlignment.center,

              children: <Widget>[

                RaisedButton(
                  padding: EdgeInsets.only(left:30,right:40),
                  
                  onPressed: navigateToLogin,
                  child: Text('  LOGIN',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  ),),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xff2F1E54)
                ),

                SizedBox(width:20.0),

                RaisedButton(
                  padding: EdgeInsets.only(left:30,right:25),
                  
                  onPressed: navigateToRegister,
                  child: Text('REGISTER',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  ),),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xff2F1E54)
                ),

              ],
            ),

            
                SizedBox(height : 20.0),

                
          ],
        ),
      ),
      
    );
  }
}
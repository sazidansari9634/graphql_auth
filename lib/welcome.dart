import 'package:flutter/material.dart';
import 'package:graphql_auth/auth/login.dart';
import 'package:graphql_auth/auth/signup.dart';
import 'package:graphql_auth/auth/users_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text("Welcome Page"),),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "GraphQL Auth!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ),
                  const SizedBox(height: 30,),
                  Text("This Page is Authentication of the GraphQL Flutter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15
                      ),
                  ),
                ],
              ),
               
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "resources/images/welco.png",
                          width: 200,
                          height: 120,
                        )
                      ],
                    )
                  ],
                  
                 ),
              Column(
                children: [
                   MaterialButton(
                    minWidth: double.infinity,
                    height:60,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  LoginScreen()));
                    },
                    color: Colors.indigoAccent[400],
                    shape: RoundedRectangleBorder(
                      side:const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child:const Text("Login",style: TextStyle(
                      fontWeight: FontWeight.w600,fontSize: 16,color: Colors.white70

                    ),),    
             
          ),
          const Divider(),
          MaterialButton(
                      minWidth: double.infinity,
                      height:60,
                      onPressed: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SignupScreen()));

                      },
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      ),
                      child: const Text("Sign UP",style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: 16,

                      ),),
                    ),
                ],
              )

         
                    
    ],
    ),
     
    
    ),
    
    ),
    
    );
    
  }
}
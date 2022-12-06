import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:graphql_auth/auth/auth_gql.dart';
import 'package:graphql_auth/auth/login.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset(
                          "resources/images/welco.png",
                          width: 200,
                          height: 120,
                        )),
              ),
            ),
            
              Mutation(
                options:MutationOptions(document: gql(insertUser()),
                fetchPolicy: FetchPolicy.noCache,
                onCompleted: ((data) {
                  setState(() {
                    _isSaving = false;
                  });
                  print(data.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      content: 
                      AwesomeSnackbarContent(title: "Successfully Signup!",
                       message: "",
                        contentType: ContentType.success)
                    ),
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                })
                ),
                builder: ((runMutation, result) {
                  final _firstNameController = TextEditingController();
                  final _lastNameController = TextEditingController();
                  final _emailController    = TextEditingController();
                  final _passwordController = TextEditingController();
                
                return Form(
                key: _formKey,
                child: Column(
                children: [
                  Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                child: TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'FirstName',
                      ),
                     
                      keyboardType: TextInputType.text,
                ),
                           ),
                          Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0,top:15,bottom: 0),
                child: TextField(
                 controller: _lastNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'LastName',
                      ),
                     
                      keyboardType: TextInputType.text,
                ),
                          ),
              Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0,top:15,bottom: 0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      ),
                      
                      keyboardType: TextInputType.emailAddress,
                ),
                          ),
                          Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                child: TextField(
                 controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      ),
                     
                      keyboardType: TextInputType.text,
                ),
                          ),
            Padding(
              padding:  EdgeInsets.only(top: 15),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isSaving = true;
                    });
                    if(_formKey.currentState!.validate()){
                     runMutation({
                      "firstName" : _firstNameController.text.trim(),
                      "lastName"  : _lastNameController.text.trim(),
                      "email"     : _emailController.text.trim(),
                      "password"  : _passwordController.text.trim(),
                     }); 
                    
                
                     ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data'),
                    backgroundColor: Colors.indigo,
                    ),
                   );                    }
                   // Navigator.push(
                     //   context, MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }),
  )
  ])));
  }
  
}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:graphql_auth/auth/auth_gql.dart';
import 'package:graphql_auth/auth/users_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isSaving = false;
  String Token = "";

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    var _token;
    final token = await _token.getToken();
    setState(() {
      Token = token;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
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
                    child: Image.asset(
                          "resources/images/welco.png",
                          width: 200,
                          height: 120,
                        )),
              ),
            ),
           
            Mutation(
              options: MutationOptions(document: gql(loginUser()),
              fetchPolicy: FetchPolicy.noCache,
              onCompleted: (result) async {
                setState(() {
                  _isSaving = false;
                });
                print(result.toString());
                if(result == null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      content: 
                      AwesomeSnackbarContent(title: "Invalid Email&Password!",
                       message: "",
                        contentType: ContentType.warning)
                    ),
                  );
                }
                if(result != null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      content: 
                      AwesomeSnackbarContent(title: "Login Successfully!",
                       message: " ",
                        contentType: ContentType.success)
                    ),
                    
                  );
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  pref.setString("token", Token);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> UserScreen()));
     
                }
              },
              ),
              builder: (runMutation, result) {
                final _emailController = TextEditingController();
                final _passwordController = TextEditingController();
              
              return Form(
                key: _formKey,
                child: Column(
                children: [
                  Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      ),
                     
                      keyboardType: TextInputType.text,
                ),
                           ),
                          Padding(
                padding: const EdgeInsets.only(left:15.0,right: 15.0,top:15,bottom: 0),
                child: TextField(
                 controller: _passwordController,
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
                        "email" : _emailController.text.trim(),
                        "password" : _passwordController.text.trim(),
                       });
                       ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data'),
                      backgroundColor: Colors.indigo,
                      ),
                     );                   
                      }
                      // Navigator.push(
                       //   context, MaterialPageRoute(builder: (_) => HomePage()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
                  ],
                ),
              );
   } ),
          ]
            ) 
          
        ),
      );
    
  }
}
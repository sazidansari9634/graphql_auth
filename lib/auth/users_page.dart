import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:graphql_auth/welcome.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  final String userlist = r"""
                          query {
                            customers{
                              id
                              email
                              firstName
                            }
                          }
                          """;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Customers-List"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: Icon(Icons.logout_outlined), onPressed: ()async{
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      content: 
                      AwesomeSnackbarContent(title: " Logout Successfully",
                       message: "",
                        contentType: ContentType.help)
                    ),
          );
          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.remove('token');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> WelcomeScreen()), (route) => false);
          })
        ],

      ),
      body: Query(options: QueryOptions(
              document: gql(userlist), 
              ),

          
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (result.data == null) {
              return const Center(
                child: Text("Data Not Found!!!"),
              );
            }
            return ListView.builder(
                itemCount: result.data!['customers'].length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      result.data!['customers'][index]["firstName"],
                    ),
                    subtitle: Text(
                        result.data!['customers'][index]["email"]),
                  );
                });
          }),
    );
  }
}

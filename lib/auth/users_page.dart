import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
        title: const Text("Customers-List"),
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

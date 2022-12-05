import 'package:flutter/material.dart';
import 'package:graphql_auth/welcome.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  runApp( MaterialApp(title: 'GraphQL Auth', home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final HttpLink httpLink = HttpLink('https://cfc1-2407-5200-402-aea5-2ceb-114-bc95-2adb.in.ngrok.io/graphql',
  defaultHeaders: <String, String>{'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NTUsImV4cCI6MTY3NDk5NjAyNH0.5cLNyUZDauGWbuTzQoADMwU4F7tUuWDol_kdHI3a9wM'}
  );
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(
        store: HiveStore()
      )
    )
  );
 
    return GraphQLProvider(
      client: client,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter GraphQL Demo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          home: const WelcomeScreen(),
        ),
    );
  }
}

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
  final HttpLink httpLink = HttpLink('https://6df9-2407-5200-402-aea5-c3bd-27fe-2273-e943.in.ngrok.io/graphql',
    // Added the Bearer token pass

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

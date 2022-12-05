import 'package:flutter/material.dart';
import 'package:graphql_auth/welcome.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  final HttpLink link = HttpLink('https://cfc1-2407-5200-402-aea5-2ceb-114-bc95-2adb.in.ngrok.io/graphql');
  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(link: link, cache: GraphQLCache(store: HiveStore()))
  );
  runApp( MyApp(client: client,));
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({Key? key,required this.client }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter GraphQL Demo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          home: const WelcomeScreen(),
        ),
      ),
    );
  }
}

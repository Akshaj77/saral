import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:saral/business_logic/bloc/task_bloc.dart';
import 'package:saral/constants/constant.dart';
import 'package:saral/screens/taskslist_screen.dart';
import 'package:saral/widget/addtask.dart';

void main() {
  final HttpLink httpLink = HttpLink('${BasicApiConstants.GRAPHQL_URL}');

   final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer ${BasicApiConstants.API_KEY}', // Replace with your actual token
  );

  final Link link = authLink.concat(httpLink);

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
  runApp( MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.client});

  final ValueNotifier<GraphQLClient> client;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(dio: Dio(),client: client.value)..add(TaskLoad()),
      child: GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
           
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: UpdateTaskScreen(),
        ),
      ),
    );
  }
}


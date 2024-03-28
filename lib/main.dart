import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:restapi/features/items/bloc/items_bloc.dart';
import 'package:restapi/features/items/view/items_screen.dart';

void main() {
   runApp(const RequestsInspector(
      enabled: true, showInspectorOn: ShowInspectorOn.Both, child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ItemsBloc>(
          create: (BuildContext context) => ItemsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ItemsPage(),
      ),
    );
  }
}

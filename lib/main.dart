import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'screen/todos.dart';

void main() {
  runApp(BlocProvider(
    // --> ครอบด้วย BlocProvider จะได้เรียกใช้งาน bloc ได้
    create: (context) {
      return TodosBloc()
        ..add(
            LoadTodos()); // --> ทุกครั้งที่เปิดแอป เราก็จะเรียก event LoadTodos
    },
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodosScreen(), // --> โชว์หน้า TodosScreen
    );
  }
}

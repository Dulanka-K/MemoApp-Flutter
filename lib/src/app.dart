import 'package:flutter/material.dart';
import 'screens/memolist.dart';
import 'screens/addmemo.dart';

class App extends StatelessWidget{
  Widget build(context){
    return MaterialApp(
      onGenerateRoute: routes,
    );
  }

  Route routes(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(
        builder:(context) {
          return MemoList();
        }
      );
    }
    else if(settings.name == '/addMemo'){
      return MaterialPageRoute(
        builder:(context){
          return AddMemo();
        }
      );
    }
  }
}
import 'package:flutter/material.dart';
import '../resources/memodb.dart';
import '../models/memomodel.dart';

class MemoListTile extends StatelessWidget{
  Future<List<MemoModel>> memosFuture;

  MemoListTile(this.memosFuture);
  
  Widget build(context) {
    
    return FutureBuilder(
      future: memosFuture,
      builder: (context,snapshot){
        if(!snapshot.hasData){
          print('case');
        }
        print(snapshot.data);
          return ListView.builder(
          itemCount : snapshot.data.length,
          itemBuilder: (context,int index){
            return buildMemo(snapshot.data[index]);
          },
        );
      },
    );
   
  }

  Widget buildMemo(MemoModel memo){
    return Column(
      children: [
        ListTile(
          onTap: (){},
          title: Text(memo.title),
          subtitle: Text(memo.content),
        ),
        Divider(
          height: 8.0,
        ),
      ],
    );
  }
}
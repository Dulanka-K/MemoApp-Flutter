import 'package:flutter/material.dart';
import '../resources/memodb.dart';
import '../models/memomodel.dart';
import './addmemo.dart';
// import '../widgets/memolisttile.dart';

class MemoList extends StatefulWidget{
  createState(){
    return MemoListState();
  }
}

class MemoListState extends State<MemoList>{
  MemoDbProvider dbProvider = MemoDbProvider();

  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Memo'),
      ),
      body: FutureBuilder(
        future: dbProvider.fetchMemos(),
        builder: (context,AsyncSnapshot<List<MemoModel>> snapshot){
          if(!snapshot.hasData){
            return Center(
            child: CircularProgressIndicator(),
          );
          }
          //print(snapshot.data);
            return ListView.builder(
            // scrollDirection: Axis.vertical,
            // controller: ScrollController(),
            itemCount : snapshot.data.length,
            itemBuilder: (context,int index){
              print(snapshot.data[index].id);
              List<MemoModel> reverseMemos = snapshot.data.reversed.toList();
              return buildMemo(reverseMemos[index]);
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/addMemo');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),  
    );
  }

  Widget buildMemo(MemoModel memo){
    return Card(
      margin: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
      elevation: 2.0,
      child: Container(
        height: 90.0,
        child: ListTile(
        //contentPadding: EdgeInsets.all(10.0),
          onLongPress: (){},
          onTap: (){
            print('${memo.id},${memo.title},${memo.content}');
            // Navigator.pushNamed(context, '/addMemo',
            // arguments: AddMemo(id: memo.id,title: memo.title,content: memo.content),);
            Navigator.push(context, MaterialPageRoute(
                builder:(context){
                  return AddMemo(id: memo.id,title: memo.title,content: memo.content);
                }
              )
            );
          },
          title: Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              memo.title,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21.0
              ),
            ),
          ),
          subtitle: Container(
            padding: EdgeInsets.only(top: 5.0),
            child: Text(
            memo.content,
            maxLines: 2,
            style: TextStyle(fontSize: 16.0,color: Colors.black),
            
          ),
          ),
          trailing: Column(
            
            children: <Widget>[
              GestureDetector(
                child: Icon(Icons.delete),
                onTap: ()async{
                  final item = await dbProvider.deleteMemo(memo.id);
                  print('$item deleted');
                  setState(() {});
                },
              ),
              
              
              // IconButton(
              //   padding: EdgeInsets.only(top:0.0),
              //   icon: Icon(Icons.delete),
              //   onPressed: ()async{
              //     final item = await dbProvider.deleteMemo(memo.id);
              //     print('$item deleted');
              //     setState(() {});
              //   },
              // ),
              Text('${memo.date}'),
              
            ],
          ),
        ),
      ), 
    );
  }
}


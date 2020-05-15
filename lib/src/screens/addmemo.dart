import 'package:flutter/material.dart';
import '../models/memomodel.dart';
import '../resources/memodb.dart';
import 'package:intl/intl.dart';

class AddMemo extends StatefulWidget{

  final int id;
  final String title;
  final String content;
  

  AddMemo({this.id,this.title,this.content});
  

  createState(){
    print('$id,$title,$content');
    return AddMemoState(this.id,this.title,this.content);
  }
}

class AddMemoState extends State<AddMemo>{
  MemoDbProvider dbProvider = MemoDbProvider();
  final formKey = GlobalKey<FormState>();
  int id;
  String title;
  String content;
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  
  
  AddMemoState(this.id,this.title,this.content);

  Widget build(context){
    print('$id,$title,$content');

    titleController.text=title;
    contentController.text = content;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Memo'),
        actions: <Widget>[
          button()
        ],
      ),
      body: SingleChildScrollView(
        child:  Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
              children: [
                memoTitle(),
                memoContent(),
              ],
            ),
          ), 
        ),
      )
    );
  }

  Widget memoTitle(){
    return TextFormField(
      controller: titleController,
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
      decoration: InputDecoration(
        hintText: 'Add Title'
      ),
      onSaved: (String value){
        this.title = value;
      },
    );
  }

  Widget memoContent(){
    return TextFormField(
        controller: contentController,
        // scrollPadding: EdgeInsets.all(10.0),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: 'Add Note',
          border: InputBorder.none
        ),
        onSaved: (String value){
          this.content = value;
        },
        // validator: (value){
        //   if(value.isEmpty){
        //     return 'Note cannot be empty';
        //   }
        //   return null;
        // },
    );
  
  }

  Widget button(){
    return IconButton(
      iconSize: 40.0,
      icon: Icon(Icons.save),
      onPressed: () async{

          formKey.currentState.save();
          
          if(title!='' || content!=''){
            final memo = MemoModel(
              title: title,
              content: content,
              date: DateFormat.yMMMd().format(DateTime.now()),
            );

          if(id == null){
            final item = await dbProvider.addItem(memo);
            print('added item: $item');
            Navigator.pop(context, true);
          }
          else{
            final item = await dbProvider.updateMemo(id,memo);
            print('updated item: $item');
            Navigator.pop(context, true);
          }
          
          }
          else{
            Navigator.pop(context, true);
          }
        
        
        
          
        
      },
    );
  }
}

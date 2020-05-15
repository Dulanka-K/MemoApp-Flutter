class MemoModel{
  final int id;
  final String title;
  final String content;
  final String date;

  MemoModel({this.id,this.title,this.content,this.date});

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      "title" : title,
      "content" : content,
      "date" : date,
    };
  }

  // MemoModel.fromMapObject(Map<String, dynamic> map) {
	// 	this.id = map['id'];
	// 	this.title = map['title'];
	// 	this.content = map['content'];
	// }
}
  import 'package:flutter/material.dart';

  class CategoryTaskScreen extends StatefulWidget{
    final String categoryName;
    final List<Map<String,dynamic>>taskList;
    const CategoryTaskScreen({
      super.key,
      required this.categoryName,
      required this.taskList
  });

    @override
    State<CategoryTaskScreen> createState() => _CategoryTaskScreenState();
  }

  class _CategoryTaskScreenState extends State<CategoryTaskScreen> {
    @override
    Widget build(BuildContext context){
      List<Map<String,dynamic>> filteredTask = [];

      for(var task in widget.taskList){
        if(task['category'] == widget.categoryName){
          filteredTask.add(task);
        }
      }
      Widget bodyWidget;
      if(filteredTask.isEmpty){
        bodyWidget = Center(
          child: Text('No task in ${widget.categoryName}',style: TextStyle(
            fontSize: 18,
            color: Colors.grey
          ),
          ),
        );
      }else{
        bodyWidget = ListView.builder(
          itemCount:filteredTask.length,
          itemBuilder: (context, index){
            final task = filteredTask[index];
            TextStyle titleStyle;

            if(task['isDone'] == true){
              titleStyle = TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough
              );
            }
            else{
              titleStyle = TextStyle(
                fontWeight: FontWeight.bold
              );
            }
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12,vertical: 6),
              child: ListTile(
                leading: Icon(task['icon'],
                color: Colors.purpleAccent,
                ),
                title: Text(task['title'],style:
                  TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(task['description']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        value: task['isDone'],
                        onChanged: (value){
                          setState(() {
                            task['isDone'] = value;
                          });
                        }
                    ),
                    IconButton(icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: (){
                      setState(() {
                        widget.taskList.remove(task);
                      });
                    }
                    )
                  ],
                ),
              ),
            );
          }
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context,true);
            }
          ),
        ),
        body: bodyWidget,
      );
    }
  }
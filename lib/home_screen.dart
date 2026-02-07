import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'create_task.dart';
import 'category_task_screen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 int getCountByCategory(String categoryName){
   int count = 0;
   for(var task in taskList){
     if(task ['category'] == categoryName){
       count++;
     }
   }
   return count;
 }
  List<Map<String, dynamic>> taskList = [];
  List<Map<String,String>> getNextDays(){
    List<Map<String,String>> days = [];
    DateTime now = DateTime.now();

    for(int i = 0; i < 4; i++){
      DateTime day = now.add(Duration(days: i));
      String date = DateFormat('d').format(day);
      String dayName = DateFormat('E').format(day);
      days.add({'date': date, 'day': dayName});
    }
    return days;
  }
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 33),
        child: Text('Create Task',style: TextStyle(
          fontSize: 30
        ),),
      ),
      centerTitle: true,
      actions: [
        Padding(padding: EdgeInsets.only(top: 28,right: 7),
            child: Icon(CupertinoIcons.stopwatch,size: 30,)
        ),
      ],
    ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(getNextDays().length,(index){
                      final day = getNextDays()[index];
        
                      Color cardColor;
                      Color textColor;
        
                      if(index ==0){
                        cardColor = Colors.purpleAccent.shade700;
                        textColor = Colors.white;
                      }
                      else{
                        cardColor = Colors.grey.shade400;
                        textColor = Colors.black;
                      }
                      return Container(
                        width: 80,
                        height: 70,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          children: [
                            Text(day['date']!,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(day['day']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor
                            ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Text('Choose Activity',style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Container(
                      width: 360,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.purpleAccent.shade700.withOpacity(0.2),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(Icons.lightbulb_outline,size: 55,color: Colors.purpleAccent.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20),
                            child: Column(
                              children: [
                                Text('Idea',style: TextStyle(
                                  fontSize: 35,
                                ),),
                                Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Text(
                                    '${getCountByCategory('Idea')} Tasks',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 130),
                            child: IconButton(
                                icon: Icon(Icons.chevron_right,size: 40,color: Colors.purpleAccent.shade700,),
                                onPressed: () async{
                                  final result = await
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryTaskScreen(
                                      categoryName: 'Idea', taskList: taskList)));
                                  if(result == true){
                                    setState(() {

                                    });
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Container(
                      width: 360,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.purpleAccent.shade700.withOpacity(0.2),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(Icons.fastfood_outlined,size: 55,color: Colors.purpleAccent.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20),
                            child: Column(
                              children: [
                                Text('Food',style: TextStyle(
                                  fontSize: 35
                                ),),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Text(
                                    '${getCountByCategory('Food')} Task',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 118),
                            child: IconButton(
                                icon: Icon(Icons.chevron_right,size: 40,color: Colors.purpleAccent.shade700,),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryTaskScreen(
                                      categoryName: 'Food', taskList: taskList)));
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Container(
                      width: 360,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent.shade700.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(Icons.note_alt_outlined,size: 55,color: Colors.purpleAccent.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20),
                            child: Column(
                              children: [
                                Text('Work',style: TextStyle(
                                  fontSize: 35
                                ),),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    '${getCountByCategory('Work')} Tasks',style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700
                                  ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 118),
                            child: IconButton(
                                icon: Icon(Icons.chevron_right,size: 40,color: Colors.purpleAccent.shade700,),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryTaskScreen(
                                      categoryName: 'Work', taskList: taskList)));
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Container(
                      width: 360,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.purpleAccent.shade700.withOpacity(0.2)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(Icons.sports_esports_outlined,size: 55,color: Colors.purpleAccent.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20),
                            child: Column(
                              children: [
                                Text('Sports',style: TextStyle(
                                  fontSize: 35
                                ),),
                                Padding(
                                  padding: const EdgeInsets.only(right: 48),
                                  child: Text(
                                      '${getCountByCategory('Sports')} Tasks',style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700
                                  ),),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 95),
                            child: IconButton(
                                icon: Icon(Icons.chevron_right,size: 40,color: Colors.purpleAccent.shade700,),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryTaskScreen(
                                      categoryName: 'Sports', taskList: taskList)));
                                }
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 23),
                    child: Container(
                      width: 360,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent.shade700.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Icon(CupertinoIcons.double_music_note,size: 55,color: Colors.purpleAccent.shade700,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20),
                            child: Column(
                              children: [
                                Text('Music',style: TextStyle(
                                  fontSize: 35
                                ),),
                                Padding(
                                  padding: const EdgeInsets.only(right: 40),
                                  child: Text(
                                      '${getCountByCategory('Music')} Tasks',style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700
                                  ),),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: IconButton(
                                icon: Icon(Icons.chevron_right,size: 40,color: Colors.purpleAccent.shade700,),
                                onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryTaskScreen(
                                  categoryName: 'Music',
                                  taskList: taskList,
                                ),));
                                },),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
        Colors.purpleAccent.shade700,
          child:  Icon(Icons.add, size: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,),

          onPressed: ()async {
        final result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTaskScreen()));
        if(result != null){
          setState(() {
            taskList.add(result);
          });
        }
      }),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
  );
}
}
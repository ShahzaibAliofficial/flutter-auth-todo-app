import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTaskScreen extends StatefulWidget{
const CreateTaskScreen({super.key});
@override
State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}
TextEditingController titleController = TextEditingController();
TextEditingController desController = TextEditingController();

class _CreateTaskScreenState extends State<CreateTaskScreen>{
  List<Map<String,dynamic>> categories = [
    {
      'name': 'Idea',
      'Icon': Icons.lightbulb_outline
    },
    {
      'name': 'Food',
      'Icon': Icons.fastfood_outlined
    },
    {
      'name': 'Work',
      'Icon': Icons.note_alt_outlined
    },
    {
      'name': 'Sports',
      'Icon': Icons.sports_esports_outlined
    },
    {
      'name': 'Music',
      'Icon': CupertinoIcons.double_music_note
    }
  ];

  Map<String,dynamic>? selectedCategory;
  
    final DateTime now = DateTime.now();
    @override
  Widget build(BuildContext context){
    String monthName = DateFormat('MMM yyy').format(now);
    int daysInMonth = DateTime(now.year, now.month +1,0).day;
    int firstWeekday = DateTime(now.year, now.month,1).weekday;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar:  PreferredSize(preferredSize: Size.fromHeight(150),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
            flexibleSpace: Padding(padding: EdgeInsets.only(top: 100,left: 130),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Create Task',style: TextStyle(
                fontSize: 30
              ),),
            ),
            ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 25,right: 15),
              child: Icon(CupertinoIcons.stopwatch,size: 30,),
            )
          ],
          ),
        ),

      body: Stack(
        children: [
          Container(
            height: 350,
            width: double.infinity,
            color: Colors.purpleAccent.shade700.withOpacity(0.2),
          ),
          SafeArea(child: Column(
            children: [

              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70)
                    )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(monthName),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Mon'),Text('Tue'),Text('Wed'),Text('Thu'),Text('Fri'),Text('Sat'),Text('Sun')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,bottom: 15),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: daysInMonth + firstWeekday - 1,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                            itemBuilder: (context , index){
                              if(index < firstWeekday -1){
                                return Container(
                                );
                              }
                              int day = index - firstWeekday +2;
                              bool isToday = day == now.day;
                    
                              Color bgColor;
                              Color textColor;
                    
                              if (isToday){
                                bgColor = Colors.purple.shade200;
                                textColor = Colors.white;
                              }else{
                                bgColor = Colors.grey.shade200;
                                textColor = Colors.black;
                              }
                              return Container(
                                margin: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                alignment: Alignment.center,
                                child: Text('$day',style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold
                                ),),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 80,
                          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.purpleAccent.shade700.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: DropdownButtonHideUnderline(
                    
                            child: DropdownButton<Map<String,dynamic>>(
                                hint: Text('Select Category',),
                              value: selectedCategory,
                              icon: Icon(Icons.keyboard_arrow_down,size: 30,color: Colors.purpleAccent.shade700,),
                              items: categories.map((category)
                              {
                                return DropdownMenuItem<Map<String,dynamic>>(
                    
                                  value: category,
                                  child: Row(
                                    children: [
                                      Icon(category['Icon'],color: Colors.purpleAccent,),
                                      SizedBox(width: 10,),
                                      Text(category['name'])
                                    ],
                                  )
                                );
                              }
                              ).toList(),
                              onChanged: (value){
                                setState(() {
                                  selectedCategory = value;
                                });
                              }
                            ),
                              ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 365,
                          height: 40,
                          child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 9,
                                  horizontal: 6
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  width: 0.6,
                                  color: Colors.grey
                                ),
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          width: 365,
                          height: 120,
                          child: TextField(
                            controller: desController,
                            maxLines: 1200,
                            decoration: InputDecoration(
                              hintText: 'Task Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            width: 365,
                            height: 30,
                            child: ElevatedButton(onPressed: (){
                              if(selectedCategory == null){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select category')));
                                return;
                              }
                              if(titleController.text.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter task name')));
                                return;
                              }
                              if(desController.text.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please write the description')));
                                return;
                              }
                              if(selectedCategory != null && titleController.text.isNotEmpty && desController.text.isNotEmpty ){
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Task added successfully!!!')));
                              }
                              Map<String, dynamic>newTask = {
                                'category' : selectedCategory!['name'],
                                'icon' : selectedCategory!['Icon'],
                                'title' : titleController.text,
                                'description' : desController.text,
                                'date' : DateTime.now(),
                                'isDone' : false,
                              };
                              Navigator.pop(context,newTask);
                            },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                  ),
                                  backgroundColor: Colors.purpleAccent.shade700,
                                ),
                                child: Text('Create Task',style: TextStyle(color: Colors.white),)))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
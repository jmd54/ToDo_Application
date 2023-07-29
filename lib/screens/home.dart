import 'package:flutter/material.dart';
import 'package:todo_application/constants/colors.dart';
import 'package:todo_application/model/todo.dart';
import 'package:todo_application/widgets/todo_item.dart';
class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  final todosList=ToDo.todoList();
  final _todoController=TextEditingController();
  List<ToDo>_foundToDo=[];
  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppbar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchBox(),
                SizedBox(height: 40,),
                Text( 
                  'All ToDos',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: ListView(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 20,
                              ),
                            ),
                            for (ToDo todoo in _foundToDo)
                              ToDoItem(
                                todo: todoo,
                                onToDoChanged: _handleToDoChange,
                                onDeleteItem: _onDeleteItem,
                                
                              ),
                          ],
                        ),
                ),
              ],
            ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(child: Container(
                margin: EdgeInsets.only(left:20,right:20,bottom:20),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(70, 68, 68, 1)),
                  boxShadow:[BoxShadow(
                    color: Colors.white;
                    offset: Offset(10, 10),
                    blurRadius: 15,
                    spreadRadius: 10
                  )] ,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Add a new Todo Item",
                    border: InputBorder.none
                  ),
                  controller: _todoController,
                ),
              )),
              Container(
                
                margin: EdgeInsets.only(right: 20,bottom: 20),
                child: ElevatedButton(
                  child: Text("+",style: TextStyle(fontSize: 40)),
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style:  ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(60,60),
                    elevation: 10
                  ),
                ),
              )
            ],
          ),
        )
        ]
      ),
    );
  }

  void _handleToDoChange(ToDo toDo){
    setState(() {
      toDo.isDone=!toDo.isDone;
    });
  }
 // on press delete icon
  void _onDeleteItem(String id){
    setState(() {
      todosList.removeWhere((item) => item.id==id);
    });
  }
  void _addToDoItem(String toDo){
    setState(() {
      todosList.insert(0,ToDo(id: DateTime.now().toString(),todoText:toDo));
    });
    _todoController.clear();
  }
  void _runFilter(String enteredKeyword){
      List<ToDo>result=[];
      if(enteredKeyword.isEmpty){
        result=todosList;
        } 
      else{
        result=todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList(); 
      }
      setState(() {
        _foundToDo= result;
      });
  }
  

  Widget searchBox(){
    return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),
              child: TextField(
                onChanged: (value) => _runFilter(value),
                decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.search,color: tdBlack,size: 20,),
                prefixIconConstraints: BoxConstraints(maxHeight: 20,minWidth: 25),
                border: InputBorder.none,
                hintText: "search here",
                hintStyle: TextStyle(color: tdGrey)

                ),),
                
            );
  }

  AppBar _buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor:tdBGColor ,
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu,color: tdBlack,size: 30,),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(child: Image.asset("assets/images/avatar.jpeg"),borderRadius: BorderRadius.circular(20)),
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:todo_application/constants/colors.dart';
import 'package:todo_application/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;
  const ToDoItem({required this.todo,required this.onToDoChanged,required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: ListTile(
        onTap: (){
          onToDoChanged(todo);
        },
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
        leading: Icon(todo.isDone?Icons.check_box:Icons.check_box_outline_blank,color: tdBlue,size: 30),
        title: Text(todo.todoText.toString(),style: TextStyle(fontSize: 18,color: tdBlack,decoration: todo.isDone?TextDecoration.lineThrough:TextDecoration.none),),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(color: tdRed,borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
                         onDeleteItem(todo.id);
              // print("clicked on delete icon");
            },
          ),
        ),
      ),
    );
  }
  
}
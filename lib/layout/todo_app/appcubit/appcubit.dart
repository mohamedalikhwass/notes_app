import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/modules/todo_app/archivetasks/ArchiveTasks.dart';
import 'package:khwass_app/modules/todo_app/donetasks/DoneTasks.dart';
import 'package:khwass_app/modules/todo_app/newtasks/NewTasks.dart';

import 'package:sqflite/sqflite.dart';

import 'appstats.dart';

class AppCubit extends Cubit<AppStats>
{

  AppCubit(): super (AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);

  Color Botoom=Colors.grey;

  int currentindex  = 0;
  Database database;
  List <Map> newTasks=[];
  List <Map> doneTasks=[];
  List <Map> archiveTasks=[];

  List<Widget> screens=[
    NewTasks(),
    DoneTasks(),
    ArchiveTasks(),

  ];

  List<String> title=
  [
    'Khwass App',
    'Khwass App',
    'Khwass App',
  ];

void changeIndex(int index)
{
   currentindex=index;
  emit(AppChangeBottomNavBar());
}

  void createDatabase()
  {
     openDatabase(
        'todoAppMO.db',
        version: 1,
        onCreate: (database,version)
        {
          print('created database');
          database.execute('CREATE TABLE task (id INTEGER PRIMARY KEY,title TEXT, time TEXT, date TEXT ,status TEXT )')
              .then((value)
          {
            print('created database');
          }).catchError((error)
          {
            print('Error not create database${error.toString()}');
          });
        },
        onOpen: (database)
        {

          getDataFromDatabase(database);


          print('opened database');
        }
    ).then((value)
     {
       database =value;
       emit(AppCreateDatabaseState());
     });



  }
   insertToDatabase(
      {@required String title,@required String time ,@required String date}
      ) async
  {
    await database.transaction((txn)
    {
      txn.rawInsert('INSERT INTO task (title,time,date,status) VALUES("$title","$time","$date","new")')
          .then((value) {
        print('$value successfully inserted');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);

      }).
      catchError((error){
        print('not successfully insert ${error.toString()}');
      });
      return null;
    });


  }

  void getDataFromDatabase(database)
  {
    newTasks=[];
    doneTasks =[];
    archiveTasks =[];


     database.rawQuery('SELECT * FROM task').then((value)
     {

        value.forEach((element)
        {
          print(element['status']);
          if (element['status'] == 'new')
              newTasks.add(element);
          else if (element['status'] == 'done')
              doneTasks.add(element);
          else
          archiveTasks.add(element);

        });


       emit(AppGetDatabaseState());

     });

  }

  void updateDataFromDatabase(
  {
    @required String status,
    @required int id,

  })
  {
    database.rawUpdate(
    'UPDATE task SET status=? WHERE id=? ',
      ['$status',id]
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppUpDateDatabaseState());
    });
  }

  void deleteDataFromDatabase(
      {
        @required int id,

      })
  {
    database.rawUpdate(
        'DELETE FROM task WHERE id=?  ',
        [id]
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }



  bool isBottomSheetShun=false;
  IconData iconIsBottomSheetShun =Icons.edit ;

  void changeSheetShun({@required bool bottomSheet,@required IconData iconBottomSheetShun})
  {
    isBottomSheetShun=bottomSheet;
    iconIsBottomSheetShun=iconBottomSheetShun;
    emit(AppChangeBottomSheetShun());

  }



}
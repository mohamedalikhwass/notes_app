import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:khwass_app/shaerd/components/components.dart';
import 'package:khwass_app/shaerd/components/constantes.dart';
import 'package:sqflite/sqflite.dart';

import 'appcubit/appcubit.dart';
import 'appcubit/appstats.dart';

class LayOutHome extends StatelessWidget
{



  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  var titleController =TextEditingController();
  var dateController =TextEditingController();
  var timeController =TextEditingController();



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStats>(
        listener: ( context,state)
        {
          if(state is AppInsertDatabaseState)
            {
              Navigator.pop(context);
            }
        },
        builder: (  context,  state)
        {
          AppCubit cubit  =BlocProvider.of(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: (
                  Icon(
                    Icons.menu,
                  )
              ),
              title: Center(
                child: (
                    Text(

                        cubit.title[cubit.currentindex],

                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 28,

                      ),
                    )
                ),
              ),
              actions: [
                IconButton(
                    color: Colors.grey[100],
                    iconSize: 32.0,
                    icon:Icon(Icons.search),
                    onPressed:()
                    {
                      print('not found');
                    }

                )
              ],
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context)=>cubit.screens[cubit.currentindex],
              fallback: (context){
                return Center(child: CircularProgressIndicator());
              },
            ),
            floatingActionButton: FloatingActionButton(


              onPressed: ()
              {

                if(cubit.isBottomSheetShun) {

                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    /*
                    insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,

                    ).then((value)
                    {
                      Navigator.pop(context);
                      isBottomSheetShun = false;

                    setState(() {
                      iconIsBottomSheetShun = Icons.edit;
                    })

                    }

                    )

                     */
                  }


                }


                else
                {
                  scaffoldKey.currentState.showBottomSheet(
                        (context) =>Form(
                      key: formKey,
                      child: Container(
                        color: Colors.blue[50],
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextForm(
                                control: titleController ,
                                textType: TextInputType.text ,
                                icon: Icons.title,
                                labelText: 'Task Title',
                                validat: (String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return'title must be not empty';
                                  }
                                  return null;
                                }),
                            SizedBox(height: 10.0,),
                            defaultTextForm(
                                control: timeController ,
                                icon: Icons.timer,
                                textType:TextInputType.datetime ,
                                labelText: 'Task Time',
                                onTap: ()
                                {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now()
                                  ).then((value)
                                  {
                                    timeController.text=value.format(context).toString();
                                    print(value.format(context));
                                  });
                                },
                                validat: (String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return'time must be not empty';
                                  }
                                  return null;
                                }),
                            SizedBox(height: 10.0,),
                            defaultTextForm(
                                control: dateController ,
                                icon: Icons.calendar_today,
                                textType:TextInputType.datetime ,
                                labelText: 'Task Date',
                                onTap: ()
                                {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2022-12-12'),
                                  ).then((value)
                                  {
                                    dateController.text=DateFormat.yMMMd().format(value);

                                  });


                                },
                                validat: (String value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return'date must be not empty';
                                  }
                                  return null;
                                })
                          ],
                        ),
                      ),
                    ),
                  ).closed.then((value)
                  {
                    cubit.changeSheetShun(bottomSheet: false, iconBottomSheetShun: Icons.edit);



                  }) ;

                  cubit.changeSheetShun(bottomSheet: true, iconBottomSheetShun: Icons.add);

                }



              },
              child: Icon(
                cubit.iconIsBottomSheetShun,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentindex,
              onTap: (index)
              {
                cubit.changeIndex(index);
              },

              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: Colors.green[600],

                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                    color: Colors.red[600],
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}



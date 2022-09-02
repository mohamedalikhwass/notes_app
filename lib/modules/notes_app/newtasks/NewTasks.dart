import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khwass_app/layout/todo_app/appcubit/appcubit.dart';
import 'package:khwass_app/layout/todo_app/appcubit/appstats.dart';

import 'package:khwass_app/shaerd/components/components.dart';
import 'package:khwass_app/shaerd/components/constantes.dart';

class NewTasks  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStats>
      (
        listener: (context,state){},
      builder: (context,state)
      {
       var tasks=AppCubit.get(context).newTasks;
        return buildTasks(tasks: tasks);
      },
        );


  }
}

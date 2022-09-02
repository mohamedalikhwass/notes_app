import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khwass_app/layout/todo_app/appcubit/appcubit.dart';
import 'package:khwass_app/models/shop_model/shop_search_model.dart';

import '../../layout/shop_app/cubit_shop/shop_cubit.dart';

Widget defaultButton({
 @required double widith,
  @required Color color ,
  @required Function function,
  @required String text ,
  bool isUpperCase=true,

})=>Container(
width: widith,
color: color,
child: MaterialButton(
onPressed: function,
child: Text( isUpperCase?text.toUpperCase():text,
style: TextStyle(
fontWeight: FontWeight.bold,
fontSize: 30.0,
color: Colors.white,
),
),
),
);









Widget defaultTextForm({

 @required TextEditingController control,
  TextInputType textType,
 @required IconData icon,
 @required String labelText,
 bool obscure=false,
 IconData suffixicon,
 @required Function validat,
 Function onPreased,
 Function onTap,
 Function  onFieldSubmitted,
 Function  onChanged,
})=>TextFormField(
 controller: control ,
 keyboardType:textType ,
 obscureText: obscure,
 onTap: onTap,
 onChanged: onChanged,
 onFieldSubmitted: onFieldSubmitted,
 validator: validat,
 decoration: InputDecoration(
  labelText: labelText,
  prefixIcon: Icon(
   icon,
  ),
  suffixIcon: IconButton(
     onPressed: onPreased,
      icon:Icon(suffixicon),
  ),
  border: OutlineInputBorder(),


 ),
);





Widget buildItemsTodAbb(Map model ,context )=>Dismissible(
 key: Key(model['id'].toString()),
  child:   Padding(
  
   padding: const EdgeInsets.all(16.0),
  
   child: Row(
  
    children: [
  
     CircleAvatar(
  
      radius: 38.0,
  
      child: Text('${model['time']}'),
  
     ),
  
     SizedBox(
  
      width: 15.0,
  
     ),
  
     Expanded(
  
       child: Column(
  
        mainAxisSize: MainAxisSize.min,
  
        crossAxisAlignment: CrossAxisAlignment.start,
  
        children: [
  
         Text('${model['title']} ',
  
          style: TextStyle(
  
           fontSize:17.0,
  
           fontWeight: FontWeight.bold,
  
          ),
  
         ),
  
         Text('${model['date']} ',
  
          style: TextStyle(
  
  
  
          ),
  
         ),
  
        ],
  
       ),
  
     ),
  
     SizedBox(
  
      width: 15.0,
  
     ),
  
     IconButton(
  
         icon: Icon(

  
          Icons.check_circle_outline,
  
          color: AppCubit.get(context).Botoom,
  
         ),
  
         onPressed: ()
  
         {

          if(model['status'] =='new')
           {
            AppCubit.get(context).updateDataFromDatabase(status: 'done', id: model['id']);
            AppCubit.get(context).Botoom=Colors.green;
           }
          else if(model['status'] =='done')
          {
           AppCubit.get(context).updateDataFromDatabase(status: 'new', id: model['id']);
           AppCubit.get(context).Botoom=Colors.grey;
          }
          else if(model['status'] =='archive')
           {
           AppCubit.get(context).updateDataFromDatabase(status: 'done', id: model['id']);
           AppCubit.get(context).Botoom=Colors.green;
           }
         },
  
         ),
  
     SizedBox(
  
      width: 10.0,
  
     ),
  
     IconButton(
  
      icon: Icon(
  
       Icons.archive_outlined,
  
       color: Colors.red[600],
  
      ),
  
      onPressed: ()
  
      {

       if(model['status'] =='new')
       {
        AppCubit.get(context).updateDataFromDatabase(status: 'archive', id: model['id']);
       }
       else if(model['status'] =='archive')
       {
        AppCubit.get(context).updateDataFromDatabase(status: 'new', id: model['id']);
       }
       else
        AppCubit.get(context).updateDataFromDatabase(status: 'archive', id: model['id']);
  
      },
  
     ),
  
    ],
  
   ),
  
  ),
 onDismissed: (direction)
 {
  AppCubit.get(context).deleteDataFromDatabase(id: model['id']);
 },


);



Widget buildTasks({@required List<Map> tasks})=>ConditionalBuilder(
 condition: tasks.length>0,
 builder: (context)=>ListView.separated(itemBuilder: (context,index)=>buildItemsTodAbb(tasks[index],context),
     separatorBuilder: (context,index)=>Padding(
      padding: const EdgeInsetsDirectional.only(
       start: 18.0,
      ),
      child: Container(

       width: double.infinity,
       height: 1.0,
       color: Colors.grey[500],
      ),
     ),
     itemCount: tasks.length),
 fallback: (context)=>Center(
  child: Column(
   mainAxisAlignment: MainAxisAlignment.center,
   children: [
    Icon(
     Icons.menu,
     color: Colors.grey[500],
     size: 80.0,
    ),
    Text(
     'لا يوجد مهمات لديك , أضف مهمه',
     style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20.0,
      color: Colors.grey[700],
     ),
    ),
   ],
  ),
 ),
);






Widget buildItemsNewsApp(article,context) {
 return InkWell(
  onTap: ()
  {
  // navigatorTo(context,article['url']);
  },
   child: Padding(

    padding: const EdgeInsets.all(16.0),
    child: Row(
     children: [
      Container(
       height: 125,
       width: 125,
       //color: Colors.deepOrange ,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
         image: NetworkImage('${article['urlToImage']}'),
         fit: BoxFit.cover,
        ),
       ),

      ),
      SizedBox(
       width: 15.0,
      ),
      Expanded(
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
         Text('${article['title']} ',
          style: TextStyle(
           color: Colors.black,
           fontSize: 16.0,
           textBaseline: TextBaseline.alphabetic,

          ),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,

         ),
         SizedBox(
          height: 7,
         ),
         Text('${article['publishedAt']}',
          style: TextStyle(
           color: Colors.grey,
           fontSize: 15.0,
           fontWeight: FontWeight.bold,

          ),
          maxLines: 1,
         ),
        ],
       ),
      ),
     ],
    ),
   ),
 );
}








Widget buildItemsArticlesNewsApp(list)=>ConditionalBuilder(



 condition: list.length>0,



 builder: (context)=>ListView.separated(



  physics: BouncingScrollPhysics(),



  itemBuilder: ( context,  index)=>buildItemsNewsApp(context,list[index]),



  separatorBuilder: ( context,  index)



  {



   return Padding(



    padding: const EdgeInsets.symmetric(horizontal: 16.0),



    child: Container(



     width: double.infinity,



     height: 1,



     color: Colors.grey[600],



    ),



   );



  },



  itemCount: list.length,











 ),



 fallback: (context)=>Center(child: CircularProgressIndicator()),







);






void  navigatorTo(context,Widget widget)=>Navigator.push(
 context,
 MaterialPageRoute(
  builder: (context)=>widget
 ),
);




void  navigatorToAndFinch(context,Widget widget)=>Navigator.pushAndRemoveUntil
 (
    context,
   MaterialPageRoute(
     builder: (context)=>widget
 ),
    (Route<dynamic>rout)=>false,
);



void showToast(
{
 @required String msg,
 @required StateToast state
}
)=>Fluttertoast.showToast(
 msg: msg,
 toastLength: Toast.LENGTH_LONG,
 gravity: ToastGravity.BOTTOM,
 timeInSecForIosWeb: 1,
 backgroundColor: chooseStateToast(state),
 textColor: Colors.white,
 fontSize: 16.0,
);



enum StateToast {SUCCESS,ERROR,WARNING}

Color chooseStateToast(StateToast state)
{
 Color color;
 switch(state)
 {
  case StateToast.SUCCESS:
     color.green;
     break;
  case StateToast.ERROR:
   color.red;
   break;
  case StateToast.WARNING:
   color.blue;
   break; 
     
  
 }
 return color;


}

Widget buildShopProductItem(  model, context) => Padding(
 padding: const EdgeInsets.all(20.0),
 child: Container(
  height: 120.0,
  child: Row(
   children:
   [
    Stack(
     alignment: AlignmentDirectional.bottomStart,
     children:
     [
      Image(
       image: NetworkImage(model.image),
       width: 120.0,
       height: 120.0,
      ),

     ],
    ),
    SizedBox(
     width: 20.0,
    ),
    Expanded(
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text(
        model.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
         fontSize: 14.0,
         height: 1.3,
        ),
       ),
       Spacer(),
       Row(
        children: [
         Text(
          model.price.toString(),
          style: TextStyle(
           fontSize: 12.0,
           color: Colors.amber,
          ),
         ),
         SizedBox(
          width: 5.0,
         ),
         Spacer(),
         IconButton(
          onPressed: (){
           ShopCubit.get(context).changeFavorites(model.id);
           print(model.id);
          },
          icon: Icon(
           Icons.favorite,
          ),
          color: ShopCubit.get(context).favorite[model.id] ? Colors.amber :Colors.grey,
          // disabledColor:  Colors.grey,
         ),
        ],
       ),
      ],
     ),
    ),
   ],
  ),
 ),
);










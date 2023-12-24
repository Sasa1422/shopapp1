import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../network/local/WebView_Screen.dart';

Widget defoultButton ({
 @required double? width,
  @required Color? background,
  @required VoidCallback? onPressed,
  @required String? text,
  double radius=10,

})=>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
  width: width,
  height: 60,

  child: MaterialButton(

    onPressed: onPressed,
    child: Text(
      text!.toUpperCase() ,
      style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
      ),
    ),
  ),
);


Widget defoultTextButton({
   @required VoidCallback? onPressed,
  @required String? text,
})=>TextButton(
    onPressed: onPressed,
    child:Text(text!.toUpperCase()) );



Widget defoultFormField({
  @required TextEditingController? controller,
  @required TextInputType? type,
  @required String?  Function(String?)? validator,
   String?  Function(String?)? onChanged,
   String?  Function(String)? onSubmit,
  @required String? label,
  @required IconData? prefix,
  IconData? suffix,
  bool ispassword=false,
  VoidCallback? suffixpressed,
  VoidCallback? onTap,



})=> TextFormField(
controller: controller,
obscureText:ispassword ,
keyboardType: type,
onTap: onTap,
onFieldSubmitted: onSubmit,
onChanged: onChanged,
validator: validator,
decoration:  InputDecoration(
labelText: label,
prefixIcon: Icon(prefix),
suffixIcon:suffix !=null ? IconButton(
  icon: Icon(suffix),
  onPressed:suffixpressed ,
) : null,
border: OutlineInputBorder(),
),
);
Widget MyDvider()=> Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey,


  ),
);

Widget buildArticaleItem(article , context)=>
    InkWell(
  onTap: (){
    Navigator.of(context).pushNamed(WebViewScreen(article['url']) as String  , );
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120,

          height: 120,

          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),

              image: DecorationImage(

                image: NetworkImage('${article['urlToImage']}',),

                fit: BoxFit.cover,

              )



          ),



        ),

        SizedBox(width: 20,),

        Expanded(

          child: Container(

            height: 120,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context ).textTheme.bodyLarge,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                      color: Colors.grey

                  ),

                )



              ],

            ),

          ),

        )
      ],

    ),

  ),
);


void navigateTo(context,widget)=>Navigator.push(
  context,MaterialPageRoute(builder:
    (context)=>widget
),
);


void navigateAndFinsh(context, widget)=>Navigator
    .pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
        (route) => false
);


void showToast({
  required String text,
  required ToastStates state,

})=>
Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

//enum
enum ToastStates{SUCCES,ERROR,WARNING}

Color? chooseToastColor(ToastStates state){
  Color? color;
  switch(state)
      {

    case ToastStates.SUCCES:
      color= Colors.green;
    case ToastStates.ERROR:
      color= Colors.red;
    case ToastStates.WARNING:
      color= Colors.amber;
  }
  return color;
}

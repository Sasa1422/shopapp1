import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/medules/ShopAppsScreen/search_Screen/search_cubit.dart';
import 'package:untitled3/models/Shop_model/Search_Model.dart';
import 'package:untitled3/shared/components/componantes.dart';

import '../../../layout/Shop_App/Shop_app_Cupit/ShopApp_Cupit.dart';
import '../../../models/Shop_model/FavoretModel.dart';
import '../../../shared/components/constantes.dart';
import '../../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({super.key});
var formKey=GlobalKey<FormState>();
var  searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) { },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      defoultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'please enter text to Search';

                            }
                            return null;
                          },
                          label: 'Search',
                          prefix: Icons.search_sharp,
                        onSubmit: (text){
                            SearchCubit.get(context).Search(text);
                        }
                      ),SizedBox(height: 10,),
                      if(state is SearchLoadingState)
                      const LinearProgressIndicator(),
                      const SizedBox(height: 10),
                      if(state is SearchSuccessState)
                      ListView.separated(
                          itemBuilder: (context,index)=>buildSearchItems(SearchCubit.get(context).model!.data!.data?[index],context),
                          separatorBuilder: (context,index)=>Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: 1,
                          ),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length
                      )

                    ],
                  ),
                ),
              ),
            )
          );
        },
      ),
    );
  }

  Widget buildSearchItems( model ,context , {bool isSraech=true})=> Padding(
     padding: const EdgeInsets.all(20.0),
     child: Container(
       height: 120,
       child: Row(
         children: [
           Container(

             child: Stack(
               alignment: AlignmentDirectional.bottomStart,
               children: [
                 Image(image: NetworkImage('${model.image}'),
                   width:120,
                   height: 120,
                   fit: BoxFit.cover,
                 ),
                 if(model.discount !=0)
                   Container(
                     color: Colors.red,
                     padding: const EdgeInsets.symmetric(horizontal: 5),
                     child: const Text(
                       'DISCOUNT',
                       style: TextStyle(
                           fontSize: 10,
                           color: Colors.white
                       ),
                     ),
                   ),
               ],
             ),
           ),
           SizedBox(width: 20,),
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   '${model.name}',
                   maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                   style: const TextStyle(
                     fontSize: 14,
                     height: 1.3,
                   ),
                 ),
                 const Spacer(),
                 Row(
                   children: [
                     Text(
                       '${model.price}',
                       style: const TextStyle(
                         fontSize: 12,
                         color: defaultColor,
                       ),
                     ),
                     const SizedBox(width: 5,),
                     if(model.discount !=0 && isSraech)
                       Text(
                         '${model.discount}',
                         style: const TextStyle(
                             fontSize: 10,
                             color: Colors.grey,
                             decoration: TextDecoration.lineThrough
                         ),
                       ),
                     const Spacer(),
                     IconButton(
                       onPressed: (){
                         ShopCupit.get(context).changeFavorites(model.id);
                       },
                       icon:  CircleAvatar(
                         radius: 15,
                         backgroundColor:  ShopCupit.get(context).favorits[model.id] ==true  ? defaultColor : Colors.grey,
                         child:  const Icon(Icons.favorite_border_outlined,
                           color: Colors.white,
                           size:14 ,
                         ),
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ],),
     ),
   );
}

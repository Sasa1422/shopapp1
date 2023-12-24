import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/Shop_AppStates.dart';
import 'package:untitled3/models/Shop_model/FavoretModel.dart';

import '../../../layout/Shop_App/Shop_app_Cupit/ShopApp_Cupit.dart';
import '../../../shared/components/constantes.dart';
import '../../../shared/styles/colors.dart';

class FavoretsScreen extends StatelessWidget {
  const FavoretsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
  listener: (context, state) {},
  builder: (context, state) {
    return ConditionalBuilder(
      condition:state is! ShopLoadingFavoritesDataState,
      builder: (context)=>ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildFavItem(ShopCupit.get(context).favoritesModel?.data!.data?[index] as FavoritesData ,context),
          separatorBuilder: (context,index)=>Container(color: Colors.grey,
            width: double.infinity,
            height: 1,),
          itemCount: ShopCupit.get(context).favoritesModel?.data!.data?.length as int
      ),
      fallback:(context)=>const Center(child: CircularProgressIndicator()),
    );
  },
);
  }
  Widget buildFavItem(FavoritesData model ,context)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Container(

            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(image: NetworkImage('${model.product?.image}'),
                  width:120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                if(model.product?.discount !=0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
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
                  '${model.product?.name}',
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
                      '${model.product?.price}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    if(model.product?.discount !=0)
                      Text(
                        '${model.product?.discount}',
                        style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: (){
                        print(token);
                        ShopCupit.get(context).changeFavorites(model.product?.id);
                      },
                      icon:  CircleAvatar(
                        radius: 15,
                        backgroundColor:  ShopCupit.get(context).favorits[model.product?.id] ==true  ? defaultColor : Colors.grey,
                        child:  Icon(Icons.favorite_border_outlined,
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


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/ShopApp_Cupit.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/Shop_AppStates.dart';
import 'package:untitled3/models/Shop_model/HomeModel.dart';
import 'package:untitled3/models/Shop_model/categories_model.dart';
import 'package:untitled3/shared/components/constantes.dart';
import 'package:untitled3/shared/styles/colors.dart';

import '../../../shared/components/componantes.dart';

class ProductesScreen extends StatelessWidget {
  const ProductesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessFavoretsChangeState)
        {
          if(state.model.status==false){
            showToast(text: '${state.model}', state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit=ShopCupit.get(context);
        return ConditionalBuilder(
            condition:cubit.homeModel != null && cubit.categoriesModel !=null,
            builder: (context)=>productsBuilde(cubit.homeModel , cubit.categoriesModel, context),
            fallback: (context)=> const Center(child: CircularProgressIndicator())
        );
      },
    );
  }

Widget productsBuilde(HomeModel? model, CategoriesModel? categoriesModel, BuildContext context)=>SingleChildScrollView(
  physics: const BouncingScrollPhysics(),
  child:   Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items:  model!.data?.banners.map((e) =>Image(
                image: NetworkImage('${e.image}'),
                fit: BoxFit.cover,
                width: double.infinity,)).toList(),
               options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                viewportFraction: 1 ,
                reverse: false ,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,

              ),

          ),
          const SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Text(
                   'Categories',
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.w800,
                   ),
                 ),
                 Container(
                   height: 100,
                   child: ListView.separated(
                     scrollDirection: Axis.horizontal,
                       physics: const BouncingScrollPhysics(),
                       itemBuilder: (context,index)=>buildCategoriesItem(categoriesModel.data!.data[index]),
                       separatorBuilder: (context,index)=>const SizedBox(width: 10,),
                       itemCount: categoriesModel!.data!.data.length),
                 ),
                 const Text(
                  'New Productes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
          ),
               ],
             ),
           ),
          const SizedBox(height: 10,),

          Container(
               color: Colors.grey[300],
              child: GridView.count(
                   shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                   mainAxisSpacing: 10,
                  crossAxisSpacing: 7,
                  crossAxisCount: 2,
                childAspectRatio: 1/1.75,
                children: List.generate(
                    model.data!.products.length,
                        (index) =>buildGridProduct( model.data!.products[index], context)),
              ),
            ),
        ],

  ),
);

Widget buildGridProduct(ProductModel model ,context)=>Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage('${model!.image}'),
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,),
            if(model.discount !=0)
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
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
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(width: 5,),
                  if(model.discount !=0)
                  Text(
                    '${model.oldprice.round()}',
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
                        ShopCupit.get(context).changeFavorites(model.id);
                      },
                      icon:  CircleAvatar(
                        radius: 15,
                        backgroundColor:  ShopCupit.get(context).favorits[model.id] ==true  ? defaultColor : Colors.grey,
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
  );

Widget buildCategoriesItem(DataModel data)=> Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(image: NetworkImage('${data.image}'),
      height: 100,
      width: 100,
      fit: BoxFit.cover,
    ),
    Container(
      width: 100,
      color: Colors.black.withOpacity(.8),
      child: Text('${data.name}',
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,

        ),),
    ),
  ],
);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/ShopApp_Cupit.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/Shop_AppStates.dart';
import 'package:untitled3/models/Shop_model/categories_model.dart';

class CategoresScreen extends StatelessWidget {
  const CategoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCupit, ShopStates>(
      listener: (context, state) { } ,
      builder: (context, state) {
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCatItem(ShopCupit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                ),
            itemCount: ShopCupit.get(context).categoriesModel!.data!.data.length);
      },
    );
  }


  Widget buildCatItem(DataModel model) =>
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(image: NetworkImage(
                   '${model.image}'),
              height: 80,
              width: 80,
            ),
            const SizedBox(width: 20,),
            Text(
              '${model.name}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Spacer(),
            Icon(
                Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}

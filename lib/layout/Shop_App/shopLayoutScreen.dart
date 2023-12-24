import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/ShopApp_Cupit.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/Shop_AppStates.dart';
import 'package:untitled3/medules/ShopAppsScreen/search_Screen/searchScreen.dart';
import 'package:untitled3/shared/components/componantes.dart';

class shopLayoutScreen extends StatelessWidget {
  const shopLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCupit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cupit=ShopCupit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('SALLA'),
              actions: [
                  IconButton(
                      onPressed:(){
                        navigateTo(context, SearchScreen());
                      },
                      icon:const Icon (Icons.search))
              ],
            ),
            body: cupit.Screens[cupit.curentIndex] ,

            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cupit.ChangeShopBottomNavBar(index);
              },
              currentIndex: cupit.curentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home_filled),
                label: 'HOME'
                ),
                BottomNavigationBarItem(icon: Icon(Icons.apps),
                    label: 'CATEGORIES'
                ),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),
                    label: 'Favorites'
                ),
                BottomNavigationBarItem(icon: Icon(Icons.settings),
                    label: 'SETTINGS'
                ),

              ],
            ),
          );
        },
    );
  }
}

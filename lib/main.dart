import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/layout/Shop_App/Shop_app_Cupit/ShopApp_Cupit.dart';
import 'package:untitled3/layout/Shop_App/shopLayoutScreen.dart';
import 'package:untitled3/shared/AppCupit/AppCupit.dart';
import 'package:untitled3/shared/AppCupit/AppState.dart';
import 'package:untitled3/shared/bloc_observer.dart';
import 'package:untitled3/shared/components/constantes.dart';
import 'package:untitled3/shared/network/local/cash_Helper.dart';
import 'package:untitled3/shared/network/remote/dio_helper.dart';
import 'package:untitled3/shared/styles/themes.dart';
import 'layout/news_App/news_cubit/news_cubit.dart';
import 'medules/ShopAppsScreen/Login_Shop/shopLogIn.dart';
import 'medules/ShopAppsScreen/onbording_Screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
   bool? isDark=CachHelper.getData(key: 'isDark') ;
   Widget widget;
   bool? onBoarding=CachHelper.getData(key: 'onBoarding');
   token=CachHelper.getData(key: 'token');
if(onBoarding !=null){
  if(token !=null){
    widget=shopLayoutScreen();
  }else{
    widget=shopLoginScreen();
  }
}else{
  widget=onBoardingScreen();
}


  runApp(MyApp(
     isDark: isDark!,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
   final bool isDark;
   final Widget startWidget;
   MyApp( {super.key,  required this.isDark,  required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
          AppCupit()
           ..ChangeAppMode(
              fromShared: isDark
    ),

        ),
        BlocProvider(
          create: (context) => NewsCubit()..getBusiness()..getSports()..getScinces(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCupit()..getHomData()..getCategoriesData()..getFavoritesData()..getUserData()
        ),
      ],
      child: BlocConsumer<AppCupit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightThemes,
            darkTheme: darkTheme,
            themeMode:ThemeMode.light,
            //AppCupit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home:  Directionality(
                textDirection: TextDirection.ltr,
                child:startWidget),

          );
        },
      ),
    );
  }
}

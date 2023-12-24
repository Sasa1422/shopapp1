
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/news_App/news_cubit/news_state.dart';
import '../network/local/cash_Helper.dart';
import 'AppState.dart';

class AppCupit extends Cubit<AppStates>
{
  AppCupit():super(IntialAppState());
   static AppCupit get(context)=>BlocProvider.of(context);
  bool isDark=false;

  void ChangeAppMode({bool? fromShared})
  {
    if (fromShared !=null ){
      isDark=fromShared;
      emit(ChangeAppModeThemeState());

    }else{
      isDark = !isDark;
      CachHelper.putBoolean(key: 'isDark', value: isDark)?.then((value) {
        emit(ChangeAppModeThemeState());


      });
    }

  }

}
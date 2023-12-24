import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled3/models/Shop_model/Search_Model.dart';
import 'package:untitled3/shared/components/constantes.dart';
import 'package:untitled3/shared/network/remote/dio_helper.dart';

import '../../../shared/network/endPoint.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;

  void Search(String? text){

     DioHelper.postData(
         url: SEARCH,
         token: token,
         data: {
           'text':text
         }
     )?.then((value){
       model=SearchModel.fromJson(value.data);
        emit(SearchSuccessState());
     }).catchError((error){
       emit(SearchErrorState());
       print(error.toString());
     });

  }
}

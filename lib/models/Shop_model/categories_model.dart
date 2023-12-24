class CategoriesModel
{
  bool? status;
  CatrgoriesDataModel? data;

  CategoriesModel.FormJeson(Map<String, dynamic>jeson)
  {
    status=jeson['status'];
    data=CatrgoriesDataModel.FormJeson( jeson['data']);

  }
}
class CatrgoriesDataModel {
  int? currentpage;
  List<DataModel> data=[];

  CatrgoriesDataModel.FormJeson(Map<String, dynamic>jeson)
  {
    currentpage = jeson['current_page'];

    if (jeson['data'] != null) {
      jeson['data'].forEach((element) {
        data.add(DataModel.FormJeson(element));
      });
    }
  }
}
class DataModel
{
  int? id;
  String? name;
  String? image;

  DataModel.FormJeson(Map<String,dynamic>jeson)
  {
    id=jeson['id'];
    name=jeson['name'];
    image=jeson['image'];
  }
}
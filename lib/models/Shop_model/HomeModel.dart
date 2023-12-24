class HomeModel
{
  bool? status;
  HomeDataModel? data;

    HomeModel.forJeson(Map<String,dynamic>jeson){
     status=jeson['status'];
     data=HomeDataModel.formJeson(jeson['data']);
    }

}

class HomeDataModel
{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];
  HomeDataModel.formJeson(Map<String,dynamic>jeson)
  {
    if(jeson['banners'] !=null) {
      jeson['banners'].forEach((element) {
        banners.add(BannerModel.formJeson(element));
      });
    }
    if(jeson['products'] !=null) {
      jeson['products'].forEach((element) {
        products.add(ProductModel.formJeson(element));
      });
    }
  }

}

class BannerModel
{
  int? id;
  String? image;
  BannerModel.formJeson(Map<String,dynamic>jeson){
    id=jeson['id'];
    image=jeson['image'];
  }
}

class ProductModel
{
  int? id;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  String? name;
  String? image;
  String? description;
  bool? infavorites;
  bool? incart;
  ProductModel.formJeson(Map<String,dynamic>jeson){
     id=jeson['id'];
     price=jeson['price'];
     oldprice=jeson['old_price'];
     discount=jeson['discount'];
     name=jeson['name'];
     image=jeson['image'];
     description=jeson['description'];
     infavorites=jeson['in_favorites'] ?? false;
     incart=jeson['in_cart'];
  }
}
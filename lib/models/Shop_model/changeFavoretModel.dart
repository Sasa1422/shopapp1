class ChangeFavoritesModel
{
  bool? status;
  String? message;

  ChangeFavoritesModel.FormJeson(Map<String,dynamic>jeson)
  {
   status=jeson['status'];
   message=jeson['message'];
  }
  }

import '../../medules/ShopAppsScreen/Login_Shop/shopLogIn.dart';
import '../network/local/cash_Helper.dart';
import 'componantes.dart';
void singOut(context) {
  CachHelper.removeData(key: 'token').then((value) {
    if (value == true) {
      navigateAndFinsh(context, shopLoginScreen());
    }
  });
}

String? token='';
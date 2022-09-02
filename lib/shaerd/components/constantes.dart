import 'package:khwass_app/modules/shopping_app/login_shop/login_screen.dart';
import 'package:khwass_app/network/local/cache_helper.dart';
import 'package:khwass_app/shaerd/components/components.dart';

String token='';

void logOut(context)
{
CacheHelper.removeData(
    key: 'token'
).then((value)
{
  if(value) {
    navigatorToAndFinch(
        context,
        ShopAppLogin());
  }
    });
}

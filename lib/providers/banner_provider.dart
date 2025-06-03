import 'package:projectwithnode/models/banner_model.dart';
import 'package:riverpod/riverpod.dart';

class BannerProvider  extends StateNotifier<List<BannerModel>>{
  BannerProvider() : super([]);

   void setBanners(List<BannerModel> banners){
    state=banners;
   }
}
 final bannerProvider =StateNotifierProvider<BannerProvider,List<BannerModel>>(
  (ref){
    return BannerProvider();
  }
 );
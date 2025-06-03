import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectwithnode/models/banner_model.dart';
import 'package:projectwithnode/controllers/banner_controller.dart';
import 'package:projectwithnode/providers/banner_provider.dart';

class BannerWidget extends ConsumerStatefulWidget {
  const BannerWidget({super.key});

  @override
  ConsumerState<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends ConsumerState<BannerWidget> {
  late Future<List<BannerModel>> futureBanners; 
  // Bannercontroller _bannercontroller=Bannercontroller();
  void initState(){
    super.initState();
    // futureBanners=_bannercontroller.loadBanners();
    _fetechBanners();
  }
  Future<void> _fetechBanners() async{
    final Bannercontroller _bannercontroller=Bannercontroller();
    try{
      final banners=await _bannercontroller.loadBanners();
      ref.read(bannerProvider.notifier).setBanners(banners);

    }
    catch(e){

    }

  }
  @override
  Widget build(BuildContext context) {
    final banners=ref.watch(bannerProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color:const Color(0xFFF7F7F7F),
          borderRadius: BorderRadius.circular(5),
        ),
        child: PageView.builder(
          itemCount: banners!.length,
         itemBuilder: (context,index){
          final banner=banners[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              banner.image,
              fit: BoxFit.cover,
             
            ),
          );
         }),
      ),
    );
  }
}
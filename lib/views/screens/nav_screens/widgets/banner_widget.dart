import 'package:flutter/material.dart';
import 'package:projectwithnode/models/banner_model.dart';
import 'package:projectwithnode/controllers/banner_controller.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  late Future<List<BannerModel>> futureBanners; 
  Bannercontroller _bannercontroller=Bannercontroller();
  void initState(){
    super.initState();
    futureBanners=_bannercontroller.loadBanners();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color:Color(0xFFF7F7F7F),
          borderRadius: BorderRadius.circular(5),
        ),
        child: FutureBuilder(future:futureBanners,
     builder: (context,snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child:  CircularProgressIndicator());
      }
      else if(snapshot.hasError){
        return Center(
          child: Text("Error: ${snapshot.error}"),
        );
      }
      else if(!snapshot.hasData || snapshot.data!.isEmpty){
        return Center(
          child: Text("No Banners"),
        );
      }
      else{
        final banners=snapshot.data;
        return PageView.builder(
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
         });
      }
     }
    ) ,
      ),
    );
  }
}
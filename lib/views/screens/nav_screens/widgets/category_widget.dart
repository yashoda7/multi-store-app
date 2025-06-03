// import 'package:projectwithnode/controllers/cate';
import 'package:projectwithnode/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:projectwithnode/models/category.dart';
import 'package:projectwithnode/views/screens/details/screens/innercategory_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  //A future the list of categories once loaded from th api
  late Future<List<Category>> futureCategories;
  Categorycontroller _categorycontroller=Categorycontroller();
  void initState(){
    super.initState();
    futureCategories=_categorycontroller.loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: "categories", subtitle: "view all"),
        SizedBox(height: 10,),
        FutureBuilder(future:futureCategories,
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
            final categories=snapshot.data;
            return SingleChildScrollView(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories!.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6,crossAxisSpacing: 8,mainAxisSpacing: 8),
                      
               itemBuilder: (context,index){
                final category=categories[index];
               return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(4),
                        child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return InnercategoryScreen(category: category);
                }));
              },
              child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
              Image.network(
                category.image,
                width: 47,
                height: 47,
              ),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  // fontSize: 16,
                ),
              ),
                      ],
              ),
                        ),
                      );
               }),
            );
          }
         }
        ),
        
      ],
    );  
  }
}
// import 'package:projectwithnode/controllers/cate';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectwithnode/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:projectwithnode/models/category.dart';
import 'package:projectwithnode/providers/category_provider.dart';
import 'package:projectwithnode/views/screens/details/screens/innercategory_screen.dart';
import 'package:projectwithnode/views/screens/nav_screens/widgets/reusable_text_widget.dart';
// import 'package:projectwithnode/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoryWidget extends ConsumerStatefulWidget {
  const CategoryWidget({super.key});

  @override
  ConsumerState<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends ConsumerState<CategoryWidget> {
  //A future the list of categories once loaded from th api
  late Future<List<Category>> futureCategories;
  // Categorycontroller _categorycontroller=Categorycontroller();
  void initState(){
    super.initState();
    // futureCategories=_categorycontroller.loadCategories();
    _fetechCategories();
  }
  Future<void> _fetechCategories() async{
    final Categorycontroller categorycontroller=Categorycontroller();
    try{
      final categories= await categorycontroller.loadCategories();
      // final  cat=await 
      ref.read(categoryProvider.notifier).setCategory(categories);

    }
    catch(e){

    }

  }
  @override
  Widget build(BuildContext context) {
    final categories=ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableTextWidget(title: "Categories", subtitle: "View All"),
        GridView.builder(
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
      ],
    );  
  }
}
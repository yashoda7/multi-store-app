import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectwithnode/models/subcategory.dart';

final subcategoryProvider = StateNotifierProvider<SubcategoryNotifier, List<SubCategory>>((ref) {
  return SubcategoryNotifier();
});

class SubcategoryNotifier extends StateNotifier<List<SubCategory>> {
  SubcategoryNotifier() : super([]);

  void setSubcategories(List<SubCategory> subcategories) {
    state = subcategories;
  }
}
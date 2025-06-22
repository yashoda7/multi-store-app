import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectwithnode/models/product.dart';

class TopRatedProductsProvider extends StateNotifier<List<Product>> {
  TopRatedProductsProvider() : super([]);

  //set the list of products
  void setProducts(List<Product> products) {
    state = products;
  }
}

final topRatedProductsProvider =
    StateNotifierProvider<TopRatedProductsProvider, List<Product>>((ref) {
  return TopRatedProductsProvider();
});
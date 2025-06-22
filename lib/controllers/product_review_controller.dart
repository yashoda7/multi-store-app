import 'package:projectwithnode/global_variable.dart';
import 'package:projectwithnode/models/product_review.dart';
import 'package:http/http.dart' as http;
import 'package:projectwithnode/services/manage_http_response.dart';

class ProductReviewController {
  uploadReview({
    required String buyerId,
    required String email,
    required String fullName,
    required String productId,
    required double rating,
    required String review,
    
    required context,
  }) async {
    try {
      final ProductReview productReview = ProductReview(
          id: '',
          buyerId: buyerId,
          email: email,
          fullName: fullName,
          productId: productId,
          rating: rating,
          review: review);

        http.Response response = await http.post(
        Uri.parse("$uri/api/product-review"),
        body: productReview.toJson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );
           manageHttpResponse(
          response: response,
          context: context,
          onSucess: () {
            showSnackBar(context, 'You have added a review ');
          });    
    } catch (e) {
      return showSnackBar(context, 'Error uploading review: $e');
    }
  }
}

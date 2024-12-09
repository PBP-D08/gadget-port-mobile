// lib/services/product_service.dart

import 'package:pbp_django_auth/pbp_django_auth.dart';
import '../models/products.dart';

class ProductService {
  final CookieRequest request;

  ProductService(this.request);

  Future<List<Product>> fetchProducts() async {
    final response = await request.get('http://your-domain.com/products/api/products/');
    return productFromJson(response);
  }

  Future<Product?> fetchProductById(int id) async {
    final response = await request.get('http://your-domain.com/products/api/product/$id/');
    List<Product> products = productFromJson(response);
    return products.isNotEmpty ? products.first : null;
  }

  Future<bool> addProduct({
    required String name,
    required String category,
    required String brand,
    required int price,
    required String imageLink,
    required String spec,
    required int storeId,
  }) async {
    try {
      final response = await request.post(
        'http://your-domain.com/products/add_product/',
        {
          'name': name,
          'category': category,
          'brand': brand,
          'price': price.toString(),
          'image_link': imageLink,
          'spec': spec,
          'store': storeId.toString(),
        },
      );
      
      return response['status'] == 201;
    } catch (e) {
      return false;
    }
  }
}
// lib/services/wishlist_service.dart

import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class WishlistService {
  final CookieRequest request;
  final String baseUrl =
      'http://localhost:8000'; // Sesuaikan dengan URL Django Anda

  WishlistService(this.request);

  Future<bool> isInWishlist(String productId) async {
    try {
      final response = await request.get(
        '$baseUrl/wishlist/json/',
      );

      // Parse response dan cek apakah produk ada di wishlist
      List<dynamic> wishlistItems = jsonDecode(response);
      return wishlistItems
          .any((item) => item['fields']['product'].toString() == productId);
    } catch (e) {
      print('Error checking wishlist status: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> addToWishlist(String productId) async {
    try {
      final response = await request.post(
        '$baseUrl/wishlist/add/$productId/',
        jsonEncode({}),
      );

      if (response['status'] != null) {
        return response;
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error adding to wishlist: $e');
      rethrow; // Propagate error to be handled by caller
    }
  }

  Future<Map<String, dynamic>> removeFromWishlist(String productId) async {
    try {
      final response = await request.post(
        '$baseUrl/wishlist/remove/$productId/',
        jsonEncode({}),
      );

      return response;
    } catch (e) {
      print('Error removing from wishlist: $e');
      return {'status': 'error', 'message': e.toString()};
    }
  }

  Future<List<dynamic>> getWishlistItems() async {
    try {
      final response = await request.get(
        '$baseUrl/wishlist/json/',
      );
      return jsonDecode(response);
    } catch (e) {
      print('Error fetching wishlist items: $e');
      return [];
    }
  }
}

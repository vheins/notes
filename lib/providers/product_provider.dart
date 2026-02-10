import 'package:flutter/material.dart';
import 'package:pos_app/db/database_helper.dart';
import 'package:pos_app/models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _products = await DatabaseHelper.instance.readAllProducts();
    } catch (e) {
      _error = 'Error loading products: $e';
      print(_error);
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    await DatabaseHelper.instance.create(product);
    await loadProducts();
  }

  Future<void> updateProduct(Product product) async {
    await DatabaseHelper.instance.update(product);
    await loadProducts();
  }

  Future<void> deleteProduct(int id) async {
    await DatabaseHelper.instance.delete(id);
    await loadProducts();
  }
}

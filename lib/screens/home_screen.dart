import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pos_app/providers/product_provider.dart';
import 'package:pos_app/providers/cart_provider.dart';
import 'package:pos_app/screens/cart_screen.dart';
import 'package:pos_app/screens/product_management_screen.dart';
import 'package:pos_app/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load products when screen initializes
    Future.microtask(() =>
        Provider.of<ProductProvider>(context, listen: false).loadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POS App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ProductManagementScreen()),
              );
            },
            tooltip: 'Manage Products',
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              label: Text(cart.itemCount.toString()),
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (ctx, productProvider, _) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productProvider.products.isEmpty) {
            return const Center(child: Text('No products available.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: productProvider.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) {
              final product = productProvider.products[i];
              return Card(
                elevation: 4,
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      product.name,
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: Consumer<CartProvider>(
                      builder: (ctx, cart, _) => IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: product.stock > 0
                            ? () {
                                cart.addItem(product);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added item to cart!'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              }
                            : null, // Disable if out of stock, though stock logic in cart isn't strictly enforced in requirements yet
                      ),
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.shopping_bag, size: 50, color: Theme.of(context).primaryColor),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

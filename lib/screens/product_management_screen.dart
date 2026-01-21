import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pos_app/providers/product_provider.dart';
import 'package:pos_app/screens/product_form_screen.dart';

class ProductManagementScreen extends StatelessWidget {
  const ProductManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const ProductFormScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (ctx, productProvider, _) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productProvider.products.isEmpty) {
            return const Center(child: Text('No products. Add some!'));
          }

          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (ctx, i) {
              final product = productProvider.products[i];
              return Column(
                children: [
                  ListTile(
                    title: Text(product.name),
                    subtitle: Text(
                        'Price: \$${product.price.toStringAsFixed(2)} | Stock: ${product.stock}'),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.purple),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductFormScreen(product: product),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final confirmed = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Are you sure?'),
                                  content: const Text(
                                      'Do you want to remove this product?'),
                                  actions: [
                                    TextButton(
                                      child: const Text('No'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop(false);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Yes'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop(true);
                                      },
                                    ),
                                  ],
                                ),
                              );

                              if (confirmed == true) {
                                await productProvider
                                    .deleteProduct(product.id!);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

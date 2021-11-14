import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/products.dart';

import '/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  // --- accepted from product_overview_screen --- //
  
  final bool showFav;
  ProductsGrid(this.showFav);
  // const ProductsGrid({
  //   Key? key,
  //   required this.loadedProduct,
  // }) : super(key: key);

  // final List<Product> loadedProduct;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFav ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3 / 2),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        // create: (c) => products[i],
        child: ProductItem(),
      ),
      // itemBuilder: (ctx, i) =>  ProductItem(
      //         products[i].id,
      //         products[i].title,
      //         products[i].imageUrl,
      //       ),
    );
  }
}

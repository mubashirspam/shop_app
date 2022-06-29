import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productdata = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditproductScreen.routeName);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: productdata.items.length,
            itemBuilder: (_, i) => Card(
                  elevation: 0,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: UserProductItem(
                    productdata.items[i].id,
                    productdata.items[i].imageUrl,
                    productdata.items[i].title,
                  ),
                ),
                ),
      ),
    );
  }
}

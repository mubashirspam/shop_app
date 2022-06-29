import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';

import 'package:shop_app/widgets/product_grid.dart';

enum FilterOption {
  Favorite,
  All,
  WithoutFavorite,
}

class ProductOverView extends StatefulWidget {
  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Consumer<Cart>(
                builder: (ctx, cart, ch) => Badge(
                      child: ch as Widget,
                      value: cart.itemCount,
                      color: Colors.black,
                    ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(
                    Icons.shopping_cart_rounded,
                  ),
                )),
          ),
          PopupMenuButton(
            onSelected: (FilterOption selectedValue) {
              setState(() {
                if (selectedValue == FilterOption.Favorite) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorite'),
                value: FilterOption.Favorite,
              ),
              PopupMenuItem(
                child: Text('All Item'),
                value: FilterOption.All,
              ),
              PopupMenuItem(
                child: Text('With Out Favorite'),
                value: FilterOption.WithoutFavorite,
              ),
            ],
            icon: Icon(Icons.more_vert_outlined),
          ),
        ],
        title: Text('Myshop'),
      ),

      // body: Column(children: [
      //   Container(
      //     height: 500,
      //     child:

      body: ProductsGrid(_showOnlyFavorite),
      //   ),
      //   TextButton(
      //     onPressed: () {
      //       Navigator.of(context)
      //           .pushNamed(FavoriteScreen.routeName,);
      //     },
      //     child: Text('press'),
      //   )
      // ]),
    );
  }
}

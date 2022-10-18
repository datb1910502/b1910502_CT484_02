import 'package:flutter/material.dart';
import 'package:myshop/ui/cart/cart_manager.dart';
import 'package:myshop/ui/order/order_manager.dart';
import 'ui/products/product_detail_screen.dart';
import 'ui/products/product_manager.dart';
import 'ui/products/product_overview_screen.dart';
import 'ui/products/user_products_screen.dart';
import 'ui/cart/cart_screen.dart';
import 'ui/order/order_screen.dart';
import 'package:provider/provider.dart';
import 'ui/screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager(),
        ),
      ],
      child: MaterialApp(

      title: 'My Shop',
      debugShowCheckedModeBanner : false ,
      theme : ThemeData (
        fontFamily : ' Lato ' ,
        colorScheme : ColorScheme.fromSwatch (
          primarySwatch : Colors.purple ,
        ).copyWith (
          secondary : Colors.deepOrange ,
        ),
      ),
     home: const ProductsOverviewScreen(),
      routes: {
        CartScreen.routeName: (ctx) => const CartScreen(),
        OrderScreen.routeName: (ctx) => const OrderScreen(),
        UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == ProductDetailScreen.routeName) {
          final productId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (ctx) {
              return ProductDetailScreen(
                ctx.read<ProductManager>().findById(productId),
              );
            },
          );
        }
        return null;
      },
    ),
    );
  }
}

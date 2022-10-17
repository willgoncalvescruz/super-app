import 'package:flutter/material.dart';
import 'package:super_app/screens/loja_virtual/models/cart_model.dart';
import 'package:super_app/screens/loja_virtual/models/user_model.dart';
import 'package:super_app/screens/loja_virtual/screens/login_screen.dart';
import 'package:super_app/screens/loja_virtual/screens/order_screen.dart';
import 'package:super_app/screens/loja_virtual/tiles/cart_tile.dart';
import 'package:super_app/screens/loja_virtual/widgets/cart_price.dart';
import 'package:super_app/screens/loja_virtual/widgets/discount_card.dart';
import 'package:super_app/screens/loja_virtual/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu Carrinho"),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  //"${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  "$p ${p == 1 ? "ITEM" : "ITENS"}",
                  style: const TextStyle(fontSize: 17.0),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isLoggedIn()) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!UserModel.of(context).isLoggedIn()) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.remove_shopping_cart,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text(
                  "Faça o login para adicionar produtos!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                  ),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                  //textColor: Colors.white,
                  //color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  },
                )
              ],
            ),
          );
          //} else if (model.products == null || model.products.length == 0) {
        } else if (model.products.isEmpty) {
          return const Center(
            child: Text(
              "Nenhum produto no carrinho!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView(
            children: <Widget>[
              Column(
                children: model.products.map((product) {
                  return CartTile(product);
                }).toList(),
              ),
              const DiscountCard(),
              ShipCard(),
              CartPrice(() async {
                String? orderId = await model.finishOrder();
                if (orderId != null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => OrderScreen(orderId)));
                }
              }),
            ],
          );
        }
      }),
    );
  }
}

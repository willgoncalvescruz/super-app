import 'package:flutter/material.dart';
import 'package:super_app/screens/loja_virtual/models/cart_model.dart';
import 'package:super_app/screens/loja_virtual/models/user_model.dart';
import 'package:super_app/screens/loja_virtual/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

//void main() => runApp(new LojaVirtual());

class LojaVirtual extends StatelessWidget {
  const LojaVirtual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return ScopedModel<CartModel>(
/*      UserModel user;
  List<CartProduct> products = [];
  String couponCode;
  int discountPercentage = 0;
  bool isLoading = false; */
          model: CartModel(
              model /* isLoading, couponCode, discountPercentage, isLoading */),
          child: MaterialApp(
              title: "Flutter's Clothing",
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: const Color.fromARGB(255, 4, 125, 141)),
              debugShowCheckedModeBanner: false,
              home: HomeScreen()),
        );
      }),
    );
  }
}

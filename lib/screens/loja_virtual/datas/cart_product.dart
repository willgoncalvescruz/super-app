import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:super_app/screens/loja_virtual/datas/product_data.dart';

class CartProduct {
  late String cid;
  late String category;
  late String pid; //id unico por usuário firebase
  late int quantity;
  late String size;
  late ProductData productData;

  CartProduct(
      /* 
    this.cid,
    this.category,
    this.pid,
    this.quantity,
    this.size,
    this.productData, */
      );

  CartProduct.fromDocument(DocumentSnapshot document) {
    cid = document.id;
    category = document["category"];
    pid = document["pid"];
    quantity = document["quantity"];
    size = document["size"];
    productData = document["productData"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "quantity": quantity,
      "size": size,
      "product": productData.toResumedMap()
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:super_app/screens/loja_virtual/datas/product_data.dart';
import 'package:super_app/screens/loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const CategoryScreen(this.snapshot, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.get('title')),
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("products")
                  .doc(snapshot.id)
                  .collection("items")
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                            padding: const EdgeInsets.all(4.0),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              childAspectRatio: 0.65,
                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              ProductData data = ProductData.fromDocument(
                                  snapshot.data!.docs[index]);
                              data.category = this.snapshot.id;
                              return ProductTile("grid", data);
                            }),
                        ListView.builder(
                            padding: const EdgeInsets.all(4.0),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              ProductData data = ProductData.fromDocument(
                                  snapshot.data!.docs[index]);
                              data.category = this.snapshot.id;
                              return ProductTile("list", data);
                            })
                      ]);
                }
              })),
    );
  }
}

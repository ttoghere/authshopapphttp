import 'package:authshopapphttp/app_drawer.dart';
import 'package:authshopapphttp/screens/edit/edit_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:authshopapphttp/providers/product.dart';

class ProductList extends StatelessWidget {
  static const routeName = "/pl";
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final prodList = productsData.items;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Product List"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: prodList.length,
          itemBuilder: (context, index) => ProductTile(
            title: prodList[index].title,
            imgUrl: prodList[index].imageUrl,
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final String title;
  final String imgUrl;
  const ProductTile({
    Key? key,
    required this.title,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FittedBox(
        child: CircleAvatar(
          backgroundImage: NetworkImage(imgUrl),
        ),
      ),
      title: Text(title),
      trailing: Container(
        width: 150,
        child: Row(
          children: [
            Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red[900],
                    size: 35,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditProduct.routeName);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green[900],
                    size: 35,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

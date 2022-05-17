import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: ListView(
        children: [
          ProductTile(),
        ],
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: FittedBox(
          child: Text("İmage"),
        ),
      ),
      title: Text("Product Title"),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            Spacer(),
            Row(
              children: [
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.delete,
                  color: Colors.red[900],
                  size: 35,
                ),),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.edit,
                  color: Colors.green[900],
                  size: 35,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

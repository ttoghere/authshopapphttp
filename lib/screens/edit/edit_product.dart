import 'package:authshopapphttp/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProduct extends StatefulWidget {
  static const routeName = "/ep";
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  FocusNode _priceFocusNode = FocusNode();
  FocusNode _descriptionFocusNode = FocusNode();
  FocusNode _imgUrlFocusNode = FocusNode();
  GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _imgUrlTEC = TextEditingController();
  @override
  void dispose() {
    _imgUrlTEC.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Product",
        ),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                focusNode: _priceFocusNode,
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                keyboardType: TextInputType.numberWithOptions(signed: true),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_imgUrlFocusNode);
                },
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                focusNode: _imgUrlFocusNode,
                decoration: InputDecoration(
                  labelText: "Image",
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Placeholder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

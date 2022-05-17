import 'package:authshopapphttp/app_drawer.dart';
import 'package:authshopapphttp/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  static const routeName = "/ep";
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _imgUrlTEC = TextEditingController();
  bool _isInit = true;
  var _editedProduct = Product(
    id: "",
    title: "",
    description: "",
    price: 0,
    imageUrl: "",
  );
  var _initValues = {
    "title": "",
    "price": "",
    "description": "",
    "imageUrl": "",
  };
  @override
  void initState() {
    super.initState();
    _imgUrlFocusNode.addListener(() => updateImgUrl());
  }

  void updateImgUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      if (_imgUrlTEC.text.isEmpty ||
          (!_imgUrlTEC.text.startsWith("http") &&
              !_imgUrlTEC.text.startsWith("https")) ||
          (!_imgUrlTEC.text.endsWith(".png") &&
              !_imgUrlTEC.text.endsWith(".jpeg") &&
              !_imgUrlTEC.text.endsWith(".jpg"))) {
        return null;
      }
      setState(() {});
    }
  }

  void saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();
    Provider.of<Products>(context, listen: false)
        .addProduct(product: _editedProduct);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      var productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != "") {
        _editedProduct =
            Provider.of<Products>(context, listen: false).itemFilter(productId );
        _initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          "imageUrl": "",
        };
        _imgUrlTEC.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imgUrlTEC.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlFocusNode.dispose();
    _imgUrlFocusNode.removeListener(() => updateImgUrl());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Product",
        ),
        actions: [
          IconButton(
            onPressed: () => saveForm(),
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues["title"],
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: newValue.toString(),
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please write a title";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                initialValue: _initValues["price"],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a price";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid price";
                  }
                  if (double.parse(value) <= 0) {
                    return "Enter a number what is greater than 0";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(newValue!),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
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
                initialValue: _initValues["description"],
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: newValue.toString(),
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a description";
                  }
                  if (value.length <= 10) {
                    return "Please enter a description what is greater than 10 chars";
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a image url";
                  }
                  if (!value.startsWith("http") && !value.startsWith("https")) {
                    return "Please enter a valid link";
                  }
                  if (!value.endsWith(".png") &&
                      !value.endsWith(".jpeg") &&
                      !value.endsWith(".jpg")) {
                    return "Please enter a image url";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: newValue.toString(),
                  );
                },
                controller: _imgUrlTEC,
                focusNode: _imgUrlFocusNode,
                decoration: InputDecoration(
                  labelText: "Image",
                ),
                keyboardType: TextInputType.url,
                onFieldSubmitted: (value) => saveForm(),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: _imgUrlTEC.text.isEmpty
                    ? Center(
                        child: Text(
                          "Enter a url",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : FittedBox(
                        child: Image.network(
                          _imgUrlTEC.text,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

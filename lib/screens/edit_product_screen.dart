import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/provider/products.dart';

class EditproductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditproductScreenState createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );
  var _initValue = {
    "title": '',
    'price': 0,
    'description': '',
    'imageUrl': '',
  };
  var _isInit = true;

  @override
  void initState() {
    //  final productId = ModalRoute.of(context).settings.arguments as String;
    // this not work in inistate then we can use didChangedependencis

    _imageUrlFocusNode.addListener(updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // for edit product

    if (_isInit) {
      final  productId = ModalRoute.of(context)?.settings.arguments as String;
      if (productId != '') {
        _editProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValue = {
          'title': _editProduct.title,
          'price': _editProduct.price.toString(),
          'description': _editProduct.description,
          // 'imageUrl': _editProduct.imageUrl,
          // text controller using in this field
          'imageUrl': ''
        };
        _imageUrlController.text = _editProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(updateImageUrl);
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (_imageUrlController.text.isEmpty ||
          (!_imageUrlController.text.startsWith("http") &&
              !_imageUrlController.text.startsWith("https")) ||
          (!_imageUrlController.text.endsWith(".jpg") &&
              !_imageUrlController.text.endsWith(".png") &&
              !_imageUrlController.text.endsWith(".jpeg"))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
      // note save input befor validation
    }
    _form.currentState!.save();
    if (_editProduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editProduct.id, _editProduct);
      // for update existing product data
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editProduct);
     
    }
     Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: _saveForm,
              icon: Icon(Icons.save_outlined),
            ),
          ],
          title: Text('EditProduct'),
        ),
        body: Padding(
          padding: EdgeInsets.all(
            15,
          ),
          child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initValue['title'].toString(),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  onSaved: (value) {
                    _editProduct = Product(
                        // id: null.toString(), for new
                        // for update use under this
                        id: _editProduct.id,
                        isFavorite: _editProduct.isFavorite,
                        title: value.toString(),
                        description: _editProduct.description,
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Pleas write text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initValue['price'].toString(),
                  focusNode: _priceFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    label: Text('Price'),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Add price ';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Add valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Graterthan zero ';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    _editProduct = Product(
                        // id: null.toString(), for new
                        // for update use under this
                        id: _editProduct.id,
                        isFavorite: _editProduct.isFavorite,
                        title: _editProduct.title,
                        description: _editProduct.description,
                        price: double.parse(value.toString()),
                        imageUrl: _editProduct.imageUrl);
                  },
                ),
                TextFormField(
                  initialValue: _initValue['description'].toString(),
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  decoration: InputDecoration(
                    label: Text('Description'),
                  ),
                  onSaved: (value) {
                    _editProduct = Product(
                        id: _editProduct.id,
                        isFavorite: _editProduct.isFavorite,
                        // id: null.toString(),
                        title: _editProduct.title,
                        description: value.toString(),
                        price: _editProduct.price,
                        imageUrl: _editProduct.imageUrl);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Add Description';
                    }
                    if (value.length < 10) {
                      return ' shuld be at least 10 charector long';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      color: Colors.grey[100],
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: _imageUrlController.text.isEmpty ||
                              !_imageUrlController.text.startsWith("http") &&
                                  !_imageUrlController.text
                                      .startsWith("https") &&
                                  !_imageUrlController.text.endsWith(".jpg") &&
                                  !_imageUrlController.text.endsWith(".png") &&
                                  !_imageUrlController.text.endsWith(".jpeg")
                          ? Center(
                              child: Text('Enter A Url'),
                            )
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initValue['imageUrl'].toString(),
                        decoration: InputDecoration(
                          label: Text('ImagUrl'),
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (value) {
                          _editProduct = Product(
                              // id: null.toString(),
                              id: _editProduct.id,
                              isFavorite: _editProduct.isFavorite,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              price: _editProduct.price,
                              imageUrl: value.toString());
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an image URL';
                          }
                          if (!value.startsWith("http") &&
                              !!value.startsWith("https")) {
                            return 'Please enter Valid URL';
                          }
                          if (!value.endsWith(".jpg") &&
                              !!value.endsWith(".png") &&
                              !!value.endsWith(".jpeg")) {
                            return 'Please check image extention';
                          }
                          return null;
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

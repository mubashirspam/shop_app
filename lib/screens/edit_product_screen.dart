import 'package:flutter/material.dart';

class EditproductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditproductScreenState createState() => _EditproductScreenState();
}

class _EditproductScreenState extends State<EditproductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    _priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('EditProduct'),
        ),
        body: Padding(
          padding: EdgeInsets.all(
            15,
          ),
          child: Form(
            child: ListView(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                ),
                TextFormField(
                  focusNode: _priceFocusNode,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    label: Text('Price'),
                  ),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  focusNode: _descriptionFocusNode,
                  decoration: InputDecoration(
                    label: Text('Description'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

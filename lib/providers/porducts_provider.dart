import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/type_enum/enums.dart';
import 'package:on_the_bon/type_enum/types.dart';

class Products with ChangeNotifier {
  final ProductList _productList = {};
  final Map<String, Map<String, String>> types = {};
  String _currentType = "";
  String _currentSubType = "";
  final FirebaseFirestore db = FirebaseFirestore.instance;

  List<Product> get allProducts {
    return [..._productList.values];
  }

  List<Product> get getProductWithType {
    final List<Product> productWtihType = [];
    _productList.forEach((key, value) {
      if (value.type == _currentType) {
        if (value.subType == _currentSubType) {
          productWtihType.add(value);
        }
      }
    });
    return productWtihType;
  }

  void setType(ProductsTypeEnum type) {
    if (type == ProductsTypeEnum.food) {
      _currentType = "مأكولات";
    } else if (type == ProductsTypeEnum.hotDrinks) {
      _currentType = "مشروبات ساخنة";
    } else if (type == ProductsTypeEnum.coldDrinks) {
      _currentType = "مشروبات باردة";
    }
    _currentSubType = types[_currentType]!.values.first;
    notifyListeners();
  }

  String get getCurrentType {
    return _currentType;
  }

  String get currentSubType {
    return _currentSubType;
  }

  void setSubYype(String subtype) {
    _currentSubType = subtype;
    notifyListeners();
  }

  List<String> get getSupTypes {
    return types[_currentType]!.values.toList();
  }

  Product? fetchProductByTypeAndId({required String id}) {
    return _productList[id];
  }

  // applay opreation on database

  Future createNewProduct(Product newProduct, File image) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("products_image")
          .child("${DateTime.now()}.png");

      await ref.putFile(image);
      final url = await ref.getDownloadURL();

      final productId = await db.collection("products").add({
        "title": newProduct.title,
        "discription": newProduct.discription,
        "sizePrice": newProduct.sizePrice,
        "imageUrl": url,
        "type": newProduct.type,
        "subType": newProduct.subType,
      });

      _productList[productId.id] = Product(
          id: productId.id,
          title: newProduct.title,
          discription: newProduct.discription,
          sizePrice: newProduct.sizePrice,
          type: newProduct.type,
          subType: newProduct.subType,
          imageUrl: url);
      types[newProduct.type]!
          .putIfAbsent(newProduct.subType, () => newProduct.subType);
      notifyListeners();

      return {'id': newProduct.id, "type": newProduct.type};
    } catch (e) {
      rethrow;
    }
  }

  Future editProduct({required Product product, required File image}) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child("products_image")
          .child("${DateTime.now()}.png");

      String url = product.imageUrl;

      if (image.path != "") {
        await ref.putFile(image);
        await FirebaseStorage.instance.refFromURL(url).delete();

        url = await ref.getDownloadURL();
      }

      final productId = await db.collection("products").doc(product.id).set({
        "title": product.title,
        "discription": product.discription,
        "type": product.type,
        "subType": product.subType,
        "sizePrice": product.sizePrice,
        "imageUrl": url,
      });

      _productList[product.id] = Product(
        id: product.id,
        title: product.title,
        discription: product.discription,
        type: product.type,
        subType: product.subType,
        sizePrice: product.sizePrice,
        imageUrl: url,
      );
      types[product.type]!.putIfAbsent(product.subType, () => product.subType);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future deleteProductById(Product product) async {
    try {
      await FirebaseStorage.instance.refFromURL(product.imageUrl).delete();

      await db.collection("products").doc(product.id).delete();

      _productList.remove(product.id);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future fetchProductAsync() async {
    final productsList = await db.collection("products").get();

    productsList.docs.toList().forEach(
      (element) {
        final Map<String, double> sizePrice = {...element.data()["sizePrice"]};

        final product = Product(
            id: element.id,
            title: element.data()["title"],
            discription: element.data()["discription"],
            sizePrice: sizePrice,
            type: element.data()["type"],
            subType: element.data()["subType"],
            imageUrl: element.data()["imageUrl"]);

        types.putIfAbsent(product.type, () => {});

        types[product.type]!
            .putIfAbsent(product.subType, () => product.subType);

        _productList.putIfAbsent(product.id, () => product);
      },
    );
    notifyListeners();
  }
}

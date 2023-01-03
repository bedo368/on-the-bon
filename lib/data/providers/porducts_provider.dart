import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/data/providers/product.dart';
import 'package:on_the_bon/type_enum/types.dart';

class Products with ChangeNotifier {
  final ProductList _productList = {};
  final Map<String, Map<String, String>> types = {};
  String _currentType = "";
  String _currentSubType = "";
  final userFavoriteId = {};
  final Map<String, Product> _userFavorite = {};
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

  void clearProducts() {
    _productList.clear();
    _userFavorite.clear();
    userFavoriteId.clear();
  }

  void updateUserFavoriteForProducts(String id) {
    if (userFavoriteId.containsKey(id)) {
      userFavoriteId.remove(id);
      _userFavorite.remove(id);
    } else if (!userFavoriteId.containsKey(id)) {
      if (_productList.containsKey(id)) {
        userFavoriteId.putIfAbsent(id, () => _productList[id]);

        _userFavorite.putIfAbsent(id, () => _productList[id]!);
      }
    }
    notifyListeners();
  }

  List<Product> get getFavProducts {
    if (_userFavorite.values.isNotEmpty && _productList.isNotEmpty) {
      return [
        ..._userFavorite.values.where((e) => _productList.containsKey(e.id))
      ];
    }
    return [];
  }

  void setType(String type) {
    _currentType = type;
    _currentSubType = types[type]!.values.first;

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
    if (_currentType == "") {
      _currentType = types.keys.first;
    }
    if (!types.containsKey(_currentType)) {
      _currentSubType = types[_currentType]!.values.first;

      notifyListeners();
      return [];
    }
    return types[_currentType]!.values.toList();
  }

  Product fetchProductById({required String id}) {
    return _productList[id]!;
  }

  // applay opreation on database
  Future getUserFavoriteAsync() async {
    Future<void> isProductLoded() async {
      await Future.delayed(const Duration(seconds: 1));
      if (_productList.isEmpty) {
        await fetchProductAsync();
        await isProductLoded();
      }
      return;
    }

    userFavoriteId.clear();
    _userFavorite.clear();
    final user = await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    await isProductLoded();

    if (user.data()!.keys.contains("faivorites")) {
      for (var element in (user.data()!["faivorites"] as List)) {
        userFavoriteId.putIfAbsent(element, () => element);
        if (_productList.containsKey(element)) {
          _productList[element]!.isFav = true;
          _userFavorite.putIfAbsent(element, () => _productList[element]!);
        }
      }
    }
    notifyListeners();
  }

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
        "reviews": 5
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

      await db.collection("products").doc(product.id).update({
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

      // int numOfSubtype = 0;
      // for (Product p in _productList.values) {
      //   if (p.type == previousType) {
      //     if (p.subType == previousSubType) {
      //       numOfSubtype += 1;
      //     }
      //   }
      // }
      // if (numOfSubtype == 0) {
      //   if (types[previousType]!.containsKey(previousSubType)) {
      //     types[previousType]!.remove(previousSubType);
      //   }
      // }

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future fetchProductAsync() async {
    try {
      _productList.clear();
      final productsList = await db.collection("products").get();
      final user = await db
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (user.data()!.keys.contains("faivorites")) {
        for (var element in (user.data()!["faivorites"] as List)) {
          userFavoriteId.putIfAbsent(element, () => element);
        }
      }

      productsList.docs.toList().forEach(
        (element) {
          final Map<String, double> sizePrice = {
            ...element.data()["sizePrice"]
          };

          final product = Product(
              id: element.id,
              title: element.data()["title"],
              discription: element.data()["discription"],
              sizePrice: sizePrice,
              type: element.data()["type"],
              subType: element.data()["subType"],
              imageUrl: element.data()["imageUrl"],
              isFav: userFavoriteId.containsKey(element.id) ? true : false);
          if (product.isFav) {
            _userFavorite.putIfAbsent(element.id, () => product);
          }

          types.putIfAbsent(product.type, () => {});

          types[product.type]!
              .putIfAbsent(product.subType, () => product.subType);

          _productList.putIfAbsent(product.id, () => product);
        },
      );
      notifyListeners();
    } catch (e) {
      return;
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
}

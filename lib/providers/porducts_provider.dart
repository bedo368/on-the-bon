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

        if (_currentType.isEmpty) {
          _currentType = product.type;
          _currentSubType = product.subType;
        }
        if (_productList.containsKey(product.type)) {
          _productList[product.type]![product.id] = product;
          types[product.type]!
              .putIfAbsent(product.subType, () => product.subType);
        }
        if (!_productList.containsKey(product.type)) {
          _productList[product.type] = {};
          types[product.type] = {};
          types[product.type]!
              .putIfAbsent(product.subType, () => product.subType);
          _productList[product.type]![product.id] = product;
        }
      },
    );
    notifyListeners();
  }

  List<Product> get allProducts {
    final List<Product> allProduct = [];
    _productList.forEach((key, value) {
      value.forEach((key1, value1) {
        allProduct.add(value1);
      });
    });
    return allProduct;
  }

  List<Product> get getProductWithType {
    final List<Product> products = [];

    if (!_productList.containsKey(_currentType)) {
      print("not exist");
      return [];
    }

    if (_productList[_currentType] == null) {
      return [];
    }

    for (var e in _productList[_currentType]!.values) {
      if (e.subType == _currentSubType) {
        products.add(e);
      }
    }

    return products;
  }

  void setType(ProductsTypeEnum type) {
    if (type == ProductsTypeEnum.food) {
      _currentType = "مأكولات";
    } else if (type == ProductsTypeEnum.hotDrinks) {
      _currentType = "مشروبات ساخنة";
    } else if (type == ProductsTypeEnum.coldDrinks) {
      _currentType = "مشروبات باردة";
    }
    if (!_productList.containsKey(_currentType)) {
      notifyListeners();

      return;
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
    if (!_productList.containsKey(_currentType)) {
      return [];
    }
    return types[_currentType]!.values.toList();
  }

  Product fetchProductByTypeAndId({required String type, required String id}) {
    if (_productList.containsKey(type)) {
      if (_productList[type]!.containsKey(id)) {
        return _productList[type]![id] as Product;
      }
    }

    return const Product(
        discription: '',
        id: '',
        imageUrl: '',
        sizePrice: {},
        subType: '',
        title: '',
        type: '');
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
      });

      _productList[newProduct.type]![productId.id] = Product(
          id: productId.id,
          title: newProduct.title,
          discription: newProduct.discription,
          sizePrice: newProduct.sizePrice,
          type: newProduct.type,
          subType: newProduct.subType,
          imageUrl: url);
    } catch (e) {
      rethrow;
    }
  }
}

final Map<String, Product> tempData = {
  "234fjk3s": const Product(
      discription: 'قهوه تركي حوار فشخ اوعي تشتريها من عندنا ',
      id: '234fjk3s',
      imageUrl:
          'https://images.deliveryhero.io/image/talabat/Menuitems/indianstyleburger1957599h637816616689807830.jpeg',
      sizePrice: {"وسط": 10, "كبير": 18, "صغير": 6},
      subType: 'قهوه',
      title: 'عصير ليمون',
      type: 'مشروبات ساخنة'),
  "ddfdfsa": const Product(
      discription: 'قهوه تركي حوار فشخ اوعي تشتريها من عندنا ',
      id: 'ddfdfsa',
      imageUrl: 'https://i.im.ge/2022/08/28/ONRPlD.pngwing-com.png',
      sizePrice: {"وسط": 10},
      subType: 'شاي',
      title: 'شاي فتلة',
      type: 'مشروبات ساخنة'),
  "dsadsadas": const Product(
      discription: 'عصير ليمون طازج طبيعي 100 % مع استخدام اعلي الخامات',
      id: 'dsadsadas',
      imageUrl:
          'https://www.burger21.com/wp-content/uploads/2021/07/Spicy-Thai-Shrimp7.28.21.jpg',
      sizePrice: {"وسط": 10, "كبير": 18},
      subType: 'عصائر',
      title: 'عصير مانجا',
      type: 'مشروبات باردة'),
  "65465465646546": const Product(
      discription: 'عصير ليمون طازج طبيعي 100 % مع استخدام اعلي الخامات',
      id: '65465465646546',
      imageUrl:
          'https://i.im.ge/2022/08/28/ONRxCP.Pngtreea-cup-of-black-coffee-4983144.png',
      sizePrice: {"وسط": 10},
      subType: 'شاي',
      title: 'عصير عنب',
      type: 'مشروبات باردة'),
  "sdafsadf": const Product(
      discription: 'عصير ليمون طازج طبيعي 100 % مع استخدام اعلي الخامات',
      id: 'sdafsadf',
      imageUrl: 'https://i.im.ge/2022/09/01/O3rORp.kindpng-2972113.png',
      sizePrice: {"وسط": 10, "كبير": 18},
      subType: 'عصائر',
      title: 'عصير مانجا',
      type: 'مشروبات باردة'),
  "dfsafds": const Product(
      discription: 'عصير ليمون طازج طبيعي 100 % مع استخدام اعلي الخامات',
      id: 'dfsafds',
      imageUrl:
          'https://i.im.ge/2022/08/28/ONRxCP.Pngtreea-cup-of-black-coffee-4983144.png',
      sizePrice: {"وسط": 10},
      subType: 'شاي',
      title: 'عصير عنب',
      type: 'مأكولات'),
};

import 'package:flutter/cupertino.dart';
import 'package:on_the_bon/models/product.dart';
import 'package:on_the_bon/type_enum/types.dart';

class Products with ChangeNotifier {
  final ProductList _productList = {...tempData};

  ProductListForAppUse get allProducts {
    final ProductListForAppUse allProduct = {};
    _productList.forEach((key, value) {
      value.forEach((key1, value1) {
        allProduct[key1] = value1;
      });
    });
    return allProduct;
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
}

final tempData = {
  "مشروبات ساخنة": {
    "234fjk3s": const Product(
        discription: 'قهوه تركي حوار فشخ اوعي تشتريها من عندنا ',
        id: '234fjk3s',
        imageUrl:
            'https://images.deliveryhero.io/image/talabat/Menuitems/indianstyleburger1957599h637816616689807830.jpeg',
        sizePrice: {"وسط": 10, "كبير": 18 , "صغير":6},
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
  },
  "مشروبات باردة": {
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
        type: 'مشروبات باردة'),
  }
};

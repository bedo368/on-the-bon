enum ProductSize { meduim, large }

enum OrderType {
  successfulOrder,
  orderInProgress,
  rejectedOrder,
}

enum ProductsType { food, hotDrinks, coldDrinks }

final Map<String, ProductsType> productsTypeToString = {
  "مأكولات": ProductsType.food,
  "مشروبات باردة": ProductsType.coldDrinks,
  "مشروبات ساخنة": ProductsType.hotDrinks,
};

final Map<ProductsType, String> productstringToproductsType = {
  ProductsType.food: "مأكولات",
  ProductsType.hotDrinks: "مشروبات ساخنة",
  ProductsType.coldDrinks: "مشروبات باردة"
};

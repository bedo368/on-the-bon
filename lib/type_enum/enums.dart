enum OrderTypeEnum {
  successfulOrder,
  orderInProgress,
  rejectedOrder,
}

enum ProductsTypeEnum { food, hotDrinks, coldDrinks }

final Map<String, ProductsTypeEnum> productsStringToType = {
  "مأكولات": ProductsTypeEnum.food,
  "مشروبات باردة": ProductsTypeEnum.coldDrinks,
  "مشروبات ساخنة": ProductsTypeEnum.hotDrinks,
};

final Map<ProductsTypeEnum, String> productsTypeToString = {
  ProductsTypeEnum.food: "مأكولات",
  ProductsTypeEnum.hotDrinks: "مشروبات ساخنة",
  ProductsTypeEnum.coldDrinks: "مشروبات باردة"
};

enum ProductSizeEnum { meduim, large, small }

final productSizeEnumToString = {
  "meduim": ProductSizeEnum.meduim,
  "large": ProductSizeEnum.large,
  "small": ProductSizeEnum.small
};

final productSizeStringtoEnum = {
  ProductSizeEnum.meduim: "meduim",
  ProductSizeEnum.large: "large",
  ProductSizeEnum.small: "small"
};

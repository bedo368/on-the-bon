enum OrderTypeEnum {
  successfulOrder,
  orderInProgres,
  rejectedOrder,
}

final Map<String, OrderTypeEnum> orderTypeStringToEnum = {
  "الطلبات الحالية": OrderTypeEnum.orderInProgres,
  "الطلبات الناجحة": OrderTypeEnum.successfulOrder,
  "الطلبات المروفضه": OrderTypeEnum.rejectedOrder,
};

final Map<OrderTypeEnum, String> orderTypeEnumToString= {
  OrderTypeEnum.orderInProgres: "الطلبات الحالية",
  OrderTypeEnum.successfulOrder: "الطلبات الناجحة",
  OrderTypeEnum.rejectedOrder: "الطلبات المروفضه",
};

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

enum ProductSizeEnum { small, large, meduim }

final productSizeEnumToString = {
  "وسط": ProductSizeEnum.small,
  "كبير": ProductSizeEnum.large,
  "صغير": ProductSizeEnum.meduim
};

final productSizeStringtoEnum = {
  ProductSizeEnum.small: "صغير",
  ProductSizeEnum.meduim: "وسط",
  ProductSizeEnum.large: "كبير",
};

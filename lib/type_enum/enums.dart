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

final Map<OrderTypeEnum, String> orderTypeEnumToString = {
  OrderTypeEnum.orderInProgres: "الطلبات الحالية",
  OrderTypeEnum.successfulOrder: "الطلبات الناجحة",
  OrderTypeEnum.rejectedOrder: "الطلبات المروفضه",
};

enum ProductsTypeEnum { food, Drinks, sweat, IceCream }

final Map<String, ProductsTypeEnum> productsStringToType = {
  "☕ مشروبات": ProductsTypeEnum.Drinks,
  "🍔 مأكولات": ProductsTypeEnum.food,
  "🧁 ديزيرت": ProductsTypeEnum.sweat,
  "🍨 ايس كريم": ProductsTypeEnum.IceCream,
};

final Map<ProductsTypeEnum, String> productsTypeToString = {
  ProductsTypeEnum.Drinks: "☕ مشروبات",
  ProductsTypeEnum.food: "🍔 مأكولات",
  ProductsTypeEnum.sweat: "🧁 ديزيرت",
  ProductsTypeEnum.IceCream: "🍨 ايس كريم",
};

enum ProductSizeEnum { small, large, meduim , normal , spitial  }

final productSizeEnumToString = {
  "وسط": ProductSizeEnum.small,
  "كبير": ProductSizeEnum.large,
  "صغير": ProductSizeEnum.meduim,
  "Normal":ProductSizeEnum.normal ,
  "Spitial":ProductSizeEnum.spitial
};

final productSizeStringtoEnum = {
  ProductSizeEnum.small: "صغير",
  ProductSizeEnum.meduim: "وسط",
  ProductSizeEnum.large: "كبير",
};

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CartDataBase {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, "CART.DB"), onCreate: (db, version) async {
      await db.execute(
        """
        CREATE TABLE CARTCONTENT(
      id  INTERGER PRIMERY KEY AUTOINCREMENT,
      productId TEXT NOT NULL ,
      title TEXT NOT NULL ,
      price INTERGER NOT NULL ,
      imageUrl TEXT NOT NULL ,
      size TEXT NOT NULL ,

      
        )
        """);
    }, version: 1);
  }
}

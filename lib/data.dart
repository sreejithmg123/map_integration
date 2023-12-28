import 'package:drift/drift.dart';


class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
}

class Details extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get productId => integer().references(Products, #id)();
}

class Customer extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get mobileNumber => integer()();
}

abstract class ProductsView extends View {
  Products get products;
  @override
  Query as() => select([products.title]).from(products);
}

@DriftDatabase(tables: [Products], views: [ProductsView])
class Database {
  Database(QueryExecutor e) : super();
  @override
  int get schemaVersion => 2;
}


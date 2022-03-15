class Item {
  final String name;
  final double price;
  final int quantity;
  Item({this.name, this.price, this.quantity});

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    return Item(
      name: parsedJson['name'],
      price: double.parse(parsedJson['price']),
      quantity: int.parse(parsedJson['quantity']),
    );
  }

  @override
  bool operator ==(dynamic other) =>
      name == other.name && price == other.price && quantity == other.quantity;

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ quantity.hashCode;
}

class Bill {
  final double total;
  final List<Item> items;
  Bill({this.total, this.items});

  @override
  bool operator ==(dynamic other) =>
      total == other.total && items == other.items;

  @override
  int get hashCode => total.hashCode ^ items.hashCode;

  factory Bill.fromJson(Map<String, dynamic> parsedJson) {
    List<dynamic> list = parsedJson['items'];
    return Bill(
        total: double.parse(parsedJson["total"].toString()),
        items: list.map((i) => Item.fromJson(i)).toList());
  }
}

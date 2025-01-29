import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class CartProduct extends HiveObject {
  @HiveField(0)
  final String imagePath;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String quantityLabel;

  @HiveField(3)
  final int price;

  @HiveField(4)
  int quantity;

  CartProduct({
    required this.imagePath,
    required this.title,
    required this.quantityLabel,
    required this.price,
    required this.quantity,
  });
}

class CartService {
  static const String _boxName = 'cart';
  late Box<CartProduct> _cartBox;
  List<CartProduct> _items = [];

  List<CartProduct> get items => _items;

  // Initialize Hive and open the box
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartProductAdapter());
    await Hive.openBox<CartProduct>(_boxName);
  }

  Future<void> loadCart() async {
    _cartBox = await Hive.openBox<CartProduct>(_boxName);
    _items = _cartBox.values.toList();
  }

  Future<void> addItem(CartProduct item) async {
    try {
      final existingItemIndex = _items.indexWhere((i) => i.title == item.title);

      if (existingItemIndex != -1) {
        _items[existingItemIndex].quantity += item.quantity;
        await _cartBox.put(item.title, _items[existingItemIndex]);
      } else {
        await _cartBox.put(item.title, item);
        _items.add(item);
      }
    } catch (e) {
      print('Error adding item to cart: $e');
      rethrow;
    }
  }

  Future<void> removeItem(String title) async {
    try {
      await _cartBox.delete(title);
      _items.removeWhere((item) => item.title == title);
    } catch (e) {
      print('Error removing item from cart: $e');
      rethrow;
    }
  }

  Future<void> updateQuantity(String title, int quantity) async {
    try {
      final item = _items.firstWhere((item) => item.title == title);
      item.quantity = quantity;
      await _cartBox.put(title, item);
    } catch (e) {
      print('Error updating quantity: $e');
      rethrow;
    }
  }

  double get total => _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  Future<void> clearCart() async {
    try {
      await _cartBox.clear();
      _items.clear();
    } catch (e) {
      print('Error clearing cart: $e');
      rethrow;
    }
  }
}

// Generate this class using build_runner
@HiveType(typeId: 0)
class CartProductAdapter extends TypeAdapter<CartProduct> {
  @override
  final typeId = 0;

  @override
  CartProduct read(BinaryReader reader) {
    return CartProduct(
      imagePath: reader.read(),
      title: reader.read(),
      quantityLabel: reader.read(),
      price: reader.read(),
      quantity: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, CartProduct obj) {
    writer.write(obj.imagePath);
    writer.write(obj.title);
    writer.write(obj.quantityLabel);
    writer.write(obj.price);
    writer.write(obj.quantity);
  }
}
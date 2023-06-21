class Violent {
  final String id;
  final String name;
  final String description;
  final int price;
  Violent({required this.id, required this.name, required this.description, required this.price});

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) {
    if(other is Violent) {
      return other.id == id;
    }
    return false;
  }
}
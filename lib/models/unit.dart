class Unit {
  final String name;
  final String symbol;
  final double conversion;
  final bool isFormula;

  Unit({
    required this.name,
    required this.symbol,
    required this.conversion,
    this.isFormula = false,
  });

  @override
  bool operator ==(Object other) {
    return other is Unit &&
        name == other.name &&
        symbol == other.symbol;
  }

  @override
  int get hashCode => name.hashCode ^ symbol.hashCode;

  @override
  String toString() => '$name ($symbol)';
}

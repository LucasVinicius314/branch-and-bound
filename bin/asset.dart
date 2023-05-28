class Asset {
  const Asset({
    required this.weight,
    required this.value,
  });

  final int weight;
  final int value;

  double get getValuePerWeight => value / weight;

  @override
  String toString() {
    return 'weight: $weight, value: $value, value per weight: $getValuePerWeight';
  }
}

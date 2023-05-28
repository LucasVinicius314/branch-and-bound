import 'asset.dart';

final maxWeight = 10;

final assets = [
  Asset(weight: 6, value: 26),
  Asset(weight: 5, value: 25),
  Asset(weight: 4, value: 40),
  Asset(weight: 7, value: 42),
  // Asset(weight: 3, value: 12),
  // Asset(weight: 5, value: 25),
  // Asset(weight: 4, value: 40),
  // Asset(weight: 7, value: 42),
];

int max = 0;
final knapsack = <Asset>[];

void main(List<String> arguments) {
  assets.sort(
    (a, b) => (b.getValuePerWeight - a.getValuePerWeight).sign.toInt(),
  );

  solve(
    asset: assets[0],
    currentWeight: 0,
    currentValue: 0,
    upperBound: 0,
  );

  print(max);
}

void solve({
  required Asset? asset,
  required int currentWeight,
  required int currentValue,
  required double upperBound,
}) {
  // If the item to be verified is out of range, return.
  if (asset == null) {
    // And if the current value is greater than the global max, update it.
    if (currentValue > max) {
      max = currentValue;
    }

    return;
  }

  // Define the remaining weight in the knapsack.
  final remainingWeight = maxWeight - currentWeight;

  // If the current asset still fits in the knapsack.
  if (currentWeight + asset.weight <= maxWeight) {
    // Add the asset to the knapsack.
    knapsack.add(asset);

    // Define the upper bound as:
    // the current value in the knapsack +
    // the value of the asset +
    // the remaining space * the asset's value per weight.
    upperBound = currentValue +
        asset.value +
        (remainingWeight - asset.weight) * asset.getValuePerWeight;

    // If the upper bound is greater then the global max.
    if (upperBound > max) {
      // Call it again recursively with the next asset, and the new weight and
      // value with the asset.

      final indexOf = assets.indexOf(asset);

      solve(
        asset: indexOf == assets.length - 1 ? null : assets[indexOf + 1],
        currentWeight: currentWeight + asset.weight,
        currentValue: currentValue + asset.value,
        upperBound: upperBound,
      );
    }

    // Remove the asset from the knapsack.
    knapsack.remove(asset);
  }

  // Define the new upper bound as:
  // the current value in the knapsack +
  // the remaining weight * the asset's value per weight.
  upperBound = currentValue + remainingWeight * asset.getValuePerWeight;

  // If the new upper bound is greater than the global max.
  if (upperBound > max) {
    // Call it again recursively with the next asset, and just the current value
    // and weight.

    final indexOf = assets.indexOf(asset);

    solve(
      asset: indexOf == assets.length - 1 ? null : assets[indexOf + 1],
      currentWeight: currentWeight,
      currentValue: currentValue,
      upperBound: upperBound,
    );
  }
}

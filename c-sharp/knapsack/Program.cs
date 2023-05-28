public struct Item
{
  public float weight;
  public int value;
}

public struct Node
{
  public int level;
  public int profit;
  public int bound;
  public float weight;
}

public class Knapsack
{
  public static int Bound(Node node, int itemCount, int maxWeight, Item[] items)
  {
    // Para se o peso do node for mais doq a mochila sozinha tanka.
    if (node.weight >= maxWeight)
      return 0;

    // Upper bound.
    int profitBound = node.profit;
    int itemIndex = node.level + 1;
    int totWeight = (int)node.weight;

    // Se o índice do item é válido e o item cabe na mochila atual.
    while (itemIndex < itemCount && totWeight + (int)items[itemIndex].weight <= maxWeight)
    {
      // Soma o peso do item.
      totWeight += (int)items[itemIndex].weight;
      // Soma o valor do item.
      profitBound += items[itemIndex].value;
      itemIndex++;
    }

    if (itemIndex < itemCount)
      profitBound += (int)((maxWeight - totWeight) * items[itemIndex].value / items[itemIndex].weight);

    return profitBound;
  }

  public static int KnapsackSolution(int maxWeight, Item[] items, int itemCount)
  {
    Array.Sort<Item>(items, (Item a, Item b) =>
      {
        double r1 = (double)a.value / a.weight;
        double r2 = (double)b.value / b.weight;
        return r1 > r2 ? 1 : 0;
      });

    var queue = new Queue<Node>();

    var currentNode = new Node();
    var nextNode = new Node();

    int maxProfit = 0;

    currentNode.level = -1;
    currentNode.profit = 0;
    currentNode.weight = 0;

    queue.Enqueue(currentNode);

    while (queue.Count > 0)
    {
      currentNode = queue.Dequeue();

      // Seta o índice do node pra 0 caso ele seja -1.
      if (currentNode.level == -1)
        nextNode.level = 0;

      // Skippa o ciclo caso o índice do node atual seja o último.
      if (currentNode.level == itemCount - 1)
        continue;

      // Faz o next node ser o próximo node.
      nextNode.level = currentNode.level + 1;
      nextNode.weight = currentNode.weight + items[nextNode.level].weight;
      nextNode.profit = currentNode.profit + items[nextNode.level].value;

      // Se a mochila tanka o peso do item e o upper bound do próximo é maior doq
      // o máximo já encontrado, atualiza o máximo.
      if (nextNode.weight <= maxWeight && nextNode.profit > maxProfit)
        maxProfit = nextNode.profit;

      nextNode.bound = Bound(nextNode, itemCount, maxWeight, items);

      if (nextNode.bound > maxProfit)
        queue.Enqueue(nextNode);

      nextNode.weight = currentNode.weight;
      nextNode.profit = currentNode.profit;
      nextNode.bound = Bound(nextNode, itemCount, maxWeight, items);

      if (nextNode.bound > maxProfit)
        queue.Enqueue(nextNode);
    }

    return maxProfit;
  }

  public static void Main(string[] args)
  {
    int maxWeight = 10;

    Item[] items = new Item[4] {
      new Item { weight = 4, value = 40 },
      new Item { weight = 7, value = 42 },
      new Item { weight = 5, value = 25 },
      new Item { weight = 6, value = 26 },
    };

    // Item[] arr = new Item[4] {
    //   new Item { weight = 4, value = 40 },
    //   new Item { weight = 7, value = 42 },
    //   new Item { weight = 5, value = 25 },
    //   new Item { weight = 3, value = 12 },
    // };

    int itemCount = items.Length;

    Console.WriteLine("Maximum possible profit = {0}", KnapsackSolution(maxWeight, items, itemCount));
  }
}
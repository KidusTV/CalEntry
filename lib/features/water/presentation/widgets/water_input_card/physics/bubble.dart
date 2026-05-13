/// Repräsentiert eine einzelne Blase im Wasser-Widget.
class Bubble {
  final double x;    // 0..1 relativ zur Kreisbreite
  double life;       // 0..1, wird pro Frame erhöht
  final double size; // Radius in Pixeln

  Bubble({
    required this.x,
    required this.life,
    required this.size,
  });
}
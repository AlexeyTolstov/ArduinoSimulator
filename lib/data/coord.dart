class Coordination {
  final double x;
  final double y;
  
  @override
  String toString() => "X: $x Y: $y";

  bool operator >(covariant Coordination other) {
    return x > other.x;
  }

  bool operator <(covariant Coordination other) {
    return x < other.x;
  }

  const Coordination({
    required this.x,
    required this.y
  });
}
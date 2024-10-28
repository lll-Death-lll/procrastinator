enum Urgency {
  high,
  medium,
  low;

  @override
  String toString() => name;
}

extension StringToEnum on String {
  Urgency toUrgency() {
    switch (toLowerCase()) {
      case 'high':
        return Urgency.high;
      case 'medium':
        return Urgency.medium;
      case 'low':
        return Urgency.low;
      default:
        throw ArgumentError('Invalid Urgency value: $this');
    }
  }
}

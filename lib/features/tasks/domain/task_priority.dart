enum Priority {
  high,
  medium,
  low;

  @override
  String toString() => name;
}

extension Utils on Priority {
  int toInt() {
    return Priority.values.indexOf(this);
  }

  int compareTo(Priority priority) {
    return toInt() - priority.toInt();
  }
}

extension StringToEnum on String {
  Priority toPriority() {
    switch (toLowerCase()) {
      case 'high':
        return Priority.high;
      case 'medium':
        return Priority.medium;
      case 'low':
        return Priority.low;
      default:
        throw ArgumentError('Invalid Priority value: $this');
    }
  }
}

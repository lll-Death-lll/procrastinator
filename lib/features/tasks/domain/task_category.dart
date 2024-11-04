enum Category {
  home,
  work,
  learning,
  other;

  @override
  String toString() => name;
}

extension Utils on Category {
  int toInt() {
    return Category.values.indexOf(this);
  }

  int compareTo(Category category) {
    return toInt() - category.toInt();
  }
}

extension StringToEnum on String {
  Category toCategory() {
    switch (toLowerCase()) {
      case 'home':
        return Category.home;
      case 'work':
        return Category.work;
      case 'learning':
        return Category.learning;
      case 'other':
        return Category.other;
      default:
        throw ArgumentError('Invalid Category value: $this');
    }
  }
}

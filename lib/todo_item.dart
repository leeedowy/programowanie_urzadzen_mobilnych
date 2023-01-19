class TodoItem {
  String title;
  String description;
  bool? isCompleted;
  int index;

  TodoItem({
    this.title = "",
    this.description = "",
    this.isCompleted = false,
    this.index = -1,
  });

  @override
  String toString() {
    return "${title}: ${description}";
  }
}

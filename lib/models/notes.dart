class Note {
  final int id;
  final String title;
  final String content;
  final bool isSelected;
  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.isSelected});

  // Convert the Note instance to a map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'isSelected': isSelected
    };
  }

  // Create a Note instance from a map retrieved from storage
  static Note fromMap(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        isSelected: map['isSelected']);
  }
}

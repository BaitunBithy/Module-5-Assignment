import 'package:flutter/foundation.dart';
import '../models/subject.dart';

class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => List.unmodifiable(_subjects);

  int get totalSubjects => _subjects.length;

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  /// Removes a subject by its stable [Subject.id]. This keeps deletion
  /// resilient to indices shifting after other items are removed.
  void removeSubjectById(String id) {
    final initialLength = _subjects.length;
    _subjects.removeWhere((subject) => subject.id == id);
    if (_subjects.length != initialLength) {
      notifyListeners();
    }
  }

  // Requirement: use .where() to filter passing subjects (grade != F)
  List<Subject> get passingSubjects =>
      _subjects.where((subject) => subject.grade != 'F').toList();

  // Requirement: use .map() to pull out marks for averaging
  double get averageMark {
    if (_subjects.isEmpty) return 0;
    final marks = _subjects.map((subject) => subject.mark);
    final total = marks.reduce((a, b) => a + b);
    return total / _subjects.length;
  }

  String get overallGrade {
    if (_subjects.isEmpty) return '-';
    final avg = averageMark;
    if (avg >= 80) return 'A';
    if (avg >= 65) return 'B';
    if (avg >= 50) return 'C';
    return 'F';
  }
}

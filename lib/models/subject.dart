/// Immutable subject model. The mark is private so callers must go through
/// the [mark] getter, and the grade is computed from the mark via [grade].
class Subject {
  /// Stable unique identifier used by widgets that need a key (e.g. Dismissible).
  final String id;
  final String name;
  final double _mark;

  Subject({required this.name, required double mark})
      : id = '${DateTime.now().microsecondsSinceEpoch}_$name',
        // ignore: prefer_initializing_formals
        _mark = mark;

  double get mark => _mark;

  /// Grade rules:
  /// A: mark >= 80
  /// B: mark >= 65
  /// C: mark >= 50
  /// F: below 50
  String get grade {
    if (_mark >= 80) return 'A';
    if (_mark >= 65) return 'B';
    if (_mark >= 50) return 'C';
    return 'F';
  }
}
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app_1/models/subject.dart';
import 'package:flutter_app_1/providers/subject_provider.dart';

void main() {
  group('Subject.grade', () {
    test('returns A for mark >= 80', () {
      expect(Subject(name: 'Maths', mark: 80).grade, 'A');
      expect(Subject(name: 'Maths', mark: 100).grade, 'A');
    });

    test('returns B for mark >= 65 and < 80', () {
      expect(Subject(name: 'Maths', mark: 65).grade, 'B');
      expect(Subject(name: 'Maths', mark: 79.9).grade, 'B');
    });

    test('returns C for mark >= 50 and < 65', () {
      expect(Subject(name: 'Maths', mark: 50).grade, 'C');
      expect(Subject(name: 'Maths', mark: 64.9).grade, 'C');
    });

    test('returns F for mark < 50', () {
      expect(Subject(name: 'Maths', mark: 0).grade, 'F');
      expect(Subject(name: 'Maths', mark: 49.9).grade, 'F');
    });

    test('mark getter exposes the private field', () {
      final s = Subject(name: 'Bio', mark: 73);
      expect(s.mark, 73);
    });
  });

  group('SubjectProvider', () {
    test('starts empty with zero totals', () {
      final p = SubjectProvider();
      expect(p.subjects, isEmpty);
      expect(p.totalSubjects, 0);
      expect(p.passingSubjects, isEmpty);
      expect(p.averageMark, 0);
      expect(p.overallGrade, '-');
    });

    test('addSubject + removeSubjectById update the list', () {
      final p = SubjectProvider();
      final s = Subject(name: 'Maths', mark: 80);
      p.addSubject(s);
      expect(p.totalSubjects, 1);

      p.removeSubjectById(s.id);
      expect(p.totalSubjects, 0);
    });

    test('averageMark and overallGrade react to additions', () {
      final p = SubjectProvider();
      p.addSubject(Subject(name: 'Maths', mark: 90));
      p.addSubject(Subject(name: 'Bio', mark: 70));
      expect(p.averageMark, 80);
      expect(p.overallGrade, 'A');
    });

    test('passingSubjects uses .where() to exclude F grades', () {
      final p = SubjectProvider();
      p.addSubject(Subject(name: 'Pass1', mark: 80));
      p.addSubject(Subject(name: 'Fail', mark: 30));
      p.addSubject(Subject(name: 'Pass2', mark: 55));
      expect(p.passingSubjects.map((s) => s.name), ['Pass1', 'Pass2']);
    });
  });
}

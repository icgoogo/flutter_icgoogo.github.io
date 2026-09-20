import 'package:flutter_test/flutter_test.dart';
import 'package:icgoogo/models/project_model.dart';

void main() {
  test('project with a non-empty link has an external link', () {
    const project = Project(
      title: 'External',
      tapLink: ' https://example.com ',
    );

    expect(project.hasExternalLink, isTrue);
  });

  test('project without a link has no external link', () {
    const project = Project(title: 'Empty', tapLink: '  ');

    expect(project.hasExternalLink, isFalse);
  });
}

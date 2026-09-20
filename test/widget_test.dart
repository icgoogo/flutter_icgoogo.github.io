import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icgoogo/ui/components/markdown_viewer.dart';
import 'package:icgoogo/ui/main_screen.dart';

void main() {
  testWidgets(
      'project card without a link opens markdown detail in the same screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainScreen()));

    await tester.tap(find.text('Projects'));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text('Ceria by BRI'),
      find.byType(ListView),
      const Offset(0, -200),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ceria by BRI'));
    await tester.pumpAndSettle();

    expect(find.byType(MarkdownFileViewer), findsOneWidget);
    expect(find.text('Projects'), findsWidgets);
  });
}

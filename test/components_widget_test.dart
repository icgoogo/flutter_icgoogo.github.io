import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icgoogo/main.dart';
import 'package:icgoogo/ui/components/bottom_button.dart';
import 'package:icgoogo/ui/components/bottom_game.dart';
import 'package:icgoogo/ui/components/box_main.dart';
import 'package:icgoogo/ui/components/custom_button.dart';
import 'package:icgoogo/ui/components/grid_projects.dart';
import 'package:icgoogo/ui/components/markdown_viewer.dart';
import 'package:icgoogo/ui/components/projects_box.dart';
import 'package:icgoogo/ui/main_screen.dart';
import 'package:icgoogo/utils/screen_utils.dart';
import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class SuccessfulUrlLauncher extends UrlLauncherPlatform {
  final List<String> launchedUrls = [];

  @override
  Future<bool> canLaunch(String url) async => true;

  @override
  Future<bool> launch(
    String url, {
    required bool useSafariVC,
    required bool useWebView,
    required bool enableJavaScript,
    required bool enableDomStorage,
    required bool universalLinksOnly,
    required Map<String, String> headers,
    String? webOnlyWindowName,
  }) async {
    launchedUrls.add(url);
    return true;
  }

  @override
  LinkDelegate? get linkDelegate => null;
}

Widget materialHost(Widget child) {
  return MaterialApp(home: Scaffold(body: child));
}

void main() {
  testWidgets('custom button supports default and compact interactions',
      (tester) async {
    var taps = 0;
    await tester.pumpWidget(materialHost(
      Column(
        children: [
          CustomButton(
            bgColor: Colors.red,
            title: const Text('Default'),
            onTap: () => taps++,
          ),
          CustomButton(
            compact: true,
            bgColor: Colors.blue,
            title: const Text('Compact'),
            onTap: () => taps++,
          ),
        ],
      ),
    ));

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.tap(find.text('Default'));
    await tester.tap(find.text('Compact'));
    expect(taps, 2);
    expect(find.byType(CustomButton), findsNWidgets(2));
  });

  testWidgets(
      'project card uses callback and handles empty or markdown targets',
      (tester) async {
    var taps = 0;
    await tester.pumpWidget(materialHost(ProjectsBox(
      title: 'Callback',
      gifPath: 'missing.png',
      onTap: () => taps++,
    )));
    await tester.tap(find.text('Callback'));

    await tester.pumpWidget(materialHost(
      const ProjectsBox(title: 'Empty', gifPath: 'missing.png'),
    ));
    await tester.tap(find.text('Empty'));

    await tester.pumpWidget(materialHost(
      const ProjectsBox(
        title: 'Markdown',
        tapLink: 'assets/md/example.md',
        gifPath: 'missing.png',
      ),
    ));
    await tester.tap(find.text('Markdown'));
    await tester.pump();

    expect(taps, 1);
    expect(find.byIcon(Icons.code), findsOneWidget);
  });

  testWidgets('grid renders projects and forwards project selection',
      (tester) async {
    String? selectedTitle;
    await tester.pumpWidget(materialHost(
      GridProjects(onProjectTap: (project) => selectedTitle = project.title),
    ));

    expect(find.text('Ceria by BRI'), findsOneWidget);
    await tester.tap(find.text('Ceria by BRI'));
    expect(selectedTitle, 'Ceria by BRI');
  });

  testWidgets('grid uses desktop layout and external links launch',
      (tester) async {
    final launcher = SuccessfulUrlLauncher();
    final previousLauncher = UrlLauncherPlatform.instance;
    UrlLauncherPlatform.instance = launcher;
    addTearDown(() => UrlLauncherPlatform.instance = previousLauncher);

    await tester.pumpWidget(MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1300, 1300)),
        child: Scaffold(
          body: ProjectsBox(
            title: 'External',
            tapLink: 'https://example.com',
            gifPath: 'missing.png',
          ),
        ),
      ),
    ));
    await tester.tap(find.text('External'));
    await tester.pump();
    expect(launcher.launchedUrls, contains('https://example.com'));

    await tester.pumpWidget(MaterialApp(
      home: MediaQuery(
        data: const MediaQueryData(size: Size(1300, 1300)),
        child: const Scaffold(body: GridProjects()),
      ),
    ));
    expect(find.text('Ceria by BRI'), findsOneWidget);
  });

  testWidgets('app shell builds', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MainScreen), findsOneWidget);
  });

  testWidgets('home social buttons and detail navigation use launcher',
      (tester) async {
    final launcher = SuccessfulUrlLauncher();
    final previousLauncher = UrlLauncherPlatform.instance;
    UrlLauncherPlatform.instance = launcher;
    addTearDown(() => UrlLauncherPlatform.instance = previousLauncher);

    final previousSize = tester.view.physicalSize;
    final previousDpr = tester.view.devicePixelRatio;
    tester.view.physicalSize = const Size(1300, 3000);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.physicalSize = previousSize;
      tester.view.devicePixelRatio = previousDpr;
    });

    await tester.pumpWidget(const MaterialApp(home: MainScreen()));
    await tester.drag(find.byType(ListView).first, const Offset(0, -160));
    await tester.pumpAndSettle();
    for (final label in ['Stack Overflow', 'Linkedin', 'Github']) {
      await tester.scrollUntilVisible(
        find.text(label),
        200,
        scrollable: find.byType(Scrollable),
      );
      await tester.tap(find.text(label));
      await tester.pump();
    }
    expect(launcher.launchedUrls, hasLength(3));

    await tester.pumpWidget(const MaterialApp(home: MainScreen()));
    await tester.tap(find.text('Projects'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ceria by BRI'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Projects').last);
    await tester.pumpAndSettle();
    expect(find.byType(GridProjects), findsOneWidget);
  });

  testWidgets('markdown viewer renders valid and invalid asset states',
      (tester) async {
    // Clear any cached asset failures from prior tests in the suite
    rootBundle.evict('assets/md/bri_ceria.md');

    tester.binding.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (ByteData? message) async {
        if (message == null) return null;
        final String key = utf8.decode(
          message.buffer
              .asUint8List(message.offsetInBytes, message.lengthInBytes),
        );
        if (key == 'assets/md/bri_ceria.md') {
          final Uint8List bytes =
              Uint8List.fromList(utf8.encode('# BRI Ceria\nSample content'));
          return ByteData.view(bytes.buffer);
        }
        return null;
      },
    );
    addTearDown(() {
      tester.binding.defaultBinaryMessenger
          .setMockMessageHandler('flutter/assets', null);
      rootBundle.evict('assets/md/bri_ceria.md');
    });

    await tester.pumpWidget(materialHost(
      const MarkdownFileViewer(assetPath: 'assets/md/bri_ceria.md'),
    ));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.byType(MarkdownBody), findsOneWidget);

    await tester.pumpWidget(materialHost(
      const MarkdownFileViewer(assetPath: 'assets/md/missing.md'),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.textContaining('Error loading content'), findsOneWidget);
  });

  testWidgets('bottom game controls and box render', (tester) async {
    await tester.pumpWidget(materialHost(const SizedBox(
      height: 400,
      child: BottomGame(),
    )));

    expect(find.byType(BoxMain), findsOneWidget);
    expect(find.byType(BottomButton), findsNWidgets(3));
    await tester.tap(find.byIcon(Icons.keyboard_arrow_left));
    await tester.tap(find.byIcon(Icons.keyboard_arrow_right));
    await tester.tap(find.byIcon(Icons.keyboard_arrow_up));
    await tester.pump(const Duration(milliseconds: 1000));
  });

  testWidgets('bottom game responds to keyboard controls', (tester) async {
    await tester.pumpWidget(materialHost(const SizedBox(
      height: 400,
      child: BottomGame(),
    )));

    final listener = find.byType(KeyboardListener);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pump(const Duration(milliseconds: 1000));
    expect(listener, findsOneWidget);
  });

  test('screen type uses width and landscape height thresholds', () {
    MediaQueryData mediaQuery(double width, double height) {
      return MediaQueryData(size: Size(width, height));
    }

    expect(getScreenType(mediaQuery(500, 800)), ScreenType.mobile);
    expect(getScreenType(mediaQuery(700, 900)), ScreenType.tablet);
    expect(getScreenType(mediaQuery(1000, 1000)), ScreenType.desktop);
    expect(getScreenType(mediaQuery(1300, 1300)), ScreenType.desktopLarge);
    expect(
      getScreenType(mediaQuery(1300, 1250)),
      ScreenType.desktopLarge,
    );
  });

  testWidgets('box main paints at the supplied position', (tester) async {
    await tester.pumpWidget(materialHost(
      const BoxMain(playerX: 0.5, playerY: 0.25),
    ));
    expect(find.byType(BoxMain), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownFileViewer extends StatelessWidget {
  final String assetPath;

  const MarkdownFileViewer({
    super.key,
    required this.assetPath,
  });

  Future<void> _handleLinkTap(String? href) async {
    if (href == null || href.isEmpty) return;
    final Uri url = Uri.parse(href);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString(assetPath),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(color: Colors.tealAccent),
            ),
          );
        }

        if (snapshot.hasError) {
          return Text(
            "Error loading content: ${snapshot.error}",
            style: const TextStyle(color: Colors.redAccent),
          );
        }

        final theme = Theme.of(context);
        final bodyStyle = theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white.withValues(alpha: 0.82),
          fontFamily: 'Roboto',
          fontSize: 15,
          height: 1.7,
        );
        final headingStyle = theme.textTheme.titleLarge?.copyWith(
          color: Colors.tealAccent,
          fontFamily: 'PressStart2P',
          fontSize: 18,
          height: 1.5,
        );

        return MarkdownBody(
          data: snapshot.data ?? '',
          selectable: true,
          onTapLink: (text, href, title) => _handleLinkTap(href),
          styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
            p: bodyStyle,
            a: bodyStyle?.copyWith(color: Colors.lightBlueAccent),
            h1: headingStyle?.copyWith(fontSize: 24),
            h2: headingStyle?.copyWith(fontSize: 21),
            h3: headingStyle,
            h4: headingStyle?.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
            listBullet: bodyStyle?.copyWith(color: Colors.tealAccent),
            blockquote: bodyStyle?.copyWith(color: Colors.white60),
            code: const TextStyle(
              backgroundColor: Color(0xff17232b),
              color: Color(0xffa7f3d0),
              fontFamily: 'monospace',
              fontSize: 13,
              height: 1.5,
            ),
          ),
        );
      },
    );
  }
}

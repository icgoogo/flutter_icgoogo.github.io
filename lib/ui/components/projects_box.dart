import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsBox extends StatelessWidget {
  final String title;
  final String? tapLink;
  final String? gifPath;
  final VoidCallback? onTap;

  const ProjectsBox({
    super.key,
    required this.title,
    this.tapLink,
    this.gifPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasExternalLink = (tapLink ?? '').trim().isNotEmpty;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(8, 8),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            if (!hasExternalLink) {
              onTap?.call();
              return;
            }

            final url = Uri.parse(tapLink!);
            if (await canLaunchUrl(url)) {
              await launchUrl(
                url,
                webOnlyWindowName: '_blank',
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: gifPath != null
                              ? Image.asset(
                                  gifPath!,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.black12,
                                      child: const Icon(
                                        Icons.code,
                                        size: 48,
                                        color: Colors.white54,
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                        ),
                      ),
                      if (hasExternalLink)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Icon(
                              Icons.open_in_new,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                if (gifPath != null) ...[
                  const SizedBox(height: 20.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

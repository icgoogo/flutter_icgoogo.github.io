import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsBox extends StatelessWidget {
  final String title;
  final String tapLink;
  final String gifPath;

  const ProjectsBox({
    Key? key,
    required this.title,
    required this.tapLink,
    required this.gifPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Uri url = Uri.parse(tapLink);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      gifPath,
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
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

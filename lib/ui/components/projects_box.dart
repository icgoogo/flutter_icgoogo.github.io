import 'package:flutter/material.dart';
import 'package:icgoogo/const/images_path.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsBox extends StatelessWidget {
  final String title;
  final String tapLink;
  final String gifPath;
  const ProjectsBox({
    super.key,
    required this.title,
    required this.tapLink,
    required this.gifPath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            constraints: const BoxConstraints(
              minHeight: 400,
              maxWidth: 400,
              maxHeight: 400,
            ),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(10, 10),
                ),
              ],
            ),
            child: Material(
              color: Colors.grey,
              child: InkWell(
                onTap: () {
                  launchUrl(Uri.parse(tapLink));
                },
                child: Center(
                  child: Image.asset(
                    gifPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2?.apply(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}

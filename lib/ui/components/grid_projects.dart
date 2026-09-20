import 'package:flutter/material.dart';
import 'package:icgoogo/ui/components/projects_box.dart';
import 'package:icgoogo/utils/screen_utils.dart';

import '../../models/project_model.dart';

class GridProjects extends StatelessWidget {
  final void Function(Project project)? onProjectTap;

  const GridProjects({
    super.key,
    this.onProjectTap,
  });

  @override
  Widget build(BuildContext context) {
    int getCrossAxisCount() {
      final screenType = getScreenType(MediaQuery.of(context));
      if (screenType == ScreenType.mobile) {
        return 1;
      }
      if (screenType == ScreenType.tablet) {
        return 2;
      }
      return 3;
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 1100,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: projects.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: getCrossAxisCount(),
            mainAxisExtent: 450.0,
            crossAxisSpacing: 24.0,
            mainAxisSpacing: 24.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            final project = projects[index];
            return ProjectsBox(
              title: project.title,
              tapLink: project.tapLink,
              gifPath: project.prevPath,
              onTap: onProjectTap != null ? () => onProjectTap!(project) : null,
            );
          },
        ),
      ),
    );
  }
}

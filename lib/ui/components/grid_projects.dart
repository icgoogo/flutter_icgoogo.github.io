import 'package:flutter/material.dart';
import 'package:icgoogo/const/images_path.dart';
import 'package:icgoogo/ui/components/projects_box.dart';
import 'package:icgoogo/utils/screen_utils.dart';

class Project {
  final String title;
  final String tapLink;
  final String gifPath;

  const Project(
    this.title,
    this.tapLink,
    this.gifPath,
  );
}

class GridProjects extends StatelessWidget {
  const GridProjects({super.key});

  @override
  Widget build(BuildContext context) {
    List<Project> projects = [
      const Project(
          "Ceria by BRI",
          "https://play.google.com/store/apps/details?id=id.co.bri.ceria",
          ceriaGif),
      const Project(
          "Clicker Game", "https://flutter-pfft.netlify.app/", clickerGameGif),
      const Project("Pokedex NextJS",
          "https://pokedex-nextjs-icgoogo.vercel.app", pokedexNextJsGif),
      const Project("Ktor Sports API",
          "https://github.com/icgoogo/ktor-sports-api", ktorSportsApi),
    ];

    double getChildAspectRatio() {
      final screenType = getScreenType(MediaQuery.of(context));
      if (screenType == ScreenType.mobile) {
        return 0.7;
      }

      if (screenType == ScreenType.tablet) {
        return 0.65;
      }

      if (screenType == ScreenType.desktopLarge) {
        return 0.85;
      }
      return 1.0;
    }

    int getCrossAxisCount() {
      final screenType = getScreenType(MediaQuery.of(context));
      if (screenType == ScreenType.mobile) {
        return 1;
      }

      if (screenType == ScreenType.tablet || screenType == ScreenType.desktop) {
        return 2;
      }

      return 3;
    }

    return GridView.builder(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ProjectsBox(
          title: projects[index].title,
          tapLink: projects[index].tapLink,
          gifPath: projects[index].gifPath,
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getCrossAxisCount(),
        childAspectRatio: getChildAspectRatio(),
      ),
      itemCount: projects.length,
    );
  }
}

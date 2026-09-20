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
        ceriaGif,
      ),
      const Project(
        "CTF Writeups",
        "https://github.com/icgoogo",
        me,
      ),
      const Project(
        "eBPF FSM",
        "https://github.com/icgoogo",
        me,
      ),
      const Project(
        "Temporal Data LSTM & Image CNN",
        "https://github.com/icgoogo",
        me,
      ),
      const Project(
        "5G Network Liverpool",
        "https://github.com/icgoogo",
        me,
      ),
      const Project(
        "Clicker Game",
        "https://flutter-pfft.netlify.app/",
        clickerGameGif,
      ),
      const Project(
        "Pokedex NextJS",
        "https://pokedex-nextjs-icgoogo.vercel.app",
        pokedexNextJsGif,
      ),
    ];

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
            mainAxisExtent:
                450.0, // Explicit height prevents RenderFlex vertical overflows
            crossAxisSpacing: 24.0,
            mainAxisSpacing: 24.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return ProjectsBox(
              title: projects[index].title,
              tapLink: projects[index].tapLink,
              gifPath: projects[index].gifPath,
            );
          },
        ),
      ),
    );
  }
}

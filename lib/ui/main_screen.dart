import 'package:flutter/material.dart';
import 'package:icgoogo/const/all_path.dart';
import 'package:icgoogo/models/project_model.dart';
import 'package:icgoogo/ui/components/markdown_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/bottom_game.dart';
import 'components/custom_button.dart';
import 'components/grid_projects.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  bool isProjectsOpened = false;
  Project? selectedProject;

  void _showProjects() {
    setState(() {
      selectedProject = null;
      isProjectsOpened = true;
    });
  }

  void _showHome() {
    setState(() {
      selectedProject = null;
      isProjectsOpened = false;
    });
  }

  void _openProject(Project project) {
    setState(() {
      selectedProject = project;
      isProjectsOpened = true;
    });
  }

  Future<void> _launchExternalUrl(String value) async {
    final url = Uri.parse(value);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      return;
    }

    throw 'Could not launch $url';
  }

  Widget _buildHomeView(BuildContext context) {
    return Column(
      key: const ValueKey('homeView'),
      children: [
        CustomButton(
          bgColor: Colors.lightGreen,
          title: Text(
            "Projects",
            style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: Colors.white,
                ),
          ),
          onTap: _showProjects,
        ),
        const SizedBox(
          height: 60.0,
        ),
        CustomButton(
          bgColor: Colors.deepOrange,
          title: Text(
            "Stack Overflow",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: Colors.white,
                ),
          ),
          onTap: () => _launchExternalUrl(
            stackOverflowLink,
          ),
        ),
        const SizedBox(
          height: 60.0,
        ),
        CustomButton(
          bgColor: Colors.blueAccent,
          title: Text(
            "Linkedin",
            style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: Colors.white,
                ),
          ),
          onTap: () => _launchExternalUrl(
            linkedinLink,
          ),
        ),
        const SizedBox(
          height: 60.0,
        ),
        CustomButton(
          bgColor: Colors.black,
          title: Text(
            "Github",
            style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: Colors.white,
                ),
          ),
          onTap: () => _launchExternalUrl(githubLink),
        ),
      ],
    );
  }

  Widget _buildProjectsView(BuildContext context) {
    return Column(
      key: const ValueKey('projectsView'),
      children: [
        CustomButton(
          bgColor: Colors.redAccent,
          title: Text(
            "Home",
            style: Theme.of(context).textTheme.bodyMedium?.apply(
                  color: Colors.white,
                ),
          ),
          onTap: _showHome,
        ),
        const SizedBox(height: 30.0),
        GridProjects(onProjectTap: _openProject),
      ],
    );
  }

  Widget _buildProjectDetailView(BuildContext context) {
    final project = selectedProject;
    final mdPath = project?.mdPath;

    return Column(
      key: const ValueKey('projectDetailView'),
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: CustomButton(
                  compact: true,
                  bgColor: Colors.redAccent,
                  title: Text(
                    "Home",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                  ),
                  onTap: _showHome,
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: CustomButton(
                  compact: true,
                  bgColor: Colors.blueGrey[800]!,
                  title: Text(
                    "Projects",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedProject = null;
                      isProjectsOpened = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18.0),
        if (project != null && mdPath != null)
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 28.0),
                decoration: BoxDecoration(
                  color: const Color(0xff15232b),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 12),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: MarkdownFileViewer(assetPath: mdPath),
              ),
            ),
          )
        else
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'No markdown details available for this project.',
              style: TextStyle(color: Colors.white),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentView = selectedProject != null
        ? _buildProjectDetailView(context)
        : isProjectsOpened
            ? _buildProjectsView(context)
            : _buildHomeView(context);

    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: ListView(
          children: [
            const SizedBox(height: 50.0),
            // Container(
            //   height: 200.0,
            //   width: 200.0,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle,
            //     image: DecorationImage(
            //       scale: 7.0,
            //       alignment: Alignment(0, 0.3),
            //       image: AssetImage(me),
            //       fit: BoxFit.none,
            //     ),
            //   ),
            // ),
            Center(
              child: Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  // 1. Thick retro border
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                  // 2. Hard-edged 8-bit shadow (blurRadius: 0)
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black87,
                      offset: Offset(8, 8),
                      blurRadius: 0,
                    ),
                  ],
                  image: const DecorationImage(
                    scale: 7.0,
                    alignment: Alignment(0, 0.3),
                    image: AssetImage(me),
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              "Hello There",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.apply(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "I'm Hammad, any inquiries? email me through \n\nhammadsyr@gmail.com",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.apply(
                      color: Colors.white,
                    ),
              ),
            ),
            const SizedBox(height: 50.0),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 450),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInOutCubic,
              transitionBuilder: (child, animation) {
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                  reverseCurve: Curves.easeInCubic,
                );

                return FadeTransition(
                  opacity: curvedAnimation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.03, 0.0),
                      end: Offset.zero,
                    ).animate(curvedAnimation),
                    child: child,
                  ),
                );
              },
              child: currentView,
            ),
            const SizedBox(height: 30.0),
            const SizedBox(
              height: 400.0,
              child: BottomGame(),
            ),
          ],
        ),
      ),
    );
  }
}

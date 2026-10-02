import 'package:flutter/material.dart';
import 'package:icgoogo/models/portfolio_model.dart';
import 'package:icgoogo/services/portfolio_service.dart';
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
  PortfolioResponse? portfolio;
  Object? portfolioError;
  bool isResumeOpened = false;

  @override
  void initState() {
    super.initState();
    fetchPortfolio().then((value) {
      if (!mounted) return;
      setState(() => portfolio = value);
    }).catchError((error) {
      if (!mounted) return;
      setState(() => portfolioError = error);
    });
  }

  void _showProjects() {
    setState(() {
      selectedProject = null;
      isResumeOpened = false;
      isProjectsOpened = true;
    });
  }

  void _showHome() {
    setState(() {
      selectedProject = null;
      isProjectsOpened = false;
      isResumeOpened = false;
    });
  }

  void _openProject(Project project) {
    setState(() {
      selectedProject = project;
      isProjectsOpened = true;
      isResumeOpened = false;
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
    final tabs = portfolio?.mainTabs ?? const <MainTab>[];
    return Column(
      key: const ValueKey('homeView'),
      children: [
        if (portfolio == null && portfolioError == null)
          const CircularProgressIndicator(color: Colors.tealAccent)
        else if (portfolioError != null)
          Text('Unable to load portfolio: $portfolioError',
              style: const TextStyle(color: Colors.redAccent))
        else
          ...tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final color = Colors.primaries[index % Colors.primaries.length];
            return Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: CustomButton(
                bgColor: color,
                title: Text(tab.title,
                    style: const TextStyle(color: Colors.white)),
                onTap: () {
                  if (tab.title.toLowerCase() == 'projects') {
                    _showProjects();
                  } else if (tab.title.toLowerCase() == 'resume' &&
                      portfolio?.cv != null) {
                    setState(() {
                      isResumeOpened = true;
                      isProjectsOpened = false;
                    });
                  } else if (tab.link != null) {
                    _launchExternalUrl(tab.link!);
                  }
                },
              ),
            );
          }),
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
        if (portfolio == null)
          const CircularProgressIndicator(color: Colors.tealAccent)
        else
          GridProjects(
            projects: portfolio!.projects,
            onProjectTap: _openProject,
          ),
      ],
    );
  }

  Widget _buildProjectDetailView(BuildContext context) {
    final project = selectedProject;
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
                      isResumeOpened = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18.0),
        if (project?.markdown != null)
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
                child: MarkdownViewer(markdown: project!.markdown!),
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

  Widget _buildResumeView(BuildContext context) {
    return Column(
      key: const ValueKey('resumeView'),
      children: [
        CustomButton(
          bgColor: Colors.redAccent,
          title: const Text('Home', style: TextStyle(color: Colors.white)),
          onTap: _showHome,
        ),
        const SizedBox(height: 24.0),
        if (portfolio?.cv != null)
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.all(24.0),
            color: const Color(0xff15232b),
            child: MarkdownViewer(markdown: portfolio!.cv!),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object>? avatarImage = portfolio?.mainPreviewUrl == null
        ? null
        : NetworkImage(portfolio!.mainPreviewUrl!);
    final currentView = isResumeOpened
        ? _buildResumeView(context)
        : selectedProject != null
            ? _buildProjectDetailView(context)
            : isProjectsOpened
                ? _buildProjectsView(context)
                : _buildHomeView(context);

    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints
                      .maxHeight, // Forces column to at least screen height
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const SizedBox(height: 50.0),
                      Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 190.0,
                              height: 210.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E293B),
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                  color: Colors.tealAccent,
                                  width: 3.5,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black87,
                                    offset: Offset(8, 8),
                                    blurRadius: 0,
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: avatarImage == null
                                    ? Container(
                                        color: Colors.blueGrey[800],
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.person,
                                          size: 72,
                                          color: Colors.white54,
                                        ),
                                      )
                                    : Image(
                                        image: avatarImage,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.blueGrey[800],
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              Icons.person,
                                              size: 72,
                                              color: Colors.white54,
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            Positioned(
                              top: -12,
                              left: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(2, 2),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  '@!*#JAK)@HEHE',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                      // Pushes BottomGame to the bottom when content is shorter than screen
                      const Spacer(),
                      const SizedBox(
                        height: 400.0,
                        child: BottomGame(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PortfolioResponse {
  final List<Project> projects;
  final String? cv;
  final String? mainPreviewUrl;
  final List<MainTab> mainTabs;

  const PortfolioResponse({
    required this.projects,
    this.cv,
    this.mainPreviewUrl,
    required this.mainTabs,
  });

  factory PortfolioResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    final additional = (data['additional_data'] as List<dynamic>?)
        ?.cast<Map<String, dynamic>>()
        .firstOrNull;

    return PortfolioResponse(
      projects: (data['list_projects'] as List<dynamic>? ?? <dynamic>[])
          .map((item) => Project.fromJson(item))
          .toList(),
      cv: _value(additional?['cv']),
      mainPreviewUrl: _value(additional?['main_preview_url']),
      mainTabs: (data['main_tab'] as List<dynamic>? ?? <dynamic>[])
          .map((item) => MainTab.fromJson(item))
          .toList(),
    );
  }
}

String? _value(dynamic value) {
  final result = value?.toString().trim();
  return result == null || result.isEmpty ? null : result;
}

class Project {
  final int id;
  final String title;
  final String? previewId;
  final String? link;
  final String? markdown;
  final String? prevPath;
  final String? mdPath;
  final String? tapLink;

  const Project({
    this.id = 0,
    required this.title,
    String? previewId,
    String? link,
    String? markdown,
    this.prevPath,
    this.mdPath,
    this.tapLink,
  })  : previewId = previewId ?? prevPath,
        link = link ?? tapLink,
        markdown = markdown ?? mdPath;

  bool get hasExternalLink => (link ?? '').trim().isNotEmpty;

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int? ?? 0,
      title: json['name']?.toString() ?? '',
      previewId: _value(json['prev_id']),
      link: _value(json['link']),
      markdown: _value(json['md']),
    );
  }

  String? previewUrl() {
    return previewId;
  }
}

const List<Project> defaultProjects = [
  Project(title: 'Ceria by BRI'),
  Project(title: 'Kernel-Level Connection Tracking with eBPF in C'),
  Project(title: 'Throughput Prediction for 5G High Density Network'),
  Project(title: 'CTF Challenges'),
  Project(title: 'Programmable Data Plane with P4 and eBPF Lab'),
  Project(title: 'Linux Kernel Module Development'),
  Project(title: 'Network Data Analysis Notebook'),
  Project(title: 'Network Measurement Notebook'),
  Project(title: 'Image Classifier with Mask using Transfer Learning'),
  Project(title: 'Pain Level Classifier with Temporal Data'),
  Project(title: 'Cocorolife Indonesia'),
  Project(title: 'Clicker Game'),
  Project(title: 'Pokedex NextJS'),
];

const List<Project> projects = defaultProjects;

class MainTab {
  final String title;
  final String? link;

  const MainTab({
    required this.title,
    this.link,
  });

  factory MainTab.fromJson(Map<String, dynamic> json) {
    return MainTab(
      title: json['tab']?.toString() ?? '',
      link: _value(json['link']),
    );
  }
}

extension FirstOrNull<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

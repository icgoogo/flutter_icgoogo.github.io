import 'package:icgoogo/const/all_path.dart';

class Project {
  final String title;
  final String? prevPath;
  final String? mdPath;
  final String? tapLink;

  const Project({
    required this.title,
    this.prevPath,
    this.mdPath,
    this.tapLink,
  });

  bool get hasExternalLink => (tapLink ?? '').trim().isNotEmpty;
}

List<Project> projects = [
  const Project(
    title: "Ceria by BRI",
    mdPath: ceriaMd,
    prevPath: ceriaGif,
  ),
  const Project(
    title: "Kernel-Level Connection Tracking with eBPF in C",
    tapLink: ebpfLink,
  ),
  const Project(
    title: "Throughput Prediction for 5G High Density Network",
    tapLink: networkLiverpoolLink,
  ),
  const Project(
    title: "CTF Challenges",
    mdPath: ctfMd,
  ),
  const Project(
    title: "Programmable Data Plane with P4 and eBPF Lab",
    tapLink: ncLabLink,
  ),
  const Project(
    title: "Linux Kernel Module Development",
    tapLink: osLabLink,
  ),
  const Project(
    title: "Network Data Analysis Notebook",
    mdPath: ctfMd,
  ),
  const Project(
    title: "Network Measurement Notebook",
    mdPath: nmMd,
  ),
  const Project(
    title: "Image Classifier with Mask using Transfer Learning",
    mdPath: ctfMd,
    prevPath: imageClassifier,
  ),
  const Project(
    title: "Pain Level Classifier with Temporal Data",
    mdPath: ctfMd,
    prevPath: painClassifier,
  ),
  const Project(
    title: "Cocorolife Indonesia",
    tapLink: cocoroLink,
    prevPath: cocorolife,
  ),
  const Project(
    title: "Clicker Game",
    tapLink: clickerLink,
    prevPath: clickerGameGif,
  ),
  const Project(
    title: "Pokedex NextJS",
    tapLink: pokedexLink,
    prevPath: pokedexNextJsGif,
  ),
];

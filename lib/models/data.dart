import 'package:flutter/material.dart';
import '../theme.dart';

// ─── PROJECT MODEL ───────────────────────────────────────────────
class ProjectModel {
  final String title;
  final String description;
  final String tech;
  final String githubUrl;
  final String? liveUrl;
  final LinearGradient gradient;
  final IconData icon;
  final bool inProgress;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tech,
    required this.githubUrl,
    this.liveUrl,
    required this.gradient,
    required this.icon,
    this.inProgress = false,
  });
}

final List<ProjectModel> projects = [
  ProjectModel(
    title: 'Flowly SaaS',
    description: 'Application SaaS de gestion de flux et de productivité. Interface moderne avec tableau de bord complet.',
    tech: 'Flutter · Dart',
    githubUrl: 'https://github.com/Houecande/Flowly-SaaS',
    gradient: AppColors.gradCyan,
    icon: Icons.water_drop_outlined,
    inProgress: true,
  ),
  ProjectModel(
    title: 'Jeu de Fruit (Zestly)',
    description: 'Jeu mobile interactif de fruits avec animations fluides et mécaniques de jeu engageantes.',
    tech: 'Flutter · Dart',
    githubUrl: 'https://github.com/Houecande/Zestly-app',
    gradient: AppColors.gradPink,
    icon: Icons.sports_esports_outlined,
  ),
  ProjectModel(
    title: 'President Games',
    description: 'Jeu de cartes du Président en version mobile.',
    tech: 'Flutter · Dart',
    githubUrl: 'https://github.com/Houecande/President_Games',
    gradient: AppColors.gradViolet,
    icon: Icons.casino_outlined,
  ),
  ProjectModel(
    title: 'ChatDev',
    description: 'Application de messagerie orientée développeurs. Interface chat temps réel avec fonctionnalités collaboratives.',
    tech: 'Flutter · Dart',
    githubUrl: 'https://houecande.github.io/devchat/',
    liveUrl: 'https://houecande.github.io/devchat/',
    gradient: AppColors.gradBlue,
    icon: Icons.chat_bubble_outline,
  ),
  ProjectModel(
    title: 'SGPVA — Gestion de Parc',
    description: 'Système de gestion de parc de véhicules administratifs. Suivi complet des véhicules, missions et maintenance.',
    tech: 'VB.NET',
    githubUrl: 'https://github.com/Houecande/SGPVA_V1',
    gradient: const LinearGradient(
      colors: [Color(0xFF059669), Color(0xFF10B981)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    icon: Icons.directions_car_outlined,
  ),
  ProjectModel(
    title: 'Template Portfolio',
    description: 'Template de portfolio moderne et responsive, utilisable comme base pour tout projet web.',
    tech: 'HTML · CSS · JS',
    githubUrl: 'https://github.com/Houecande/Template',
    gradient: const LinearGradient(
      colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    icon: Icons.web_outlined,
  ),
  ProjectModel(
    title: 'App Gestion Étudiants',
    description: "Application Java de gestion d'étudiants avec interface graphique, CRUD et exports de données.",
    tech: 'Java',
    githubUrl: 'https://www.linkedin.com/posts/armand-biljoric-houecande-80769a366_java-coding-apprentissage-activity-7410631595579035648-MBXL',
    gradient: const LinearGradient(
      colors: [Color(0xFFDC2626), Color(0xFFF97316)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    icon: Icons.school_outlined,
  ),
];

// ─── DESIGN PROJECTS ─────────────────────────────────────────────
class DesignProjectModel {
  final String title;
  final String description;
  final String tool;
  final String url;
  final String? secondUrl;
  final IconData icon;

  const DesignProjectModel({
    required this.title,
    required this.description,
    required this.tool,
    required this.url,
    this.secondUrl,
    required this.icon,
  });
}

final List<DesignProjectModel> designProjects = [
  DesignProjectModel(
    title: 'CHIPS MANIOC — One Page',
    description: "Conception UI/UX d'une plateforme One-Page pour CHIPS MANIOC. Maquette haute fidélité et prototype interactif Figma.",
    tool: 'Figma',
    url: 'https://www.figma.com/proto/VAHuk9RfGSZlBunwXf8shU/Conception-du-Site-Web-One-Page-%E2%80%93-CHIPS-MANIOC---Maquette-haute-fid%C3%A9lit%C3%A9---prototype-interactif?page-id=0%3A1&node-id=3-43',
    secondUrl: 'https://www.linkedin.com/posts/armand-biljoric-houecande-80769a366_uiux-figma-intelligenceartificielle-activity-7419470405578518528-AntC',
    icon: Icons.palette_outlined,
  ),
  DesignProjectModel(
    title: 'STManage — Wireframing',
    description: "Conception de l'application STManage : wireframes basse fidélité et flux utilisateur avec Balsamiq.",
    tool: 'Balsamiq',
    url: 'https://www.linkedin.com/posts/armand-biljoric-houecande-80769a366_balsamiq-obsstudio-uatm-ugcPost-7414029917799079936-aPDA',
    icon: Icons.dashboard_customize_outlined,
  ),
];

// ─── STACK MODEL ─────────────────────────────────────────────────
class StackCategory {
  final String name;
  final List<StackItem> items;
  final LinearGradient gradient;

  const StackCategory({
    required this.name,
    required this.items,
    required this.gradient,
  });
}

class StackItem {
  final String name;
  final IconData icon;

  const StackItem(this.name, this.icon);
}

final List<StackCategory> stackCategories = [
  StackCategory(
    name: 'Mobile & Web App',
    gradient: AppColors.gradBlue,
    items: [
      StackItem('Flutter', Icons.phone_android_outlined),
      StackItem('Dart', Icons.code),
      StackItem('Firebase', Icons.local_fire_department_outlined),
    ],
  ),
  StackCategory(
    name: 'Backend & API',
    gradient: AppColors.gradViolet,
    items: [
      StackItem('Python', Icons.terminal),
      StackItem('FastAPI', Icons.bolt_outlined),
      StackItem('PHP', Icons.php_outlined),
      StackItem('Java', Icons.coffee_outlined),
      StackItem('VB.NET', Icons.window_outlined),
    ],
  ),
  StackCategory(
    name: 'Web & UI',
    gradient: AppColors.gradPink,
    items: [
      StackItem('HTML', Icons.html_outlined),
      StackItem('CSS', Icons.css_outlined),
      StackItem('JavaScript', Icons.javascript_outlined),
    ],
  ),
  StackCategory(
    name: 'Design & Proto',
    gradient: const LinearGradient(
      colors: [Color(0xFFF59E0B), Color(0xFFEC4899)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    items: [
      StackItem('Figma', Icons.design_services_outlined),
      StackItem('Balsamiq', Icons.space_dashboard_outlined),
      StackItem('Prototyping', Icons.touch_app_outlined),
    ],
  ),
  StackCategory(
    name: 'Outils & DevOps',
    gradient: AppColors.gradCyan,
    items: [
      StackItem('Git', Icons.account_tree_outlined),
      StackItem('GitHub', Icons.code_off_outlined),
    ],
  ),
];

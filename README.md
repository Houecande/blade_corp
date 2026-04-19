# BLADE CORP — Portfolio Flutter Web

Portfolio professionnel UI/UX & Dev par Armand Houécandé.

## 🚀 Installation & Lancement

### Prérequis
- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Chrome (pour le dev web)

### Étapes

```bash
# 1. Cloner / copier le projet
cd blade_corp

# 2. Installer les dépendances
flutter pub get

# 3. Lancer en mode web (développement)
flutter run -d chrome

# 4. Build pour production
flutter build web --release
# Les fichiers sont dans build/web/
```

## 📁 Structure du projet

```
lib/
├── main.dart              # Point d'entrée, page principale
├── theme.dart             # Couleurs, thème, GlobalKeys de navigation
├── models/
│   └── data.dart          # Projets, stack, données
├── widgets/
│   ├── common.dart        # Widgets réutilisables
│   ├── navbar.dart        # Barre de navigation sticky
│   └── footer.dart        # Pied de page
└── sections/
    ├── hero_section.dart     # Hero avec animation photo + badges
    ├── expertise_section.dart # Domaines d'expertise
    ├── projets_section.dart   # Grille de projets dev + design
    ├── stack_section.dart     # Stack technique
    ├── process_section.dart   # Mon processus
    └── contact_section.dart   # Formulaire de contact
```

## 🖼️ Ajouter ta photo de profil

1. Place ta photo dans `assets/images/profile.jpg`
2. Dans `hero_section.dart`, remplace le bloc `child: ClipOval(...)` par :

```dart
child: ClipOval(
  child: Image.asset(
    'assets/images/profile.jpg',
    fit: BoxFit.cover,
    width: 240,
    height: 240,
  ),
),
```

## 🌐 Déploiement sur Vercel

```bash
# 1. Build
flutter build web --release

# 2. Dans le dossier build/web/
# → Connecter à Vercel via GitHub ou drag & drop du dossier

# Ou avec Vercel CLI :
cd build/web
vercel --prod
```

## 🎨 Personnalisation

- **Couleurs** → `lib/theme.dart` → `AppColors`
- **Projets** → `lib/models/data.dart` → `projects` & `designProjects`
- **Stack** → `lib/models/data.dart` → `stackCategories`
- **Infos contact** → `lib/sections/contact_section.dart`

## 📦 Dépendances

| Package | Usage |
|---------|-------|
| `google_fonts` | Police Space Grotesk + Syne |
| `url_launcher` | Ouvrir liens GitHub, LinkedIn, etc. |
| `animate_do` | Animations d'entrée (optionnel) |
| `font_awesome_flutter` | Icônes tech |

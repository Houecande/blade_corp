# BLADE CORP — Portfolio Flutter Web

Portfolio professionnel UI/UX & Dev par Armand Biljoric HOUECANDE.

## 🚀 Installation & Lancement

### Prérequis
- Flutter SDK >= 3.0.0
- Dart >= 3.0.0
- Chrome (pour le dev web)


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

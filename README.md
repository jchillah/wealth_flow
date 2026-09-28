# 💰 WealthFlow

> Personal finance & asset tracker built with Flutter – classic budget tracking meets a live crypto dashboard, designed offline-first.

🚧 **Status: Work in progress** – built feature by feature as a portfolio project. Progress is tracked publicly on the [project board](https://github.com/users/jchillah/projects/47) and in the [milestones](https://github.com/jchillah/wealth_flow/milestones).

## ✨ Features

- 📊 **Dashboard** – balance, income vs. expenses at a glance
- 🧾 **Transactions** – add and manage entries *(in progress, M2)*
- 🪙 **Crypto** – live prices via CoinGecko, offline-capable *(planned, M4)*

## 📸 Screenshots

_Coming soon._

## 🏗️ Architecture

Feature-first Clean Architecture – the folder structure tells you what the app does ("screaming architecture"):

```
lib/
├── main.dart          # bootstrap only
├── app.dart           # root widget: theme + home
├── core/              # shared across features (theme, utils)
└── features/
    ├── navigation/    # app shell + bottom navigation
    ├── dashboard/     # presentation/
    ├── transactions/  # data/ · domain/ · presentation/
    └── crypto/        # presentation/
```

Data flows in one direction only: **UI → Bloc → Repository → Data Source**.

## 🛠️ Tech Stack

| Purpose | Choice |
|---|---|
| Framework | Flutter (Dart 3) |
| State management | `flutter_bloc` |
| Local storage | `hive_ce` (offline-first) |
| Networking | `dio` (CoinGecko API) |
| Error handling | `fpdart` Either + Failure model |
| Logging | `logger` |

## 🚀 Getting Started

```bash
git clone https://github.com/jchillah/wealth_flow.git
cd wealth_flow
flutter pub get
flutter run
```

## 🗺️ Roadmap

| Milestone | Scope |
|---|---|
| M1 | App shell & navigation ✅ |
| M2 | Transactions CRUD with Bloc |
| M3 | Persistence (Hive CE) & Clean Architecture |
| M4 | Crypto API, offline mode, error handling |
| M5 | Charts, dark mode, i18n, animations |
| M6 | CI/CD, web demo, README polish |

## 📄 License

[MIT](LICENSE) – Copyright (c) 2026 Jchillah

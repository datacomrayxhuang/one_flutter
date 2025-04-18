# Flutter Monorepo: To-Do App

This is a Flutter monorepo project managed using [Melos](https://melos.invertase.dev/). The repository contains the main application, a to-do app, and a reusable `ui_elements` package for shared widgets.

## Project Structure

```
one_flutter/
├── apps/
│   └── todo_app/          # Main To-Do application
├── packages/
│   └── ui_elements/       # Reusable UI components
├── melos.yaml             # Melos configuration
└── README.md              # Project documentation
```

### Applications

- **`todo_app`**: A simple to-do application that allows users to manage tasks.
  - Features:
    - Add, update, and delete tasks.
    - Mark tasks as complete or incomplete.
    - Persistent storage for tasks.

### Packages

- **`ui_elements`**: A package containing reusable widgets and components.
  - Includes:
    - `CustomAppBar`: A customizable app bar.
    - `CustomButton`: A reusable button with primary and secondary styles.
    - `CustomTextField`: A styled text field with validation support.
    - `ErrorTile`: A widget for displaying error messages.
    - `ExpandableTextTile`: A widget for expandable/collapsible text.
    - `LoadingView`: A simple loading spinner.

---

## Getting Started

### Prerequisites

- Install [Flutter](https://flutter.dev/docs/get-started/install) (version 3.0.0 or later).
- Install [Melos](https://melos.invertase.dev/getting-started) globally:
  ```bash
  dart pub global activate melos
  ```

### Setup Instructions

1. Clone the repository:

   ```bash
   git clone https://github.com/datacomrayxhuang/one_flutter.git
   cd one_flutter
   ```

2. Install dependencies using Melos:

   ```bash
   melos bootstrap
   ```

3. Navigate to the `todo_app` directory:

   ```bash
   cd apps/todo_app
   ```

4. Run the app:
   ```bash
   flutter run
   ```

---

## Running Tests

To run tests for all packages and apps in the monorepo:

```bash
melos run test
```

To run tests for a specific app or package:

```bash
cd apps/todo_app
flutter test
```

---

## Development Workflow

### Adding a New Package

1. Create a new package using Melos:

   ```bash
   melos create <package_name>
   ```

2. Add the package to the `packages/` directory and update `melos.yaml`.

### Updating Dependencies

1. Update dependencies in the `pubspec.yaml` files.
2. Run `melos bootstrap` to sync dependencies across the monorepo.

---

## Project Highlights

### To-Do App

The `todo_app` is the main application in this monorepo. It uses the `ui_elements` package for consistent UI components and follows the BLoC architecture for state management.

### UI Elements Package

The `ui_elements` package provides reusable widgets to ensure consistent design and reduce code duplication across apps.

---

## Troubleshooting

### Common Issues

- **Melos not found**: Ensure Melos is installed globally:
  ```bash
  dart pub global activate melos
  ```
- **Dependency issues**: Run `melos clean` and `melos bootstrap` to reset dependencies.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests.

---

## Contact

For questions or support, please contact [rayxhuang2@gmail.com].

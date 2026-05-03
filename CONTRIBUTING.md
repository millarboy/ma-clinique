# Contributing to Ma Clinique

Thank you for your interest in contributing to Ma Clinique! This document provides guidelines and instructions for contributing to the project.

## 🤝 How to Contribute

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When creating a bug report, include:

- **Clear description** of the problem
- **Steps to reproduce** the issue
- **Expected behavior** vs. **actual behavior**
- **Screenshots** if applicable
- **Environment details** (OS, Flutter version, app version)
- **Logs** if available

### Suggesting Enhancements

Enhancement suggestions are welcome! Please provide:

- **Clear description** of the enhancement
- **Use cases** for the enhancement
- **Alternative solutions** considered
- **Implementation ideas** if you have them

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode
- Firebase account
- Git

### Setting Up Development Environment

1. **Fork the repository**
   ```bash
   # Fork the repository on GitHub
   # Clone your fork
   git clone https://github.com/yourusername/ma-clinique.git
   cd ma-clinique
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` for Android
   - Add your `GoogleService-Info.plist` for iOS
   - Update Firebase configuration

4. **Run the apps**
   ```bash
   # Doctors App
   cd "Doctors App/ma_doctor"
   flutter run

   # Patient App
   cd "Patient/ma_clinique_web"
   flutter run

   # Reception Dashboard
   cd "Reception Dashboard/flaw3"
   flutter run
   ```

## 📝 Coding Standards

### Code Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `flutter analyze` to check for issues
- Format code with `dart format`
- Write meaningful commit messages

### Commit Message Format

Use conventional commit messages:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples:**
```
feat(doctors): add patient search functionality
fix(patient): resolve appointment booking crash
docs(readme): update installation instructions
```

### Code Structure

Follow the established project structure:

```
lib/
├── main.dart
├── app_state.dart
├── index.dart
├── flutter_flow/
│   ├── flutter_flow_theme.dart
│   ├── flutter_flow_widgets.dart
│   └── ...
└── pages/
    └── ...
```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Writing Tests

- Write unit tests for business logic
- Write widget tests for UI components
- Aim for high test coverage
- Test edge cases and error conditions

## 📋 Pull Request Process

### Before Submitting

1. **Update documentation** if needed
2. **Add tests** for new features
3. **Run tests** and ensure they pass
4. **Run `flutter analyze`** and fix issues
5. **Format code** with `dart format`
6. **Update CHANGELOG** if applicable

### Creating a Pull Request

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** and commit them
   ```bash
   git add .
   git commit -m "feat(scope): description of changes"
   ```

3. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

4. **Create Pull Request** on GitHub

### Pull Request Checklist

- [ ] Code follows project style guidelines
- [ ] Tests pass locally
- [ ] Documentation is updated
- [ ] Commit messages follow conventions
- [ ] No merge conflicts
- [ ] PR description clearly describes changes

## 🎨 Design Guidelines

### UI/UX Consistency

- Follow the established design system
- Use consistent colors and typography
- Maintain responsive design principles
- Ensure accessibility (WCAG AA compliance)

### Component Usage

- Use existing FlutterFlow components when possible
- Create reusable components for common patterns
- Follow component naming conventions

## 🔐 Security Considerations

- Never commit sensitive data (API keys, passwords)
- Use environment variables for configuration
- Follow security best practices
- Report security vulnerabilities privately

## 📚 Documentation

### Code Documentation

- Document public APIs with Dart doc comments
- Explain complex logic with inline comments
- Keep documentation up to date

### Project Documentation

- Update README.md for user-facing changes
- Update BUILD_README.md for build system changes
- Update relevant documentation files

## 🤝 Community Guidelines

### Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Focus on what is best for the community
- Show empathy towards other community members

### Communication

- Use GitHub issues for bug reports and feature requests
- Use GitHub discussions for questions and ideas
- Be patient with responses
- Help others when you can

## 🚀 Release Process

### Version Bump

Use the build script to version bump:

```bash
# Patch version
./build.sh version doctors patch

# Minor version
./build.sh version patient minor

# Major version
./build.sh version reception major
```

### Building Release

```bash
# Build all apps for release
./build.sh build all release android -i
```

## 📞 Getting Help

- **GitHub Issues**: For bugs and feature requests
- **GitHub Discussions**: For questions and ideas
- **Documentation**: Check existing docs first
- **Code Review**: Request reviews from maintainers

## 🙏 Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes
- Project documentation

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

**Thank you for contributing to Ma Clinique!** 🎉

For questions, please open an issue or discussion on GitHub.
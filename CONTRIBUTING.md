# Contributing to ERi-TV App

First off, thank you for considering contributing to ERi-TV App! It's people like you that make ERi-TV App such a great tool.

## Code of Conduct

This project and everyone participating in it is governed by our Code of Conduct. By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed**
- **Explain which behavior you expected to see instead**
- **Include screenshots if possible**
- **Include your environment details** (Flutter version, device, OS)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List any examples of how this enhancement would be used**

### Pull Requests

1. **Fork the repository** and create your branch from `main`
2. **If you've added code**, add tests
3. **Ensure the test suite passes**
4. **Make sure your code follows the Dart style guide**
5. **Write a clear commit message**

## Development Process

1. **Fork the repo** on GitHub
2. **Clone your fork** locally
   ```bash
   git clone https://github.com/YOUR-USERNAME/Eritv-App.git
   cd Eritv-App
   ```

3. **Create a branch** for your changes
   ```bash
   git checkout -b feature/my-new-feature
   ```

4. **Make your changes**
   - Write clean, readable code
   - Follow Dart conventions
   - Add comments where necessary
   - Update documentation

5. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   ```

6. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add some feature"
   ```

7. **Push to your fork**
   ```bash
   git push origin feature/my-new-feature
   ```

8. **Create a Pull Request** on GitHub

## Style Guide

### Dart Style

- Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter format` to format your code
- Use meaningful variable and function names
- Keep functions small and focused
- Add documentation comments for public APIs

### Commit Messages

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less
- Reference issues and pull requests liberally after the first line

Example:
```
Add video quality selection feature

- Add quality options in video player
- Store user preference locally
- Update UI to show selected quality
- Add tests for quality selection

Fixes #123
```

### Code Structure

- **Models**: Data structures in `lib/models/`
- **Services**: Business logic in `lib/services/`
- **Screens**: UI screens in `lib/screens/`
- **Widgets**: Reusable components in `lib/widgets/`
- **Tests**: All tests in `test/`

## Testing

- Write unit tests for all business logic
- Write widget tests for UI components
- Ensure all tests pass before submitting PR
- Aim for high test coverage

```bash
flutter test
flutter test --coverage
```

## Documentation

- Update README.md if you change functionality
- Update FEATURES.md for new features
- Add inline comments for complex logic
- Document public APIs with /// comments

## Priority Areas

We especially welcome contributions in these areas:

1. **News Integration** - Implementing the news feature
2. **EPG Support** - Adding program guide
3. **Localization** - Adding multiple language support
4. **Testing** - Improving test coverage
5. **Performance** - Optimizing video streaming
6. **UI/UX** - Enhancing user interface

## Questions?

Feel free to open an issue with your question or contact the maintainers directly.

## Recognition

Contributors will be recognized in the README.md file. Thank you for your contributions!

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

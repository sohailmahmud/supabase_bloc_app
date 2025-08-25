# 🤝 Contributing to Flutter Supabase BLoC App

First off, thanks for taking the time to contribute! 🎉  
This project is open source and welcomes all kinds of contributions — from bug reports and feature requests to documentation improvements and code submissions.

---

## 🧾 Code of Conduct
This project follows the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/).  
By participating, you agree to uphold this standard of respectful and inclusive communication.

---

## 🚀 How to Contribute

### 1. Fork the Repository
Click the **Fork** button at the top right of this repo and clone your fork locally:

```bash
git clone https://github.com/your-username/flutter_supabase_bloc_app.git
cd flutter_supabase_bloc_app
```

### 2. Create a Branch
Always create a new branch for your changes:
```bash
git checkout -b feature/my-new-feature
```

### 3. Install Dependencies
Make sure you can run the app locally:
```bash
flutter pub get
flutter run
```

### 4. Follow Project Structure
This project uses Clean Architecture with features/ directories:

features/
├── auth/
│   ├── data/
│   ├── domain/
│   └── presentation/
├── dashboard/
└── notifications/

Please respect this layering:
* data/ → models, repositories, API calls
* domain/ → entities, use cases
* presentation/ → UI, widgets, blocs

### 5. Follow Code Style
* Use Flutter’s standard formatting:
```bash
flutter format .
```
* Prefer BLoC for state management.
* Keep widgets stateless whenever possible.
* Use meaningful commit messages (see below).

---

## 📝 Commit Messages

We follow the [Conventional Commits](https://www.conventionalcommits.org/) standard:

* feat: → new feature
* fix: → bug fix
* docs: → documentation only changes
* refactor: → code change that neither fixes a bug nor adds a feature
* test: → adding or fixing tests
* chore: → maintenance, build tasks, dependencies

Examples:
```pgsql
feat(auth): add password reset feature
fix(notifications): correct FCM token refresh logic
docs(readme): add setup instructions for Firebase
```

---

## ✅ Pull Request Guidelines
1. Ensure the app builds and runs without errors.
2. Add/Update tests if applicable.
3. Update README.md if introducing new features.
4. Reference related issues in your PR description.
5. PR titles should follow the commit style (e.g., feat(dashboard): add logout button).

---

## 🧪 Testing
Run tests before pushing:
```bash
flutter test
```

---

## 💡 Suggestions
If you’re unsure where to start, check the [open issues](../../issues).
You can also suggest new features by creating a **feature request issue**.

---

## 🌍 Community
* Report bugs via [GitHub Issues](../../issues)
* Discuss ideas in **Discussions** (if enabled)
* Share improvements through **Pull Requests**

---

Thanks again for contributing! 🙌
Together, we’re building a scalable Flutter + Supabase + Firebase starter app 🚀


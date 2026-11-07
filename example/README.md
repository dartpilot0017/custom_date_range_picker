# Date Range Plus playground

An interactive showcase of the actual package, with inline, dialog, and bottom-sheet layouts, three accents, light/dark themes, date bounds, week-start controls, and copyable Dart examples.

## Run locally

```sh
flutter pub get
flutter run -d chrome
```

Uses the package via `path: ../`. The preview targets the unreleased 0.1.0 API. The published 0.0.3 package does not contain all of these improvements.

## Verify

```sh
flutter analyze
flutter test
flutter build web --release --base-href /custom_date_range_picker/
```

Tests cover confirmed ranges, overlays, live selection, options, clipboard content, and mobile layout. Screenshots in `../doc/screenshots/` were captured from the production web build. The fixed November 2026 sample keeps demonstrations reproducible.

## Publish on GitHub Pages

The workflow `../.github/workflows/playground.yml` builds and tests the package and example before deployment. It deploys on relevant pushes to `main` or through a manual workflow run.

One-time repository setup:

1. Sign in to GitHub with an account that can manage this repository (`gh auth login` for CLI use).
2. In repository **Settings → Pages**, choose **GitHub Actions** as the source.
3. Commit and push the reviewed changes to `main`, or merge them through a pull request.
4. Run **Actions → Deploy playground → Run workflow** if a relevant push has not already started it.
5. Verify the URL returned by the deployment before adding a live-demo badge to the main README.

Expected URL after successful deployment: https://dartpilot0017.github.io/custom_date_range_picker/

This URL is a deployment target, not a claim that the playground is already live. This session prepared and tested the build locally; GitHub CLI authentication was unavailable.

If the repository is renamed, update the workflow's `--base-href` and this target URL together. For a custom domain, build with the appropriate base path instead.

The example uses `url_launcher` for package/source links; the package itself still has no runtime dependency beyond Flutter.

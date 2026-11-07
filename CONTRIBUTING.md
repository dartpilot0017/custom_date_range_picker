# Contributing

Keep the runtime package dependency-free beyond Flutter. Use local layout constraints, Material theme defaults, and Material localization APIs. Never perform navigation inside the embedded picker.

For a bug fix, add a regression test for observable behavior. Cover date-only comparisons, inclusive bounds, callback order, and parent updates when changing selection logic. Test narrow widths and large text when changing layout.

Run formatting, static analysis, package tests, and example tests using the README commands. CI checks the minimum supported Flutter version and stable. Changes to public behavior need migration notes and a changelog entry.

## Release checklist

1. Verify CI on minimum and stable Flutter SDKs.
2. Try the example in a browser and on a mobile device, including keyboard navigation, screen readers, dark mode, and large text.
3. Review version, changelog, README installation instructions, and generated API documentation.
4. Run `dart pub publish --dry-run` from the repository root and inspect the file list. Resolve unexpected files and validation warnings.
5. Publish only after maintainer review. Change the README's upcoming-release instructions when the version is actually available on pub.dev.

The 0.1.0 changes are prepared locally; editing the version does not publish them.

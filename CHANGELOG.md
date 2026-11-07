## 0.1.0 (unreleased)

- Add the package-named entry point and typed `showCustomDateRangePicker` dialog helper.
- Enforce inclusive date bounds and validate initial selections.
- Normalize timestamps, synchronize parent updates, and allow same-day ranges and reselection.
- Disable incomplete confirmation and remove implicit route popping from the embedded picker.
- Reset selection before notifying custom reset callbacks.
- Add `onConfirm`, live `onSelectionChanged`, `firstDayOfWeek`, and `showActionButtons`.
- Replace global screen scaling with local constraints and scrolling.
- Use theme-aware Material controls, keyboard activation, localized calendars, and date semantics.
- Preserve existing styling parameters and the legacy import; deprecate unused dropdown value/gap options.
- Replace the example and add regression tests, CI, and migration documentation.

See the README migration section before upgrading from 0.0.3.

## 0.0.1
- Initial release with customizable date range picker.
- Added support for UI customization including colors, text styles, and action buttons.
- Implemented responsive design.

## 0.0.2
- Updated License to MIT.
- Added more detailed documentation.

## 0.0.3
- Added support for dropdowns.
- Improved UI and added more customization options.


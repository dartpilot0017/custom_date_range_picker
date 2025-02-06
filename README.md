# Custom Date Range Plus

A customizable Flutter widget for selecting date ranges with additional UI elements such as buttons and dropdowns.

## Features
- Select start and end dates within a given range.
- Customize UI elements such as colors, text styles, and buttons.
- Dropdown for month and year selection.
- Reset and confirm action buttons with customizable appearance.
- Weekday labels with customizable text styles.
- Fully responsive UI.

## Installation
Add the following dependency to your `pubspec.yaml`:

```yaml
dependencies:
  custom_date_range_plus: latest_version
```

Then, run:
```sh
flutter pub get
```

## Usage
### Import the Package
```dart
import 'package:custom_date_range_plus/custom_date_range_picker.dart';
```

### Example Implementation

```dart
DateRangePicker(
  startDate: DateTime.now().subtract(Duration(days: 7)),
  endDate: DateTime.now(),
  minDate: DateTime(2020, 1, 1),
  maxDate: DateTime(2030, 12, 31),
  onStartDateChanged: (date) => print("Start Date: \$date"),
  onEndDateChanged: (date) => print("End Date: \$date"),
  onDateRangeChanged: (range) => print("Selected Range: \${range?.start} - \${range?.end}"),
  selectedDateColor: Colors.blue,
  selectedDateTextColor: Colors.white,
  highlightColor: Colors.green,
  highlightTextColor: Colors.black,
  unselectedDateColor: Colors.grey,
  unselectedDateTextColor: Colors.black,
  weekDayTextStyle: TextStyle(fontWeight: FontWeight.bold),
  
  // Action Buttons
  onOutlinePressed: () => print("Reset Button Pressed"),
  onFilledPressed: () => print("Confirm Button Pressed"),
  filledColor: Colors.blue,
  outlinedColor: Colors.red,
  filledButtonText: "Confirm",
  outlinedButtonText: "Reset",
  
  // Dropdown Options
  dropDownHintText: "Select a Month",
  dropDownItems: ["January", "February", "March"],
  dropDownOnChanged: (value) => print("Selected Month: \$value"),
);
```
## Parameters
### Date Selection
| Property | Type | Description |
|----------|------|-------------|
| `startDate` | `DateTime?` | Initial start date |
| `endDate` | `DateTime?` | Initial end date |
| `minDate` | `DateTime?` | Minimum selectable date |
| `maxDate` | `DateTime?` | Maximum selectable date |
| `onStartDateChanged` | `ValueChanged<DateTime?>?` | Callback when start date changes |
| `onEndDateChanged` | `ValueChanged<DateTime?>?` | Callback when end date changes |
| `onDateRangeChanged` | `ValueChanged<DateTimeRange?>?` | Callback when date range changes |

### Styling
| Property | Type | Description |
|----------|------|-------------|
| `selectedDateColor` | `Color?` | Color for selected dates |
| `selectedDateTextColor` | `Color?` | Text color for selected dates |
| `highlightColor` | `Color?` | Color for highlighted dates |
| `highlightTextColor` | `Color?` | Text color for highlighted dates |
| `unselectedDateColor` | `Color?` | Color for unselected dates |
| `unselectedDateTextColor` | `Color?` | Text color for unselected dates |
| `weekDayTextStyle` | `TextStyle?` | Text style for weekdays |

### Buttons
| Property | Type | Description |
|----------|------|-------------|
| `onOutlinePressed` | `VoidCallback?` | Callback for outline button |
| `onFilledPressed` | `VoidCallback?` | Callback for filled button |
| `filledColor` | `Color?` | Filled button color |
| `outlinedColor` | `Color?` | Outline button color |
| `filledButtonText` | `String?` | Text for filled button |
| `outlinedButtonText` | `String?` | Text for outlined button |

### Dropdown
| Property | Type | Description |
|----------|------|-------------|
| `dropDownHintText` | `String?` | Hint text for dropdown |
| `dropDownItems` | `List<String>?` | List of dropdown options |
| `dropDownOnChanged` | `ValueChanged<String?>?` | Callback when dropdown value changes |

### Screenshots
![WhatsApp Image 2025-02-06 at 12 19 38 PM (1)](https://github.com/user-attachments/assets/02f1b1c9-4ac5-4f1e-8565-9f93a9d198d9)
![WhatsApp Image 2025-02-06 at 12 19 37 PM](https://github.com/user-attachments/assets/6086a11a-9e14-4b03-8caf-4d3d5852fc50)
![WhatsApp Image 2025-02-06 at 12 19 37 PM (1)](https://github.com/user-attachments/assets/413b5f28-b186-4c1b-9e41-b2c7d7111650)
![WhatsApp Image 2025-02-06 at 12 19 37 PM (2)](https://github.com/user-attachments/assets/52fc1d3f-6b17-4744-a9c2-18581a8aa0bb)
![WhatsApp Image 2025-02-06 at 12 19 37 PM (3)](https://github.com/user-attachments/assets/e3f4ce26-021a-4d1f-b430-2f0a030191d1)
![WhatsApp Image 2025-02-06 at 12 19 38 PM](https://github.com/user-attachments/assets/7f1a29fb-b956-4b11-b789-7b5d2ecc7390)
https://github.com/user-attachments/assets/d7c1b6a0-18e9-4569-90f9-efd5eb007f4c

## License
This package is open-source and licensed under the MIT License.

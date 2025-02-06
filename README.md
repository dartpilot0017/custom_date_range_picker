# Custom Date Range Picker

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
  custom_daterange_picker: latest_version
```

Then, run:
```sh
flutter pub get
```

## Usage
### Import the Package
```dart
import 'package:date_range_picker/date_range_picker.dart';
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


![WhatsApp Image 2025-02-06 at 12 19 37 PM](https://github.com/user-attachments/assets/083da3af-961b-4e24-bb65-767db3152343)
![WhatsApp Image 2025-02-06 at 12 19 37 PM (1)](https://github.com/user-attachments/assets/8b233edf-997e-4d95-a439-f467c6487420)
![WhatsApp Image 2025-02-06 at 12 19 37 PM (2)](https://github.com/user-attachments/assets/b0e55be0-0a3f-4e11-a82d-4c743bd5a5ee)
![WhatsApp Image 2025-02-06 at 12 19 37 PM (3)](https://github.com/user-attachments/assets/95ba93ca-9b4d-460a-a79f-ba1695433e45)
![WhatsApp Image 2025-02-06 at 12 19 38 PM](https://github.com/user-attachments/assets/70866eeb-ee00-4cf5-a1c0-209577d6422d)
![WhatsApp Image 2025-02-06 at 12 19 38 PM (1)](https://github.com/user-attachments/assets/eaf6ea99-ea24-4013-9f40-6707a9fdcbd7)

https://github.com/user-attachments/assets/2694b3ff-ad44-4fec-a706-ed7bda47582c




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

## License
This package is open-source and licensed under the MIT License.
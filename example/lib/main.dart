import 'package:custom_date_range_plus/custom_date_range_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const ExampleApp());

const _repository = 'https://github.com/dartpilot0017/custom_date_range_picker';
const _package = 'https://pub.dev/packages/custom_date_range_plus';
const _accents = [Color(0xFF315B48), Color(0xFF465AC7), Color(0xFFAA5232)];

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  bool _dark = false;
  int _accent = 0;

  ThemeData _theme(Brightness brightness) => ThemeData(
        useMaterial3: true,
        brightness: brightness,
        colorSchemeSeed: _accents[_accent],
        scaffoldBackgroundColor: brightness == Brightness.light
            ? const Color(0xFFF6F5F0)
            : const Color(0xFF151B18),
        dividerTheme: const DividerThemeData(space: 1),
      );

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Custom Date Range Plus · Playground',
        debugShowCheckedModeBanner: false,
        themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
        theme: _theme(Brightness.light),
        darkTheme: _theme(Brightness.dark),
        home: Playground(
          dark: _dark,
          accent: _accent,
          onDarkChanged: (value) => setState(() => _dark = value),
          onAccentChanged: (value) => setState(() => _accent = value),
        ),
      );
}

class Playground extends StatefulWidget {
  const Playground({
    super.key,
    required this.dark,
    required this.accent,
    required this.onDarkChanged,
    required this.onAccentChanged,
  });

  final bool dark;
  final int accent;
  final ValueChanged<bool> onDarkChanged;
  final ValueChanged<int> onAccentChanged;

  @override
  State<Playground> createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  // A fixed sample makes screenshots and copied examples reproducible.
  DateTimeRange? _range =
      DateTimeRange(start: DateTime(2026, 11, 10), end: DateTime(2026, 11, 17));
  DateTimeRange? _liveRange =
      DateTimeRange(start: DateTime(2026, 11, 10), end: DateTime(2026, 11, 17));
  bool _mondayFirst = true;
  bool _bounded = false;
  bool _actions = true;
  String _mode = 'Inline';
  int _revision = 0;

  DateTime get _min => _bounded ? DateTime(2026, 11, 5) : DateTime(2020);
  DateTime get _max =>
      _bounded ? DateTime(2026, 11, 25) : DateTime(2035, 12, 31);

  void _setRange(DateTimeRange? range) => setState(() => _range = range);

  Future<void> _copy(String text, String label) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$label copied'),
        duration: const Duration(seconds: 2),
      ));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Clipboard unavailable. Select and copy the code below.')));
    }
  }

  Future<void> _openLink(String url) async {
    if (!await launchUrl(Uri.parse(url)) && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: SelectableText('Open this link: $url')));
    }
  }

  String _dateCode(DateTime date) =>
      'DateTime(${date.year}, ${date.month}, ${date.day})';

  String get _code {
    final dates = _range == null
        ? ''
        : '  startDate: ${_dateCode(_range!.start)},\n'
            '  endDate: ${_dateCode(_range!.end)},\n';
    final body = 'DateRangePicker(\n'
        '$dates  minDate: ${_dateCode(_min)},\n'
        '  maxDate: ${_dateCode(_max)},\n'
        '  firstDayOfWeek: DateTime.${_mondayFirst ? 'monday' : 'sunday'},\n'
        '  showActionButtons: $_actions,\n'
        "  filledButtonText: 'Apply range',\n"
        "  outlinedButtonText: 'Reset',\n"
        '${_actions ? '  onConfirm: (range) {\n    // Use range.start and range.end.\n  },' : '  onSelectionChanged: (range) {\n    // null until both dates are selected.\n  },'}\n'
        ')';
    final String usage;
    if (_mode == 'Inline') {
      usage = '$body;';
    } else {
      final opener = _mode == 'Dialog'
          ? 'showDialog<DateTimeRange>'
          : 'showModalBottomSheet<DateTimeRange>';
      final child = body.replaceFirst(
          _actions
              ? '    // Use range.start and range.end.'
              : '    // null until both dates are selected.',
          _actions
              ? '    Navigator.of(pickerContext).pop(range);'
              : '    // Observe the draft; add your own confirmation UI.');
      final wrapped = _mode == 'Dialog'
          ? 'Dialog(\n      child: Padding(\n        padding: const EdgeInsets.all(24),\n        child: SizedBox(width: 400, child: ${child.replaceAll('\n', '\n        ')}),\n      ),\n    )'
          : 'SafeArea(\n      child: Padding(\n        padding: const EdgeInsets.all(24),\n        child: ${child.replaceAll('\n', '\n        ')},\n      ),\n    )';
      usage = 'final range = await $opener(\n  context: context,\n'
          '${_mode == 'Bottom sheet' ? '  isScrollControlled: true,\n' : ''}'
          '  builder: (pickerContext) => $wrapped,\n);';
    }
    return "import 'package:flutter/material.dart';\n"
        "import 'package:custom_date_range_plus/custom_date_range_plus.dart';\n\n"
        '// Add this colorSchemeSeed to your MaterialApp ThemeData:\n'
        '// Color(0x${_accents[widget.accent].toARGB32().toRadixString(16).toUpperCase()})\n'
        '// Place the example below inside your widget or event handler.\n'
        '$usage';
  }

  Widget _picker({BuildContext? routeContext}) => DateRangePicker(
        key: ValueKey('picker_$_revision'),
        startDate: _range?.start,
        endDate: _range?.end,
        minDate: _min,
        maxDate: _max,
        firstDayOfWeek: _mondayFirst ? DateTime.monday : DateTime.sunday,
        showActionButtons: _actions,
        filledButtonText: 'Apply range',
        outlinedButtonText: 'Reset',
        onSelectionChanged: !_actions && routeContext == null
            ? (range) => setState(() => _liveRange = range)
            : null,
        onDateRangeChanged: routeContext == null ? _setRange : null,
        onConfirm: routeContext == null
            ? null
            : (range) => Navigator.of(routeContext).pop(range),
      );

  Future<void> _openPicker() async {
    final DateTimeRange? result;
    Widget content(BuildContext routeContext) => Padding(
          padding: const EdgeInsets.all(24),
          child:
              SizedBox(width: 400, child: _picker(routeContext: routeContext)),
        );
    if (_mode == 'Dialog') {
      result = await showDialog<DateTimeRange>(
        context: context,
        builder: (context) => Dialog(child: content(context)),
      );
    } else {
      result = await showModalBottomSheet<DateTimeRange>(
        context: context,
        isScrollControlled: true,
        constraints: BoxConstraints(
            maxWidth: 480, maxHeight: MediaQuery.sizeOf(context).height * .9),
        builder: (context) => SafeArea(child: content(context)),
      );
    }
    if (!mounted || result == null) return;
    _setRange(result);
  }

  Widget _tag(String text) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(text, style: Theme.of(context).textTheme.labelSmall),
      );

  Widget _panel(
          {required Widget child,
          EdgeInsets padding = const EdgeInsets.all(24)}) =>
      Material(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(padding: padding, child: child),
      );

  Widget _preview() {
    final colors = Theme.of(context).colorScheme;
    final visibleRange = _actions ? _range : _liveRange;
    return _panel(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Wrap(
          spacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: colors.primary, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text('LIVE PREVIEW',
                  style: Theme.of(context).textTheme.labelSmall),
            ]),
            TextButton.icon(
              onPressed: () => setState(() {
                _range = DateTimeRange(
                    start: DateTime(2026, 11, 10), end: DateTime(2026, 11, 17));
                _liveRange = _range;
                _revision++;
              }),
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Restore sample'),
            ),
          ]),
      const SizedBox(height: 12),
      Wrap(spacing: 8, runSpacing: 8, children: [
        for (final mode in ['Inline', 'Dialog', 'Bottom sheet'])
          ChoiceChip(
              label: Text(mode),
              selected: _mode == mode,
              onSelected: (_) => setState(() {
                    _mode = mode;
                    if (mode != 'Inline') _actions = true;
                  })),
      ]),
      const SizedBox(height: 24),
      if (_mode == 'Inline')
        Center(child: _picker())
      else
        Container(
          constraints: const BoxConstraints(minHeight: 350),
          alignment: Alignment.center,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(
                _mode == 'Dialog'
                    ? Icons.web_asset_outlined
                    : Icons.vertical_align_bottom,
                size: 40,
                color: colors.primary),
            const SizedBox(height: 20),
            Text(
                _mode == 'Dialog'
                    ? 'A focused moment to choose.'
                    : 'Keep your screen in context.',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 8),
            const Text('Your settings come along.',
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            FilledButton.icon(
                onPressed: _openPicker,
                icon: const Icon(Icons.open_in_new, size: 18),
                label: Text('Open ${_mode.toLowerCase()}')),
          ]),
        ),
      const SizedBox(height: 24),
      const Divider(),
      const SizedBox(height: 20),
      Text(_actions ? 'CONFIRMED RANGE' : 'LIVE SELECTION',
          style: Theme.of(context).textTheme.labelSmall),
      const SizedBox(height: 8),
      Text(
          visibleRange == null
              ? 'Choose a start and end date'
              : '${MaterialLocalizations.of(context).formatMediumDate(visibleRange.start)}  →  ${MaterialLocalizations.of(context).formatMediumDate(visibleRange.end)}',
          key: const Key('range_summary'),
          style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 4),
      Text('Dates are inclusive. Tap again to start a new range.',
          style: Theme.of(context).textTheme.bodySmall),
    ]));
  }

  Widget _settings() => _panel(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Make it yours', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        const Text('A few options. A different feel.'),
        const SizedBox(height: 24),
        Text('ACCENT', style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (var i = 0; i < _accents.length; i++)
            ChoiceChip(
              avatar: CircleAvatar(backgroundColor: _accents[i], radius: 7),
              label: Text(['Forest', 'Indigo', 'Clay'][i]),
              selected: widget.accent == i,
              onSelected: (_) => widget.onAccentChanged(i),
            ),
        ]),
        const SizedBox(height: 20),
        SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Dark appearance'),
            value: widget.dark,
            onChanged: widget.onDarkChanged),
        SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Monday first'),
            value: _mondayFirst,
            onChanged: (value) => setState(() => _mondayFirst = value)),
        SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Limit selectable dates'),
            subtitle: const Text('November 5–25, 2026'),
            value: _bounded,
            onChanged: (value) => setState(() {
                  _bounded = value;
                  _range = DateTimeRange(
                      start: DateTime(2026, 11, 10),
                      end: DateTime(2026, 11, 17));
                  _liveRange = _range;
                  _revision++;
                })),
        SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Built-in action buttons'),
            subtitle: Text(_mode == 'Inline'
                ? 'Turn off for live selection'
                : 'Confirmation is required in overlays'),
            value: _actions,
            onChanged: _mode == 'Inline'
                ? (value) => setState(() {
                      _actions = value;
                      _liveRange = _range;
                      _revision++;
                    })
                : null),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 20),
        const Text('This is the real Flutter widget.',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        const Text(
            'The preview uses the package in this repository. The code below follows your settings.'),
      ]));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth >= 900;
      return SingleChildScrollView(
          child: Center(
              child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth < 600 ? 20 : 40),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 24),
            Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 24,
                runSpacing: 12,
                children: [
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.date_range_rounded,
                        color: theme.colorScheme.primary),
                    const SizedBox(width: 10),
                    const Text('custom_date_range_plus',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ]),
                  Wrap(spacing: 8, runSpacing: 8, children: [
                    TextButton(
                        onPressed: () => _openLink(_repository),
                        child: const Text('Source ↗')),
                    OutlinedButton(
                        onPressed: () => _openLink(_package),
                        child: const Text('View on pub.dev ↗')),
                  ]),
                ]),
            const SizedBox(height: 48),
            Wrap(spacing: 8, runSpacing: 8, children: [
              _tag('FLUTTER PACKAGE'),
              _tag('0.1.0 PREVIEW'),
            ]),
            const SizedBox(height: 20),
            Text('Your dates.\nYour design.',
                style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: wide ? 68 : 44,
                    fontWeight: FontWeight.w700,
                    height: 1.03,
                    letterSpacing: -2)),
            const SizedBox(height: 20),
            ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 610),
                child: Text(
                    'A date range picker that feels at home in your app.\nTry the interactions, tune the details, take the code.',
                    style: theme.textTheme.titleMedium?.copyWith(
                        height: 1.6, fontWeight: FontWeight.normal))),
            const SizedBox(height: 24),
            Wrap(spacing: 24, runSpacing: 12, children: [
              for (final label in [
                'Inline, dialog & sheet',
                'Theme-aware',
                'Flutter-only runtime'
              ])
                Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.check, size: 16, color: theme.colorScheme.primary),
                  const SizedBox(width: 6),
                  Text(label, style: theme.textTheme.bodySmall),
                ]),
            ]),
            const SizedBox(height: 40),
            if (wide)
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(flex: 6, child: _preview()),
                const SizedBox(width: 24),
                Expanded(flex: 4, child: _settings()),
              ])
            else ...[_preview(), const SizedBox(height: 20), _settings()],
            const SizedBox(height: 32),
            _panel(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Wrap(
                      spacing: 20,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('From playground to your app',
                            style: theme.textTheme.titleLarge),
                        OutlinedButton.icon(
                            key: const Key('copy_code'),
                            onPressed: () => _copy(_code, 'Example'),
                            icon: const Icon(Icons.copy, size: 16),
                            label: const Text('Copy Dart example')),
                      ]),
                  const SizedBox(height: 12),
                  const Text(
                      'Preview API · use the repository checkout until 0.1.0 is published.'),
                  const SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SelectableText(_code,
                              key: const Key('code_example'),
                              style: const TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 13,
                                  height: 1.7)))),
                ])),
            const SizedBox(height: 32),
            _panel(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Try the preview locally',
                      style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  const Text(
                      'Clone the repository and run the example. No API keys or account required.'),
                  const SizedBox(height: 16),
                  const SelectableText(
                      'git clone https://github.com/dartpilot0017/custom_date_range_picker.git\n'
                      'cd custom_date_range_picker/example\nflutter pub get\nflutter run -d chrome',
                      style: TextStyle(fontFamily: 'monospace', height: 1.7)),
                ])),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            Wrap(spacing: 24, runSpacing: 12, children: [
              Text('Built for Flutter. Open source. MIT licensed.',
                  style: theme.textTheme.bodySmall),
              TextButton(
                  onPressed: () => _openLink('$_repository/issues'),
                  child: const Text('Feedback & issues ↗')),
            ]),
            const SizedBox(height: 32),
          ]),
        ),
      )));
    })));
  }
}

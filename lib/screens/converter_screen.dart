import 'package:flutter/material.dart';
import '../models/unit.dart';
import '../widgets/custom_drawer.dart';

class ConverterScreen extends StatefulWidget {
  final String categoryName;
  final List<Unit> units;

  const ConverterScreen({
    required this.categoryName,
    required this.units,
    Key? key,
  }) : super(key: key);

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  Unit? _fromUnit;
  Unit? _toUnit;
  String _input = '';
  String _converted = '';

  @override
  void initState() {
    super.initState();
    if (widget.units.isNotEmpty) {
      _fromUnit = widget.units.first;
      _toUnit = widget.units.length > 1 ? widget.units[1] : widget.units[0];
    }
  }

  void _convert() {
    if (_input.isEmpty || _fromUnit == null || _toUnit == null) return;

    double inputVal = double.tryParse(_input) ?? 0.0;
    double result;

    if (_fromUnit!.isFormula && _toUnit!.isFormula) {
      result = _convertWithFormula(inputVal, _fromUnit!.name, _toUnit!.name);
    } else {
      result = inputVal * _fromUnit!.conversion / _toUnit!.conversion;
    }

    setState(() {
      _converted = result.toStringAsFixed(4);
    });
  }

  double _convertWithFormula(double value, String from, String to) {
    if (from == to) return value;

    if (from == 'Celsius' && to == 'Fahrenheit') return value * 9 / 5 + 32;
    if (from == 'Fahrenheit' && to == 'Celsius') return (value - 32) * 5 / 9;

    return value;
  }

  @override
  Widget build(BuildContext context) {
    if (_fromUnit == null || _toUnit == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter value',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  _input = val;
                  _convert();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<Unit>(
                    isExpanded: true,
                    value: _fromUnit,
                    items: widget.units
                        .map((u) => DropdownMenuItem<Unit>(
                              value: u,
                              child: Text('${u.name} (${u.symbol})'),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _fromUnit = val;
                          _convert();
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(Icons.swap_horiz),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButton<Unit>(
                    isExpanded: true,
                    value: _toUnit,
                    items: widget.units
                        .map((u) => DropdownMenuItem<Unit>(
                              value: u,
                              child: Text('${u.name} (${u.symbol})'),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() {
                          _toUnit = val;
                          _convert();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Result: $_converted ${_toUnit!.symbol}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

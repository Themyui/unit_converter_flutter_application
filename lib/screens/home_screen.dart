import 'package:flutter/material.dart';
import '../screens/converter_screen.dart';
import '../models/unit.dart';

class HomeScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;

  const HomeScreen({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Length', 'icon': Icons.straighten, 'color': Colors.blue},
    {'name': 'Mass', 'icon': Icons.line_weight, 'color': Colors.green},
    {'name': 'Temperature', 'icon': Icons.thermostat, 'color': Colors.red},
    {'name': 'Time', 'icon': Icons.access_time, 'color': Colors.orange},
    {'name': 'Area', 'icon': Icons.square_foot, 'color': Colors.purple},
    {'name': 'Volume', 'icon': Icons.local_drink, 'color': Colors.indigo},
    {'name': 'Speed', 'icon': Icons.speed, 'color': Colors.teal},
    {'name': 'Pressure', 'icon': Icons.compress, 'color': Colors.cyan},
    {'name': 'Energy', 'icon': Icons.bolt, 'color': Colors.amber},
    {'name': 'Power', 'icon': Icons.electrical_services, 'color': Colors.deepOrange},
    {'name': 'Data', 'icon': Icons.sd_storage, 'color': Colors.brown},
    {'name': 'Frequency', 'icon': Icons.wifi, 'color': Colors.deepPurple},
    {'name': 'Angle', 'icon': Icons.rotate_right, 'color': Colors.lightGreen},
    {'name': 'Fuel Economy', 'icon': Icons.local_gas_station, 'color': Colors.lime},
    {'name': 'Digital Image', 'icon': Icons.image, 'color': Colors.pinkAccent},
  ];

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('Light'),
              onTap: () {
                Navigator.pop(context);
                widget.onThemeChanged(ThemeMode.light);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark'),
              onTap: () {
                Navigator.pop(context);
                widget.onThemeChanged(ThemeMode.dark);
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone_android),
              title: const Text('System Default'),
              onTap: () {
                Navigator.pop(context);
                widget.onThemeChanged(ThemeMode.system);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showThemeDialog(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Unit Converter',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                _showThemeDialog(context);
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            color: category['color'].withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(category['icon'], color: category['color']),
              title: Text(
                category['name'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ConverterScreen(
                      categoryName: category['name'],
                      units: _getUnitsForCategory(category['name']),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  List<Unit> _getUnitsForCategory(String name) {
    switch (name) {
      case 'Length':
        return [
          Unit(name: 'Meter', symbol: 'm', conversion: 1.0),
          Unit(name: 'Kilometer', symbol: 'km', conversion: 1000.0),
          Unit(name: 'Centimeter', symbol: 'cm', conversion: 0.01),
          Unit(name: 'Inch', symbol: 'in', conversion: 0.0254),
          Unit(name: 'Mile', symbol: 'mi', conversion: 1609.34),
        ];
      case 'Mass':
        return [
          Unit(name: 'Gram', symbol: 'g', conversion: 1.0),
          Unit(name: 'Kilogram', symbol: 'kg', conversion: 1000.0),
          Unit(name: 'Pound', symbol: 'lb', conversion: 453.592),
        ];
      case 'Temperature':
        return [
          Unit(name: 'Celsius', symbol: '°C', conversion: 1.0, isFormula: true),
          Unit(name: 'Fahrenheit', symbol: '°F', conversion: 1.0, isFormula: true),
        ];
        case 'Time':
        return [
          Unit(name: 'Second', symbol: 's', conversion: 1.0),
          Unit(name: 'Minute', symbol: 'min', conversion: 60.0),
          Unit(name: 'Hour', symbol: 'h', conversion: 3600.0),
        ];
      case 'Area':
        return [
          Unit(name: 'Square Meter', symbol: 'm²', conversion: 1.0),
          Unit(name: 'Square Kilometer', symbol: 'km²', conversion: 1e6),
          Unit(name: 'Square Foot', symbol: 'ft²', conversion: 0.092903),
          Unit(name: 'Acre', symbol: 'ac', conversion: 4046.86),
          Unit(name: 'Hectare', symbol: 'ha', conversion: 10000.0),
        ];
      case 'Volume':
        return [
          Unit(name: 'Cubic Meter', symbol: 'm³', conversion: 1.0),
          Unit(name: 'Liter', symbol: 'L', conversion: 0.001),
          Unit(name: 'Milliliter', symbol: 'mL', conversion: 0.000001),
          Unit(name: 'Gallon (US)', symbol: 'gal', conversion: 0.00378541),
          Unit(name: 'Cubic Inch', symbol: 'in³', conversion: 0.0000163871),
        ];
      case 'Speed':
        return [
          Unit(name: 'Meter per second', symbol: 'm/s', conversion: 1.0),
          Unit(name: 'Kilometer per hour', symbol: 'km/h', conversion: 0.277778),
          Unit(name: 'Miles per hour', symbol: 'mph', conversion: 0.44704),
          Unit(name: 'Knot', symbol: 'kn', conversion: 0.514444),
        ];
      case 'Pressure':
        return [
          Unit(name: 'Pascal', symbol: 'Pa', conversion: 1.0),
          Unit(name: 'Bar', symbol: 'bar', conversion: 100000.0),
          Unit(name: 'Atmosphere', symbol: 'atm', conversion: 101325.0),
          Unit(name: 'PSI', symbol: 'psi', conversion: 6894.76),
        ];
      case 'Energy':
        return [
          Unit(name: 'Joule', symbol: 'J', conversion: 1.0),
          Unit(name: 'Kilojoule', symbol: 'kJ', conversion: 1000.0),
          Unit(name: 'Calorie', symbol: 'cal', conversion: 4.184),
          Unit(name: 'Kilocalorie', symbol: 'kcal', conversion: 4184.0),
          Unit(name: 'Watt-hour', symbol: 'Wh', conversion: 3600.0),
        ];
      case 'Power':
        return [
          Unit(name: 'Watt', symbol: 'W', conversion: 1.0),
          Unit(name: 'Kilowatt', symbol: 'kW', conversion: 1000.0),
          Unit(name: 'Horsepower', symbol: 'hp', conversion: 745.7),
        ];
      case 'Data':
        return [
          Unit(name: 'Bit', symbol: 'b', conversion: 1.0),
          Unit(name: 'Byte', symbol: 'B', conversion: 8.0),
          Unit(name: 'Kilobyte', symbol: 'KB', conversion: 8192.0),
          Unit(name: 'Megabyte', symbol: 'MB', conversion: 8388608.0),
          Unit(name: 'Gigabyte', symbol: 'GB', conversion: 8589934592.0),
        ];
      case 'Frequency':
        return [
          Unit(name: 'Hertz', symbol: 'Hz', conversion: 1.0),
          Unit(name: 'Kilohertz', symbol: 'kHz', conversion: 1000.0),
          Unit(name: 'Megahertz', symbol: 'MHz', conversion: 1e6),
        ];
      case 'Angle':
        return [
          Unit(name: 'Degree', symbol: '°', conversion: 1.0),
          Unit(name: 'Radian', symbol: 'rad', conversion: 57.2958),
        ];
      case 'Fuel Economy':
        return [
          Unit(name: 'Km per Liter', symbol: 'km/L', conversion: 1.0),
          Unit(name: 'Miles per Gallon', symbol: 'mpg', conversion: 0.425144),
        ];
      case 'Digital Image':
        return [
          Unit(name: 'DPI', symbol: 'dpi', conversion: 1.0),
          Unit(name: 'PPI', symbol: 'ppi', conversion: 1.0),
        ];
      // Add the rest as needed...
      default:
        return [Unit(name: 'Unknown', symbol: '', conversion: 1.0)];
    }
  }
}

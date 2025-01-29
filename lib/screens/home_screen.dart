import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../services/weather_service.dart';
import '../screens/add_edit_task_screen.dart';
import '../widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  bool _isLoadingWeather = false;
  String _city = 'London'; // Default city

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoadingWeather = true;
    });

    print('Fetching weather for: $_city'); // Debugging

    try {
      final data = await _weatherService.fetchWeather(_city);
      print('Weather API Response: $data'); // Debugging
      setState(() {
        _weatherData = data;
      });
    } catch (error) {
      print('Error fetching weather: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather: ${error.toString()}')),
      );
    } finally {
      setState(() {
        _isLoadingWeather = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '📋 MyTasker',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF81C784)], // Green theme
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return _buildPortraitLayout(taskProvider);
                } else {
                  return _buildLandscapeLayout(taskProvider);
                }
              },
            ),
          ),
          _buildWeatherWidget(),
        ],
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  /// **Portrait Layout (Mobile)**
  Widget _buildPortraitLayout(TaskProvider taskProvider) {
    return Column(
      children: [
        Expanded(child: _buildTaskList(taskProvider)),
      ],
    );
  }

  /// **Landscape Layout (Tablet/Desktop)**
  Widget _buildLandscapeLayout(TaskProvider taskProvider) {
    return Row(
      children: [
        Expanded(flex: 2, child: _buildTaskList(taskProvider)),
      ],
    );
  }

  /// **Task List - Adaptive UI**
  Widget _buildTaskList(TaskProvider taskProvider) {
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Padding(
      padding: EdgeInsets.all(isTablet ? 32.0 : 16.0),
      child: ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: isTablet ? 12.0 : 6.0),
            child: TaskCard(task: taskProvider.tasks[index]),
          );
        },
      ),
    );
  }

  /// **Weather Widget - Fixed to Show Correct City & Smaller Size**
  Widget _buildWeatherWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.08),
        child: GestureDetector(
          onTap: _showCityInputModal,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.15, // Smaller size
            height: MediaQuery.of(context).size.width * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.pink, Colors.orange], // Match + button colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
              ],
            ),
            child: _isLoadingWeather
                ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_weatherData?['current']?['temp_c'] ?? '--'}°C',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${_weatherData?['location']?['name'] ?? 'City'}',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  /// **Fixed City Input Modal to Update `_city` Correctly**
  void _showCityInputModal() {
    String newCity = _city; // Store the current city

    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter City',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                newCity = value.trim(); // Store entered value
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (newCity.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('City name cannot be empty.')),
                  );
                  return;
                }
                setState(() {
                  _city = newCity; // Update _city with new input
                });
                Navigator.of(context).pop();
                _fetchWeather(); // Fetch new weather data
              },
              child: Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }

  /// **Floating Action Button (For Adding New Tasks)**
  Widget _buildFloatingButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => AddEditTaskScreen()),
        );
      },
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Colors.pink, Colors.orange], // Same as weather widget
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.pink.withOpacity(0.6),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "➕",
            style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

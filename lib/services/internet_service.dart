import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetService {
  // Private constructor
  InternetService._privateConstructor();

  // The single instance of the class
  static final InternetService _instance = InternetService._privateConstructor();

  // Factory constructor to return the same instance
  factory InternetService() {
    return _instance;
  }

  // StreamController to handle connectivity changes
  final StreamController<bool> _connectivityController = StreamController<bool>.broadcast();

  // The stream to listen to connectivity changes
  Stream<bool> get connectivityStream => _connectivityController.stream;

  // Listen to connectivity changes and notify listeners
  void _listenToConnectivity() {
    // Listen to the onConnectivityChanged stream which now returns a List<ConnectivityResult>
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> resultList) {
      // Check if there is any connectivity in the result list
      bool isConnected = resultList.isNotEmpty && resultList.contains(ConnectivityResult.wifi) || resultList.contains(ConnectivityResult.mobile);
      _connectivityController.add(isConnected);  // Notify listeners about the connection status
    });
  }

  /// Initialize the service and start listening to connectivity changes
  void initialize() {
    _listenToConnectivity();
  }

  // Method to check internet connectivity
  Future<bool> isInternetAvailable() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Clean up resources
  void dispose() {
    _connectivityController.close();
  }
}
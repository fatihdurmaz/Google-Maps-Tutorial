# Google Maps in SwiftUI Tutorial
![Swift](https://img.shields.io/badge/Swift-5.10-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%20-red.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Version](https://img.shields.io/badge/iOS-18-green.svg)

Welcome to the **Google Maps in SwiftUI Tutorial**! This guide walks you through integrating and using Google Maps in a SwiftUI-based iOS application. By the end, you’ll have a functioning app that displays Google Maps, handles user location updates, and provides interactivity with markers and gestures.

---

## Features

1. **Google Maps Integration**: Add Google Maps to your SwiftUI app.
2. **Location Tracking**: Display and update the user's current location in real-time.
3. **Map Interactivity**:
    - Add markers with custom titles and descriptions.
    - Handle tap, long press, and drag gestures on the map.
4. **Custom Camera Control**: Dynamically move and animate the map camera.
5. **Custom UI Events**: Respond to marker taps, info window interactions, and map type changes.

---

## Requirements

1. **Xcode 15+**
2. **Swift 5.10+**
3. **Google Maps SDK for iOS**
4. **Swift Package Manager (SPM)**

---

## Setup Instructions

### Step 1: Install Google Maps SDK

Add the Google Maps SDK to your project using SPM.

### Using Swift Package Manager:

1. In Xcode, go to **File > Add Packages**.
2. Add the following package URL:
    
    ```bash
    [https://github.com/googlemaps/google-maps-ios](https://github.com/googlemaps/ios-maps-sdk)
    ```
    

---

### Step 2: Add API Key

1. Generate an API Key from the Google Cloud Console.
2. Add the API Key to your `AppDelegate`:
    
    ```swift
    GMSServices.provideAPIKey("YourApiKey")
    ```
    

---

### Step 3: Configure Location Permissions

Update the `Info.plist` file with the following keys to request location permissions:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to provide better map services.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>We need your location to provide better map services.</string
```

---

### Step 4: Add `GoogleMapView`

The `GoogleMapView` struct wraps the `GMSMapView` for use in SwiftUI.

### Key Code Highlights:

1. **Enable User Location**:
    
    ```swift
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
    ```
    
2. **Handle User Location Updates**:
    
    ```swift
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let cameraUpdate = GMSCameraUpdate.setTarget(location.coordinate, zoom: 18)
        mapView.animate(with: cameraUpdate)
    }
    ```
    
3. **Add and Remove Markers**:
    - **Add Marker**:
        
        ```swift
        let marker = GMSMarker(position: coordinate)
        marker.title = "New Marker"
        marker.snippet = "Lat: \(coordinate.latitude), Long: \(coordinate.longitude)"
        marker.map = mapView
        ```
        
    - **Remove Marker**:
        
        ```swift
        marker.map = nil
        ```
        
4. **Handle Map Gestures**:
    - Tap, long press, and drag interactions:
        
        ```swift
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) { }
        func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) { }
        func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) { }
        ```
        

---

### Step 5: Build the SwiftUI Interface

The `ContentView` embeds the `GoogleMapView` into a SwiftUI layout:

```swift
struct ContentView: View {
    var body: some View {
        ZStack {
            GoogleMapView()
        }
        .ignoresSafeArea(.all)
    }
}
```

---

### Final Step: Run the Application

- Build and run your application on a physical device or simulator.
- Interact with the map to see real-time location updates, marker interactions, and camera movements.

---

## Customization Options

- **Map Types**:
Change the map type dynamically using:
    
    ```swift
    mapView.mapType = .satellite
    ```
    
- **Zoom Levels**:
Adjust the zoom level using:
    
    ```swift
    GMSCameraUpdate.zoom(to: 15)
    ```
    

---

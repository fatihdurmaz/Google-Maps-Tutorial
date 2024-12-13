//
//  GoogleMapView.swift
//  Google Maps Tutorial
//
//  Created by Fatih Durmaz on 14.11.2024.
//

import SwiftUI
import GoogleMaps
import Observation


struct GoogleMapView: UIViewRepresentable {
    private let locationManager = CLLocationManager()
    var mapView = GMSMapView()
    
    func makeUIView(context: Context) -> GMSMapView {
        mapView.isMyLocationEnabled = true
        mapView.delegate = context.coordinator
        mapView.settings.myLocationButton = true
        locationManager.delegate = context.coordinator // Coordinator'ı delegate olarak atıyoruz
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() // canlı konum güncellemeleri

        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, mapView: mapView) // Coordinator'a mapView'i geçiyoruz
    }
    
    class Coordinator: NSObject, GMSMapViewDelegate, CLLocationManagerDelegate {
        
        var parent: GoogleMapView
        var mapView: GMSMapView // mapView referansı
        
        init(_ parent: GoogleMapView, mapView: GMSMapView) {
            self.parent = parent
            self.mapView = mapView
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            let cameraUpdate = GMSCameraUpdate.setTarget(location.coordinate, zoom: 18 )
            mapView.animate(with: cameraUpdate) // Kamerayı yeni konuma taşıyoruz
        }
        
        
        // Tıkladığınız koordinatın enlem ve boylam bilgilerini yazdırır
        func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
            print("Tapped at coordinate: \(coordinate.latitude), \(coordinate.longitude)")
            let marker = GMSMarker(position: coordinate)
             marker.title = "New Marker"
             marker.snippet = "Lat: \(coordinate.latitude), Long: \(coordinate.longitude)"
             marker.map = mapView
             mapView.selectedMarker = marker
            
        }
        
        // Harita üzerindeki bir marker'a tıklanırsa, marker'ın başlığını yazdırır
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            // Marker başlığını kontrol ederiz; eğer başlık yoksa "No Title" olarak yazdırılır
            print("Tapped marker with title: \(marker.title ?? "No Title")")
            marker.map = nil // Markerı siler.
            return true  // true döndürmek, varsayılan işlevselliğin devam etmesini engeller
        }
        
        // Kullanıcı harita üzerinde uzun basma işlemi gerçekleştirdiğinde, tıklanan koordinatları yazdırır
        func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
            print("Long pressed at coordinate: \(coordinate.latitude), \(coordinate.longitude)")
        }
        
        // Kameranın (harita görüntüsünün) pozisyonu değiştiğinde, yeni konumu yazdırır
        func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
            // Kameranın hedef koordinatını (yani haritanın merkezini) yazdırır
            print("Camera position changed to: \(position.target.latitude), \(position.target.longitude)")
        }
        
        // Harita kaydırılmadan önce çağrılır. 'gesture' parametresi, bu işlemin bir dokunma hareketiyle (gesture) olup olmadığını belirler
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            print("Map will move. Gesture is: \(gesture)")  // true ise hareket, false ise programatik bir hareket olabilir
        }
        
        // Kullanıcı bir marker'ı sürüklemeyi tamamladığında, marker'ın başlığını yazdırır
        func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
            // Marker'ı sürükledikten sonra işlemler yapılabilir, örneğin marker'ın yeni pozisyonunu alabilirsiniz
            print("Ended dragging marker with title: \(marker.title ?? "No Title")")
        }
        
        // Kullanıcı marker'ın bilgi penceresini (info window) tıkladığında, marker'ın başlığını yazdırır
        func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
            // Info window, genellikle marker'a tıklanınca açılan küçük pencere içerir.
            print("Tapped info window of marker with title: \(marker.title ?? "No Title")")
        }
        
        // Harita türü (örneğin: Normal, Satellite, Terrain) değiştiğinde, yeni harita türünü yazdırır
        func mapView(_ mapView: GMSMapView, didChangeTo mapType: GMSMapViewType) {
            // Kullanıcı harita türünü değiştirdiğinde ne tür bir harita kullanıldığını yazdırır
            print("Map type changed to: \(mapType.rawValue)")  // rawValue, harita türünün sayısal değeri olabilir
        }
        
        // Kullanıcı 'My Location' butonuna tıkladığında çağrılır. Burada butona tıklanma bilgisi işlenebilir
        func mapView(_ mapView: GMSMapView, didTapMyLocationButton button: UIButton) -> Bool {
            // Bu buton, kullanıcının konumunu haritada merkezi hale getirir
            print("Tapped My Location button")
            return true  // true döndürmek, butonun varsayılan işlevselliğini engellemez
        }
    }
    
    
}

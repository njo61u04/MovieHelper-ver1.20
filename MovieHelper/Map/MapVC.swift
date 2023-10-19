//
//  MapVC.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/8/4.
//

import UIKit
import MapKit
import CoreLocation


class MapVC: UIViewController{
        
    let locationManager = CLLocationManager()
    private var places:  [PlaceAnnotation] = []
    
    @IBOutlet weak var mainMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMapView.delegate = self
        //request permission
        locationManager.requestAlwaysAuthorization()
        //request location
        locationManager.delegate = self
        //設定準確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        //回報位置
        locationManager.startUpdatingLocation()
        
        findNearbyPlaces(by: "電影")
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        if let userLocation = mainMapView.userLocation.location {
                let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
                mainMapView.setRegion(region, animated: true)
            }
    }
    
    private func presentPlacesSheet(place: PlaceAnnotation) {
        
        let placeInfoVC = PlaceInfoViewController(place: place)
        placeInfoVC.modalPresentationStyle = .pageSheet
        
        if let sheet = placeInfoVC.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.medium(), .medium()]
            present(placeInfoVC, animated: true)
        }
    }
    
    //MARK: 找附近地點
    private func findNearbyPlaces(by query: String) {
                
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = mainMapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            if let error = error  {
                print("Search  Failed: \(error)")
                return
            }
            guard let response = response else {
                assertionFailure("Search Failed")
                return
            }
            self?.places = response.mapItems.map(PlaceAnnotation.init)
            self?.places.forEach { place in
                place.title = place.name
                place.subtitle = place.address
                self?.mainMapView.addAnnotation(place)
            }
        }
    }
}

extension MapVC : CLLocationManagerDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard let currentLocation = userLocation.location else {
            assertionFailure("Get user location fail!!!!")
            return
        }
        let region = MKCoordinateRegion(center: currentLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation() // Stop updating after initial setup
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        findNearbyPlaces(by: "theater")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation{
            return nil
        }
        let theaterID = "theater"//為圖標取名
        var result = mapView.dequeueReusableAnnotationView(withIdentifier: theaterID) as? MKMarkerAnnotationView//使圖標可以重複利用
        if result == nil {
            result = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: theaterID)
        }else {
            result?.annotation = annotation
        }
        
        result?.markerTintColor = .systemPurple
        result?.glyphImage = UIImage(named: "camera.png")
        
        let button = UIButton(type: .detailDisclosure)
        button.tintColor = .systemPurple
        result?.rightCalloutAccessoryView = button
        
        result?.canShowCallout = true
        return result
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            guard let theater = view.annotation as? PlaceAnnotation else {
                assertionFailure("Get theater faill!!!!")
                return
            }
            self.presentPlacesSheet(place: theater)
        }
    }
}
    

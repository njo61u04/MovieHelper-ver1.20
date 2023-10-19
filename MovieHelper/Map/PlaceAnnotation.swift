//
//  Location.swift
//  MovieHelper
//
//  Created by 王靖雲 on 2023/8/12.
//

import Foundation
import MapKit
import CoreLocation

class PlaceAnnotation : MKPointAnnotation {
    
    let mapItem : MKMapItem
    let id = UUID()
    var isSelected : Bool = true
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
        super.init()
        self.coordinate = mapItem.placemark.coordinate
    }
    var name : String {
        mapItem.name ?? ""
    }
    var phone : String {
        mapItem.phoneNumber ?? ""
    }
    var location : CLLocation {
        mapItem.placemark.location ?? CLLocation.default
    }
    var address : String {
        "\(mapItem.placemark.subThoroughfare ?? "") \(mapItem.placemark.thoroughfare ?? "") \(mapItem.placemark.locality ?? "") \(mapItem.placemark.countryCode ?? "")"
    }
}

extension CLLocation {
    static var `default` : CLLocation {
        CLLocation(latitude: 25.0010037, longitude: 121.4635596)
    }
}

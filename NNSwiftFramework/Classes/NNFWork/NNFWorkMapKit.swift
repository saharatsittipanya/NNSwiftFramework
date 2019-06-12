//
//  NNFWorkMapKit.swift
//  Surprise Rayong
//
//  Created by Saharat Sittipanya on 8/12/61.
//  Copyright © พ.ศ. 2561 Wolves Corporation. All rights reserved.
//

import Foundation
import MapKit

//class NNMapkit: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
//    
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        
//        if annotation.isKind(of: MKPointAnnotation.self) {
//            let tempPinImageNameStr = (annotation as! CustomPointAnnotation).pinCustomImageName ?? ""
//            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: tempPinImageNameStr)
//            if annotationView == nil {
//                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: tempPinImageNameStr)
//                annotationView?.canShowCallout = true
//            } else {
//                annotationView?.annotation = annotation
//            }
//            annotationView?.image = UIImage(named: tempPinImageNameStr)
//            return annotationView
//        } else {
//            //            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CurrentLocation")
//            //            annotationView.image = UIImage(named: "IconPin")
//            //            annotationView.canShowCallout = true
//            //            return annotationView
//            return nil
//        }
//        
//    }
//    
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        
//        if let tempPolyline = overlay as? MKPolyline {
//            let tempLineRenderer = MKPolylineRenderer(polyline: tempPolyline)
//            tempLineRenderer.strokeColor = "78849E".hexColor
//            tempLineRenderer.lineDashPhase = 7.0
//            tempLineRenderer.lineDashPattern = [0, 15]
//            tempLineRenderer.lineWidth = 7.0
//            return tempLineRenderer
//        }
//        fatalError("Something wrong...")
//        
//    }
//    
//    func createAnnotationFor(lattitude lat: CLLocationDegrees, longtitude long: CLLocationDegrees, _ imgStr: String?, _ title: String?, _ subtitle: String?) {
//        
//        let customAnnotation = CustomPointAnnotation()
//        customAnnotation.coordinate = CLLocationCoordinate2DMake(lat, long)
//        customAnnotation.title = title ?? "nilTitle"
//        customAnnotation.subtitle = subtitle ?? "nilSubTitle"
//        customAnnotation.pinCustomImageName = imgStr ?? " "
//        self.mapView.addAnnotation(customAnnotation)
//        
//    }
//    
//    func centerScreenTo(lattitude lat: Double, longtitude long: Double, with span: CLLocationDistance?) {
//        
//        let coordinate = CLLocationCoordinate2DMake(lat, long)
//        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: span ?? 111111.1, longitudinalMeters: span ?? 111111.1)
//        self.mapView.setRegion(region, animated: true)
//        
//    }
//    
//    func createRouteTo(lattitude Destination_Lat: CLLocationDegrees, longtitude Destination_Long: CLLocationDegrees) {
//        
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: MKPlacemark(coordinate: (self.LocationManager.location?.coordinate)!))
//        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2DMake(Destination_Lat, Destination_Long)))
//        request.requestsAlternateRoutes = false
//        let directions = MKDirections(request: request)
//        
//        directions.calculate(completionHandler: {(response, error) in
//            if error != nil {
//                print("Error getting directions")
//            } else {
//                self.showRoute(response!)
//            }
//        })
//        
//    }
//    
//    func showRoute(_ response: MKDirections.Response) {
//        
//        for route in response.routes {
//            self.mapView.removeOverlays(self.mapView.overlays)
//            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
//        }
//        
//    }
//    
//}

class CustomPointAnnotation: MKPointAnnotation {
    
    var pinCustomImageName: String!
    var pinCustomImageName_Selected: String!
    var pinCustomImageName_2: String!
    var pinIndex: Int!
    var pinCustomVariable: String!
    
}

func getDistanceFrom2Location(_ Start_Lat: Double, _ Start_Long: Double, _ Destination_Lat: Double, _ Destination_Long: Double) -> Double {
    
    return ((sqrt(((Start_Lat-Destination_Lat)^^2)+((Start_Long-Destination_Long)^^2)))*111111.0)
    
}

func checkPermission(LocationManager: CLLocationManager) {
    
    if (CLLocationManager.authorizationStatus() != .authorizedWhenInUse) && (CLLocationManager.authorizationStatus() != .authorizedAlways) {
        LocationManager.requestAlwaysAuthorization()
    }
    
}

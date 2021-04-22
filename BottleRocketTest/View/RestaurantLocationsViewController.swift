//
//  RestaurantLocationsViewController.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/14/21.
//

import UIKit
import MapKit

class RestaurantLocationsViewController: UIViewController {
    
    //MARK: - Property
    private let coordinates: [(lat: Double, lng: Double, name: String)]

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = MKMapType.standard
        self.view.addSubview(mapView)
        mapView.boundToSuperView(insetLead: 0, insetTop: 10, insetTrail: 0, insetBottom: 0)
        mapView.isZoomEnabled = true
        return mapView
    }()
    
    
    
    //MARK: - init method
    
    init(coordinates: [(lat: Double, lng: Double, name: String)]) {
        self.coordinates = coordinates
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpMap()
    }
    
    // MARK: - Private
    
    private func setUpMap() {
        guard let firstCoordinate = self.coordinates.first else { return }
        let firstCenter = CLLocationCoordinate2D(latitude: firstCoordinate.lat, longitude: firstCoordinate.lng)
        
        for coordinate in self.coordinates {
            let annotation = MKPointAnnotation()
            let c = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lng)
            annotation.coordinate = c
            annotation.title = coordinate.name
            self.mapView.addAnnotation(annotation)
        }
        
        let region = MKCoordinateRegion(center: firstCenter, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        mapView.setRegion(region, animated: true)
    }

}

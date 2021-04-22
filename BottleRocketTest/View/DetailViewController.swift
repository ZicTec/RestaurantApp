//
//  DetailViewController.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/14/21.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private let restaurant: Restaurant
    private let locationManager = CLLocationManager()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        return mapView
    }()
    
    private lazy var restaurantNameLabel: UILabel = {
        let label = UILabel()
        let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Demi Bold", size: 15) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        label.attributedText = NSAttributedString(string: self.restaurant.name, attributes: attrs)
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Regular", size: 11) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        label.attributedText = NSAttributedString(string: self.restaurant.category, attributes: attrs)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Regular", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)]
        let address = self.restaurant.location.formattedAddress.map { fAddress in return "\(fAddress)\n" }.flatMap{ string in
            return string
        }
        label.attributedText = NSAttributedString(string: String(address.dropLast()), attributes: attrs)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var contactLabel: UILabel = {
        let label = UILabel()
        let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Regular", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)]
        label.attributedText = NSAttributedString(string: self.restaurant.contact?.formattedPhone ?? "No Phone Number", attributes: attrs)
        return label
    }()
    
    private lazy var twitterLabel: UILabel = {
        let label = UILabel()
        let attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Regular", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)]
        label.attributedText = NSAttributedString(string: self.restaurant.contact?.twitter ?? "No Social Media", attributes: attrs)
        label.numberOfLines = 0
        return label
    }()
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Lunch Tyme"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_webBack"), style: .plain, target: self, action: #selector(self.dismissVC))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_map"), style: .plain, target: self, action: #selector(self.displayRestaurant))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        
        self.setUpUI()
        self.setUpMap()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc private func dismissVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func displayRestaurant() {
        self.dismissVC()
        guard let vc = self.navigationController?.viewControllers.first as? LunchVC else { return }
        vc.displayRestaurant()
    }
    
    // MARK: - Private
    
    private func setUpUI() {
        
        let outsideVStackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 0)
        self.mapView.heightAnchor.constraint(equalToConstant: 180.0).isActive = true
        let restaurantView = UIView(frame: .zero)
        restaurantView.translatesAutoresizingMaskIntoConstraints = false
        restaurantView.backgroundColor = UIColor(displayP3Red: 52/255, green: 179/255, blue: 121/255, alpha: 1.0)
        restaurantView.heightAnchor.constraint(equalToConstant: 66).isActive = true
        let restaurantStackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 6)
        restaurantStackView.addArrangedSubview(self.restaurantNameLabel)
        self.restaurantNameLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        restaurantStackView.addArrangedSubview(self.categoryLabel)
        self.categoryLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        restaurantView.addSubview(restaurantStackView)
        restaurantStackView.boundToSuperView(insetLead: 12, insetTop: 16, insetTrail: 12, insetBottom: 16)
        let contactView = UIView(frame: .zero)
        contactView.translatesAutoresizingMaskIntoConstraints = false
        contactView.backgroundColor = .white
        let contactStackView = UIStackView(axis: .vertical, distribution: .fill, spacing: 26)
        contactStackView.addArrangedSubview(self.addressLabel)
        contactStackView.addArrangedSubview(self.contactLabel)
        contactStackView.addArrangedSubview(self.twitterLabel)
        contactStackView.addBufferView()
        
        contactView.addSubview(contactStackView)
        contactStackView.boundToSuperView(insetLead: 12, insetTop: 16, insetTrail: 12, insetBottom: 16)
        
        outsideVStackView.addArrangedSubview(self.mapView)
        outsideVStackView.addArrangedSubview(restaurantView)
        outsideVStackView.addArrangedSubview(contactView)
        
        self.view.addSubview(outsideVStackView)
        outsideVStackView.boundToSuperView(insetLead: 0, insetTop: 0, insetTrail: 0, insetBottom: 0)
        
    }
    
    // MARK: - Private
    
    private func setUpMap() {    
        let center = CLLocationCoordinate2D(latitude: self.restaurant.location.lat, longitude: self.restaurant.location.lng)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = self.restaurant.name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        mapView.setRegion(region, animated: true)
    }
}

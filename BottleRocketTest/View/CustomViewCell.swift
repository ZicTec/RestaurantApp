//
//  CustomViewCell.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/14/21.
//

import UIKit

class CustomViewCell: UICollectionViewCell {
    
    static let identifier = "CustomViewCell"
    
    //MARK: - Properties
    
    private let grad: CAGradientLayer = CAGradientLayer()
    private let view = UIView()

    private lazy var myImage: CustomImageData = {
        let imageView = CustomImageData(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Default")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var restaurantName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private lazy var categoryType: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGradientLayer()
        self.setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.grad.frame = self.contentView.frame
        self.view.frame = self.contentView.frame
    }
    
    func configureCell(restaurant: Restaurant) {
        let attrs1: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Demi Bold", size: 16) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.restaurantName.attributedText = NSAttributedString(string: restaurant.name, attributes: attrs1)
        let attrs2: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont(name: "Avenir Next Regular", size: 12) as Any, NSAttributedString.Key.foregroundColor: UIColor.white]
        self.categoryType.attributedText = NSAttributedString(string: restaurant.category, attributes: attrs2)
        if let url = URL(string: restaurant.backgroundImageURL) {
            self.myImage.loadImage(from: url)
        }
    }
    
    // MARK: - Private
    
    private func addGradientLayer() {
        grad.startPoint = CGPoint(x: 0.5, y: 0)
        grad.endPoint = CGPoint(x: 0.5, y: 1)
        let startColor = UIColor.clear
        let bottomColor = UIColor.black
        grad.colors = [startColor.cgColor, bottomColor.cgColor]
        grad.locations = [0.0, 1.0]
        view.layer.addSublayer(grad)
        self.myImage.addSubview(view)
        self.myImage.bringSubviewToFront(view)
    }
    
    private func setUpUI() {
        self.contentView.addSubview(self.myImage)
        self.contentView.addSubview(self.restaurantName)
        self.contentView.addSubview(self.categoryType)
        
        self.myImage.boundToSuperView(insetLead: 0, insetTop: 0, insetTrail: 0, insetBottom: 0)
        
        self.categoryType.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        self.categoryType.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6).isActive = true
        self.categoryType.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
        self.restaurantName.leadingAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.leadingAnchor, constant: 12).isActive = true
        self.restaurantName.bottomAnchor.constraint(equalTo: self.categoryType.topAnchor, constant: 6).isActive = true
        self.restaurantName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12).isActive = true
    }
}












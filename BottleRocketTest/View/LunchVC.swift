//
//  LunchVC.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/13/21.
//

import UIKit

class LunchVC: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel: ViewModel
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomViewCell.self, forCellWithReuseIdentifier: CustomViewCell.identifier)
        
        return cv
    }()
    
    // MARK: - Init Method
    init(viewModel: ViewModel = ViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        collectionView.dataSource = self
        collectionView.delegate = self
        setUpCollectionView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_map"), style: .plain, target: self, action: #selector(self.displayRestaurant))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.viewModel.bind {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        self.viewModel.initiatePull()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.reloadData()
    }
    
    // MARK: - Private
    
    private func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.boundToSuperView(insetLead: 0, insetTop: 0, insetTrail: 0, insetBottom: 0)
        collectionView.backgroundColor = UIColor(displayP3Red: 42/255, green: 42/255, blue: 42/255, alpha: 1.0)
    }
    
    @objc func displayRestaurant() {
        let restVC = RestaurantLocationsViewController(coordinates: self.viewModel.getCoordinates())
        self.present(restVC, animated: true, completion: nil)
    }
    
}

extension LunchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomViewCell.identifier, for: indexPath) as! CustomViewCell
        let restaurant = self.viewModel.getRestaurant(index: indexPath.row)
        cell.configureCell(restaurant: restaurant)
        
        return cell
    }
    
    
}

extension LunchVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController(restaurant: self.viewModel.getRestaurant(index: indexPath.item))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        print(indexPath.row)
    }
}

extension LunchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        if UIDevice.current.userInterfaceIdiom == .phone {
            width = view.frame.width
        } else {
            width = (view.frame.width-10)/2
        }
        return CGSize(width: width, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}




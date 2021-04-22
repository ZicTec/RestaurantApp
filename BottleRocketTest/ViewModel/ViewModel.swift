//
//  ViewModel.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/14/21.
//

import Foundation


class ViewModel {
    
    //MARK:- Properties
    private var network: Network
    private var restaurantArray = [Restaurant]() {
        didSet {
            self.handler?()
        }
    }
    private var handler: (() -> ())?
    
    //MARK: - Init Method
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func bind(handler: @escaping () -> ()) {
        self.handler = handler
    }
    
    func initiatePull() {
        self.network.getData { [weak self] (result) in
            self?.restaurantArray = result?.restaurants ?? []
        }
    }
    
    func getCount() -> Int {
        return self.restaurantArray.count
    }
    
    func getRestaurant(index: Int) -> Restaurant {
        return self.restaurantArray[index]
    }
    
    func getCoordinates() -> [(lat: Double, lng: Double, name: String)] {
        return self.restaurantArray.compactMap { restaurant in
            return (lat: restaurant.location.lat, lng: restaurant.location.lng, name: restaurant.name)
        }
    }
    
}





















//class ViewModel {
//
//    var networkManager: NetworkService
//
//    var restaurantArray = [Restaurant]() {
//        didSet {
//            self.uiHandler?()
//        }
//    }
//    var uiHandler: (() -> Void)?
//    var errorHandler: ((String) -> Void)?
//
//    init(networkManager: NetworkService = NetworkManager()) {
//        self.networkManager = networkManager
//    }
//
//    func bind(uiHandler: @escaping () -> Void, errorHandler: @escaping (String) -> Void) {
//        self.uiHandler = uiHandler
//        self.errorHandler = errorHandler
//    }
//
//    func performMovieQuery(for query: String) {
//        self.networkManager.fetchDecodableObjects(query: query) { [weak self] (result: Result<RestaurantApi, Error>) in
//            switch result {
//            case .success(let restaurantObject):
//                self?.restaurantArray = restaurantObject.restaurants
//            case .failure(let error):
//                print(error)
//                self?.errorHandler?(error.localizedDescription)
//            }
//        }
//    }
//
//
//}



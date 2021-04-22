//
//  NetworkManager.swift
//  BottleRocketTest
//
//  Created by Eze Emenike on 4/14/21.
//

import Foundation

class Network {
    
    func getData(completion: @escaping (RestaurantApi?) -> ()) {

        guard let url = URL(string: NetworkConstants.restuarantsURL) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }

            guard let fetchedData = try? JSONDecoder().decode(RestaurantApi.self, from: data) else {
                print("\(error?.localizedDescription ?? "Couldn't load data")")
                completion(nil)
                return
            }
            completion(fetchedData)
        }.resume()
    }

}




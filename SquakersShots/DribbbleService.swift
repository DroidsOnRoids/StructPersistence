//
//  DribbbleService.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 19/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import Foundation
import UIKit //niepotrzebne?

final class DribbbleService {
    func loadShots(completion: @escaping ([Shot]) -> ()) {
        var request = URLRequest(url: URL(string: "https://api.dribbble.com/v1/shots")!)
        request.allHTTPHeaderFields = ["Authorization": "Bearer 0fe41437c99082bb07c3dc581531f5a5b9a9181b51bc6d1864c98c1acbdc4796"]
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error, handle me :( \(error.localizedDescription)")
                return
            }
            guard let data = data, let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [[AnyHashable : Any]], let unwrappedJSON = JSON else {
                print("No data or cannot parse to JSON! :(")
                return
            }
            completion(unwrappedJSON.flatMap(Shot.init))
        }
        .resume()
    }
}

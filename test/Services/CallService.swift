//
//  CallService.swift
//  test
//
//  Created by Khawaja Fahad on 08/11/2021.
//

import Foundation
import Alamofire

protocol TrackServiceProtocol {
    func getTracks(completion: @escaping (_ success: Bool, _ results: Tracks?, _ error: String?) -> ())
}

class TrackService: TrackServiceProtocol {
    func getTracks(completion: @escaping (Bool, Tracks?, String?) -> ()) {
    
        let request = AF.request("https://jsonplaceholder.typicode.com/photos")
        request.responseDecodable(of: [Track].self) { (response) in
          guard let tracks = response.value else {
            completion(false, nil, "Error: Trying to parse Tracks to model")
            return
          }
            completion(true, tracks, nil)
        }
    }
}

//
//  DDGRequest.swift
//  DDG Characters
//
//  Created by MCS on 12/18/18.
//  Copyright © 2018 Kelderth. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias requestSuccessful = () -> ()
typealias requestImageSuccessful = (Data) -> ()

class DDGApiService {
    
    var success: requestSuccessful!
    var imageSuccess: requestImageSuccessful!
    let dataManager: DDGPersistence = DDGPersistence()
    
    func serviceRequest(onSuccess: @escaping requestSuccessful) {

        // LooneyTunes - DuckDuckGo API EndPoint
        let url = "https://api.duckduckgo.com/?q=looney+tunes+characters&format=json"
        
        guard let urlRequest = URL(string: url) else { return }
        
        Alamofire.request(urlRequest).responseJSON { (response) in
            switch response.result {
            case .success (let value):
                let json = JSON(value)
                let numberOfEntries = json["RelatedTopics"].count
                let defaultDirectory = json["RelatedTopics"]
                
//                var characterList: [CharacterSource] = [CharacterSource]()
                
                for characterIndex in 0 ..< numberOfEntries {
                    let fullDescription = defaultDirectory[characterIndex]["Text"].string!
                    let fullDetails = fullDescription.components(separatedBy: " - ")
                    let characterName = fullDetails[0]
                    let characterDetail = fullDetails[1]
                    let pictureURL = defaultDirectory[characterIndex]["Icon"]["URL"].string!
                    let favorited = false
                    
                    self.dataManager.writeData(characterName: characterName, characterDetail: characterDetail, pictureURL: pictureURL, favorited: favorited)
                }
                
                onSuccess()
                
            case .failure(let error):
                print(error)
//                self.fail()
            }
        }
    }
    
    func imageDownloader(_ imageURL: String, completion: @escaping (Data) -> ()) {
        guard let urlImage = URL(string: imageURL) else { return }
        
        Alamofire.request(urlImage).response { (dataResponse) in
            guard let data = dataResponse.data else { return }
            completion(data)
        }
    }
    
}

//
//  DatabaseManager.swift
//  test
//
//  Created by Khawaja Fahad on 08/11/2021.
//

import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let realm = try! Realm()
        
    private init() {
    }
    
    
    func addObject(track: Track) {
        
        let compoundKey = "\(track.albumId)\(track.id)"
        
        if objectExist(id: compoundKey) {
            let object  = realm.object(ofType: TrackObject.self, forPrimaryKey: compoundKey)
            
            if object?.thumbnailUrl != track.thumbnailUrl || object?.thumbnailUrl != track.thumbnailUrl  || object?.thumbnailUrl != track.thumbnailUrl  {
                
                try! realm.write {
                      object?.thumbnailUrl = track.thumbnailUrl
                      object?.url = track.url
                      object?.title = track.title
                    }
            }
        } else {
            try! realm.write  {
                realm.add(TrackObject(albumId: track.albumId, id: track.id, title: track.title, url: track.url, thumbnailUrl: track.thumbnailUrl))
            }
        }
    }
    
    func objectExist (id: String) -> Bool {
            return realm.object(ofType: TrackObject.self, forPrimaryKey: id) != nil
    }
    
    func getObjects(albumId: Int) -> TrackObjects {
        
        let tracks = realm.objects(TrackObject.self).filter("albumId == \(albumId)")
        return Array(tracks)
    }
    
}

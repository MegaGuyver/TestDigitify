//
//  TrackObject.swift
//  test
//
//  Created by Khawaja Fahad on 08/11/2021.
//

import Foundation
import RealmSwift

typealias TrackObjects = [TrackObject]

class TrackObject: Object {
    @objc dynamic var albumId = 0
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var url = ""
    @objc dynamic var thumbnailUrl = ""
    @objc dynamic var compoundKey = ""
    
    override static func primaryKey() -> String? {
           return "compoundKey"
       }
    
    func compoundKeyValue() -> String {
            return "\(albumId)\(id)"
        }

    convenience init(albumId: Int, id: Int, title: String, url: String, thumbnailUrl: String) {
        self.init()
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        self.compoundKey = compoundKeyValue()
    }
}

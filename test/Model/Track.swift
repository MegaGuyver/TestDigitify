//
//  Track.swift
//  test
//
//  Created by Khawaja Fahad on 08/11/2021.
//

import Foundation
import RealmSwift

typealias Tracks = [Track]

class Track: Codable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String

}


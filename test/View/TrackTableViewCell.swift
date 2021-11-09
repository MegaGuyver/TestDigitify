//
//  TrackTableViewCell.swift
//  test
//
//  Created by Khawaja Fahad on 08/11/2021.
//

import Foundation
import UIKit

class TrackTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

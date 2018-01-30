//
//  ReusableCell.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import UIKit

class ReusableCell: UITableViewCell {

    class var reuseIdentifier: String {
        return String(describing: self)
    }

    func configure(with viewData: ViewData, interactionHandler: InteractionHandler? = nil) {}
}

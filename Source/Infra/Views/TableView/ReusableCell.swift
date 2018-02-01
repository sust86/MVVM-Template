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

    // TODO: Should this be in here? Some views might use a binder and are not provindg this
    func configure(with viewData: ViewData, interactionHandler: InteractionHandler? = nil) {}
}

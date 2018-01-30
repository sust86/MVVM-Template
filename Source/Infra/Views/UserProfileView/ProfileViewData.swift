//
//  ProfileViewData.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/28/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

struct ProfileViewData: ViewData {
    var imageURL: URL?
    var name: String
    var primaryMetadata: String?
    var secondaryMetadata: String?
}

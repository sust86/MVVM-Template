//
//  DataTransformer.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

// TODO: Rename VIewDataTransformer ?
protocol DataTransformer {
    static func viewData(from serverModel: ServerModel) -> ViewData?
}

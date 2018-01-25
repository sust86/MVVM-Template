//
//  QuestionsViewData.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/24/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

struct TableViewData: ViewData {

    var estimatedRowHeight: CGFloat// = 100
    var rowHeight: CGFloat// = UITableViewAutomaticDimension
    var allowsSelection: Bool // = false
}

struct QuestionsViewData: ViewData {

    var tableViewData: TableViewData

    init(tableViewData: TableViewData) {
        self.tableViewData = tableViewData
    }
}

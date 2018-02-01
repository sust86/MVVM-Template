//
//  TableViewData.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/30/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

// TODO: Will QuestionCellViewData and AnswerCellViewData contain their rowHeight, estimatedRowHeight etc?

class TableViewData: ViewData {

    var estimatedRowHeight: CGFloat // Move to AnswerCellViewData
    var rowHeight: CGFloat  // Move to QuestionCellViewData
    var allowsSelection: Bool
    var viewDataCollection: ViewDataCollection

    init(estimatedRowHeight: CGFloat,
         rowHeight: CGFloat,
         allowsSelection: Bool,
         viewDataCollection: ViewDataCollection = ViewDataCollection()) {

        self.estimatedRowHeight = estimatedRowHeight
        self.rowHeight = rowHeight
        self.allowsSelection = allowsSelection
        self.viewDataCollection = viewDataCollection
    }
    
}

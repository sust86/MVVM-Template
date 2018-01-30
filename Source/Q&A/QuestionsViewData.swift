//
//  QuestionsViewData.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/24/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

// Note: I changed QuestionViewData and TableViewData to be a class instead of a struct.
// The reasoning behind is that the TableViewData contains the table views ViewDataCollection.
// When we are loading more data, or modifying data in there, we don't want to recreate the whole struct and pass it to our TableViewAdapter again.

class QuestionsViewData: ViewData {
    var isLoading: Bool = false
    var tableViewData: TableViewData

    // MARK: - Lifecycle
    
    init(tableViewData: TableViewData) {
        self.tableViewData = tableViewData
    }
}

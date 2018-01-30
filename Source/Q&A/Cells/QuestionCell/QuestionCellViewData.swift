//
//  QuestionCellViewData.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

struct QuestionCellViewData: ViewData {
    var question: String
    var likes: String
    var answers: String
    var authorViewData: ProfileViewData
}

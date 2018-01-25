//
//  AnswerCellViewModel.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class AnswerCellViewModel {

    var viewData: AnswerCellViewData?

    init(answerCard: QuestionAnswerCard) {
        viewData = AnswerCellDataTransformer.viewData(from: answerCard) as? AnswerCellViewData
    }
    
}

//
//  AnswerCellDataTransformer.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class AnswerCellDataTransformer {
    
    static func viewData(from answerCard: QuestionAnswerCard) -> AnswerCellViewData? {
        guard let authorCard = answerCard.authors.first else {
            return nil
        }
        let authorViewData = ProfileViewDataTransformer.viewData(from: authorCard, createdDate: answerCard.createdDate)
        return AnswerCellViewData(answer: answerCard.questionTitle,
                                  authorViewData: authorViewData)
    }

}

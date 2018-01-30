//
//  QuestionCellDataTransformer.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class QuestionCellDataTransformer {

    static func viewData(from questionCard: QuestionAnswerCard) -> QuestionCellViewData? {
        guard let authorCard = questionCard.authors.first else {
            return nil
        }
        let authorViewData = ProfileViewDataTransformer.viewData(from: authorCard, createdDate: questionCard.createdDate)
        return QuestionCellViewData(question: questionCard.questionTitle,
                                    likes: "\(questionCard.numberOfLikes) Likes",
                                    answers: "\(questionCard.numberOfComments) Answers",
                                    authorViewData: authorViewData)
    }
 
}

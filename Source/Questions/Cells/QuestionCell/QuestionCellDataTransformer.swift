//
//  QuestionCellDataTransformer.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class QuestionCellDataTransformer: DataTransformer {

    static func viewData(from serverModel: ServerModel) -> ViewData? {
        guard let questionServerModel = serverModel as? QuestionAnswerCard else {
            return nil
        }

        return QuestionCellViewData(authorName: questionServerModel.authorName,
                                    question: questionServerModel.questionTitle,
                                    likes: "\(questionServerModel.numberOfLikes) Likes",
                                    answers: "\(questionServerModel.numberOfComments) Answers")
    }


//    static func viewData(from serverModel: QuestionAnswerCard) -> QuestionCellViewData {
//        let authorName = "\(String(describing: serverModel.authors.first?.firstName))" + "\(String(describing: serverModel.authors.first?.lastName))"
//        let viewData = QuestionCellViewData(authorName: authorName,
//                                            text: serverModel.questionTitle,
//                                            likes: serverModel.numberOfLikes,
//                                            answers: serverModel.numberOfComments)
//        return viewData
//    }
}

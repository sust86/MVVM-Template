//
//  AnswerCellDataTransformer.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class AnswerCellDataTransformer: DataTransformer {

    static func viewData(from serverModel: ServerModel) -> ViewData? {
        guard let answerServerModel = serverModel as? QuestionAnswerCard else {
            return nil
        }
        return AnswerCellViewData(authorName: answerServerModel.authorName + ":",
                                  answer: answerServerModel.questionTitle)
    }

}

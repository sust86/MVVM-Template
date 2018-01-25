//
//  QuestionCellViewModel.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

// Q: If the author part would be its own view, would each CVM contain an AuthorViewModel?

class QuestionCellViewModel {

    var viewData: QuestionCellViewData?
    var answersCellViewModels = [AnswerCellViewModel]()

    init(questionCard: QuestionAnswerCard) {
        viewData = QuestionCellDataTransformer.viewData(from: questionCard) as? QuestionCellViewData
        setupAnswersCellViewModels(for: questionCard)
    }

    private func setupAnswersCellViewModels(for questionCard: QuestionAnswerCard) {
        questionCard.childContent.forEach({ (answerCard) in
            let answerCellViewModel = AnswerCellViewModel(answerCard: answerCard)
            answersCellViewModels.append(answerCellViewModel)
        })
    }

}

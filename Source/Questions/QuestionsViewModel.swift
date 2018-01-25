//
//  QuestionsViewModel.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

class QuestionsViewModel {

    private var dataProvider: QuestionDataProvider?
    var questionsCellViewModels = [QuestionCellViewModel]()
    var viewData: QuestionsViewData?

    // MARK: - Lifecycle

    init() {
        setupDataProvider()
        setupViewData()
    }

    // MARK: - Setup

    private func setupDataProvider() {
        dataProvider = QuestionDataProvider()
    }

    private func setupViewData() {
        let tableViewData = TableViewData(estimatedRowHeight: 100, rowHeight: UITableViewAutomaticDimension, allowsSelection: false)
        viewData = QuestionsViewData(tableViewData: tableViewData)
    }

    // MARK: - Public Interface

    func loadData(completion: (() -> Void)) {
        dataProvider?.getQuestions(completion: { [weak self] (data: [QuestionAnswerCard]) in
            self?.setupQuestionsCellViewModels(for: data)
            completion()
        })
    }

    // MARK: - Private Helpers

    private func setupQuestionsCellViewModels(for questionCards: [QuestionAnswerCard]) {
        questionCards.forEach({ (questionCard) in
            let questionCellViewModel = QuestionCellViewModel(questionCard: questionCard)
            questionsCellViewModels.append(questionCellViewModel)
        })
    }
}

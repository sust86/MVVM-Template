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

    // MARK: - Public Properties

    var viewData: QuestionsViewData?

    // MARK: - Private Properties

    private var dataProvider: QuestionDataProvider?

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

    /**
     Ask the view model to load its data.
     */
    func loadData(completion: (() -> Void)? = nil) {
        viewData?.isLoading.value = true
        dataProvider?.getQuestions(completion: { [weak self] (questionCards: [QuestionAnswerCard]) in
            self?.buildViewDataCollection(for: questionCards)
            self?.viewData?.isLoading.value = false
            completion?()
        })
    }

    func loadMoreData(completion: (() -> Void)? = nil) {
        viewData?.isLoading.value = true
        dataProvider?.getQuestions(completion: { [weak self] (questionCards: [QuestionAnswerCard]) in
            self?.appendViewDataCollection(with: questionCards)
            self?.viewData?.isLoading.value = false
            completion?()
        })
    }

    private func didLoadMoreData(questionsCards: [QuestionAnswerCard]) {

        let viewDataArray = viewDataCollection(for: questionsCards)
        viewData?.tableViewData.viewDataCollection.appendData(data: viewDataArray)
    }

    // MARK: - Private Helpers

    // MARK: View Data Collection

    private func buildViewDataCollection(for questionCards: [QuestionAnswerCard]) {
        let viewDataArray = viewDataCollection(for: questionCards)
        viewData?.tableViewData.viewDataCollection.updateData(data: viewDataArray)
    }

    private func appendViewDataCollection(with questionCards: [QuestionAnswerCard]) {
        let viewDataArray = viewDataCollection(for: questionCards)
        viewData?.tableViewData.viewDataCollection.appendData(data: viewDataArray)
    }

    /**
     Iterates all questions and creates a view data collection for those questions and their answers.
     Each question and its associated answers form a section within this data collection.
     */
    private func viewDataCollection(for questionCards: [QuestionAnswerCard]) -> [[ViewData]] {
        // TODO: Naming! Naming this viewDataCollection is confusing (There is a class ViewDataCollection)
        let viewDataCollection: [[ViewData]] = questionCards.flatMap { (questionCard) -> [ViewData]? in
            return viewDataSection(for: questionCard)
        }
        return viewDataCollection
    }

    /**
     Creates an array with view data objects for the question.
     The first object will reflect the question, all following objects will reflect the answers to this question.
     */
    private func viewDataSection(for questionCard: QuestionAnswerCard) -> [ViewData]? {
        guard let questionViewData = questionCellViewData(for: questionCard) else {
            return nil
        }
        let answersViewData = answerCellsViewData(for: questionCard)

        var viewDataSection: [ViewData] = [questionViewData]
        viewDataSection.append(contentsOf: answersViewData as [ViewData])
        return viewDataSection
    }

    /**
     Creates the view data object for the question.
     */
    private func questionCellViewData(for questionCard: QuestionAnswerCard) -> QuestionCellViewData? {
        return QuestionCellDataTransformer.viewData(from: questionCard)
    }

    /**
     Iterates all answers for a question and creates view data object for these answers.
     */
    private func answerCellsViewData(for questionCard: QuestionAnswerCard) -> [AnswerCellViewData] {
        let answerCellsViewData: [AnswerCellViewData] = questionCard.childContent.flatMap { (answerCard) -> AnswerCellViewData? in
            return AnswerCellDataTransformer.viewData(from: answerCard)
        }
        return answerCellsViewData
    }

}

//
//  QuestionsViewController.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit


// TODO:
// We'll also need to cell binder for the TableViewAdapter to know which indexPath belongs to which cell.

class QuestionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var questionsViewModel: QuestionsViewModel?
    var tableViewAdapter: QuestionsTableViewAdapter?
    var viewDataCollection: ViewDataCollection?
    var viewSpecMap: ViewSpecMap?

    // Does the VC need to hold a reference to the InteractionHandlers?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
    }

    // MARK: - Setup

    private func setupViewModel() {
        questionsViewModel = QuestionsViewModel()
        questionsViewModel?.loadData(completion: {

            // Create `ViewDataCollection`
            let viewData = createViewData()
            viewDataCollection = ViewDataCollection(data: viewData)

            // Create `ViewSpecMap`
            viewSpecMap = createViewSpecMap()

            // Setup `TableViewAdapter`
            setupTableViewAdapter()

            tableView.reloadData()
        })
    }

    private func setupTableView() {
        guard let viewData = questionsViewModel?.viewData?.tableViewData else {
            return
        }
        tableView.estimatedRowHeight = viewData.estimatedRowHeight
        tableView.rowHeight = viewData.rowHeight
        tableView.allowsSelection = viewData.allowsSelection
    }


    private func setupTableViewAdapter() {
        guard let viewDataCollection = viewDataCollection,
            let viewSpecMap = viewSpecMap else {
                return
        }
        tableViewAdapter = QuestionsTableViewAdapter(viewDataCollection: viewDataCollection, viewSpecMap: viewSpecMap)
        tableView.dataSource = tableViewAdapter
    }

    private func createViewData() -> [[ViewData]] {
        // TODO: Where is responsible for setting this up? We need to iterate all of our ViewModels sub view models and create the
        var viewData = [[ViewData]]()
        questionsViewModel?.questionsCellViewModels.forEach({ (questionsCellViewModel) in
            var sectionViewData = [ViewData]()

            // Append QuestionsCell ViewData
            if let questionViewData = questionsCellViewModel.viewData {
                sectionViewData.append(questionViewData)
            }

            // Append AnswerCells ViewData
            let answersViewData = questionsCellViewModel.answersCellViewModels.flatMap({ (answerCellViewModel) -> ViewData? in
                return answerCellViewModel.viewData
            })
            sectionViewData.append(contentsOf: answersViewData)

            viewData.append(sectionViewData)
        })
        return viewData
    }

    private func createViewSpecMap() -> ViewSpecMap {
        // Q: How many interaction handler should there be? One for each View class or one for each view?
        // I believe, Voyager is just passing in the InteractionType. The ViewBinder will then create a specific Interactinohandler for each view.
        // Note: Should a reused view reuse the interaction handler?
        let questionCellInteractionHandler = QuestionCellInteractionHandler()
        let questionCellViewSpec = ViewSpec(viewClass: QuestionCell.self, interactionHandler: questionCellInteractionHandler)
        let answerCellViewSpec = ViewSpec(viewClass: AnswerCell.self, interactionHandler: nil)

        let viewSpecMap = ViewSpecMap(map: [String(describing: AnswerCellViewData.self): answerCellViewSpec,
                                            String(describing: QuestionCellViewData.self): questionCellViewSpec])
        return viewSpecMap
    }
}

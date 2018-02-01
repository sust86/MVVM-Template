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
// Working InteractionHandler example
// View property binding

class QuestionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    // MARK: - Private Properties

    private var questionsViewModel: QuestionsViewModel?
    private var tableViewAdapter: TableViewAdapter?
    private var viewSpecMap: ViewSpecMap?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewSpecMap()
        setupViewModel()

        setupUI()
        setupTableViewAdapter()
        setupTableView()

        loadData()

    }

    // MARK: - Setup

    private func setupViewSpecMap() {
        // TODO: Does the ViewControllers need a InteractionHandlerManager?
        let questionCellInteractionHandler = QuestionCellInteractionHandler()
        let profileViewInteractionHandler = ProfileViewInteractionHandler()

        let questionCellViewBinder = QuestionCellViewBinder()

        let questionCellViewSpec = ViewSpec(viewClass: QuestionCell.self, viewBinder: questionCellViewBinder, interactionHandler: questionCellInteractionHandler)
        let answerCellViewSpec = ViewSpec(viewClass: AnswerCell.self, viewBinder: nil, interactionHandler: nil)
        let profileViewSpec = ViewSpec(viewClass: ProfileView.self, viewBinder: nil, interactionHandler: profileViewInteractionHandler)

        viewSpecMap = ViewSpecMap(map: [String(describing: AnswerCellViewData.self): answerCellViewSpec,
                                 String(describing: QuestionCellViewData.self): questionCellViewSpec,
                                 String(describing: ProfileViewData.self): profileViewSpec])
        // TODO: Improve the key for this map. It's really annoying to use.
    }

    private func setupViewModel() {
        questionsViewModel = QuestionsViewModel()
    }

    private func setupUI() {
        guard let viewData = questionsViewModel?.viewData else {
            return
        }
        activityIndicatorView.isHidden = !viewData.isLoading
    }

    // MARK: TableView

    private func setupTableViewAdapter() {
        guard let tableViewData = questionsViewModel?.viewData?.tableViewData,
            let viewSpecMap = viewSpecMap else {
                return
        }
        tableViewAdapter = TableViewAdapter(viewDataCollection: tableViewData.viewDataCollection, viewSpecMap: viewSpecMap)
    }

    private func setupTableView() {
        guard let tableViewData = questionsViewModel?.viewData?.tableViewData else {
            return
        }
        tableView.estimatedRowHeight = tableViewData.estimatedRowHeight
        tableView.rowHeight = tableViewData.rowHeight
        tableView.allowsSelection = tableViewData.allowsSelection

        tableView.dataSource = tableViewAdapter
        tableView.delegate = self
    }

    // MARK: - Data Loading

    private func loadData() {
        questionsViewModel?.loadData(completion: {
            // QuestionViewModel manages our data layer. We just need to reload the table view once data loading is done :)
            tableView.reloadData()
        })
    }

    private func loadMoreData() {
        questionsViewModel?.loadMoreData(completion: {
            tableView.reloadData()
        })
    }

}

/**
 QuestionsViewController will still be the delgate for the `UITableView`.
 */
extension QuestionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Pagination example
        guard let viewDataCollection = questionsViewModel?.viewData?.tableViewData.viewDataCollection else {
            return
        }
        if indexPath == viewDataCollection.indexPathOfLastItem() {
            loadMoreData()
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: Do we get the row height from the viewSpecMap or from the viewData?
        return 100
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // TODO: Do we get the row height from the viewSpecMap or from the viewData?
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: If used, this needs to be hooked up with the cells interaction handler.
    }
}

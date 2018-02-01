//
//  QuestionCellViewBinder.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/31/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

/**
 ViewBinders are optional!
 In our case, the QuestionCell has a subview for displaying the authors profile.
 We don't want the QuestionCell to be responsible for setting up the ProfileView. Instead, QuestionCell provides a QuestionCellViewBinder which knows about View and ViewData. It can be used for setting up the cell and its subviews.
 Note: ProfileView doesn't use a ViewBinder right now. It will simply provide a `configure(viewData:interactionHandler)` interface.
 */
class QuestionCellViewBinder: ViewBinderProtocol {

    func bindView(_ view: UIView, to data: ViewData, using viewSpecMap: ViewSpecMap) {
        guard let questionCellViewData = data as? QuestionCellViewData,
            let questionCell = view as? QuestionCell,
            let questionCellSpec = viewSpecMap.spec(for: String(describing: type(of: data))) else {
                return
        }
        // Populate the views fields
        questionCell.questionLabel?.text = questionCellViewData.question
        questionCell.likeButton?.setTitle(questionCellViewData.likes, for: .normal)
        questionCell.commentButton?.setTitle(questionCellViewData.answers, for: .normal)
        questionCell.interactionHandler = questionCellSpec.interactionHandler as? QuestionCellInteractionHandler

        // TODO: Here we can try to setup actual bindings as @uwalker suggested (https://www.toptal.com/ios/swift-tutorial-introduction-to-mvvm)
        // Example:
        /*
        questionCellViewData.answers.bind { (newValue) in
            questionCell.questionLabel?.text = newValue
        }
        */

        // The QuestionCell has a subview (ProfileView) for displaying the authors profile.
        // Luckily the QuestionCellViewData also provides authorViewData.
        if let authorView = questionCell.authorView {
            bindAuthorView(authorView, to: questionCellViewData.authorViewData, using: viewSpecMap)
        }
    }

    private func bindAuthorView(_ view: ProfileView, to data: ProfileViewData, using viewSpecMap: ViewSpecMap) {
        guard let profileViewSpec = viewSpecMap.spec(for: String(describing: type(of: data))) else {
            return
        }
        let interactionHandler = profileViewSpec.interactionHandler as? ProfileViewInteractionHandler
        view.configure(with: data, interactionHandler: interactionHandler)
    }

}

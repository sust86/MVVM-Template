//
//  QuestionCell.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

class QuestionCell: ReusableCell {

    @IBOutlet weak var questionLabel: UILabel?
    @IBOutlet weak var likeButton: UIButton?
    @IBOutlet weak var commentButton: UIButton?

    private var interactionHandler: QuestionCellInteractionHandler?

    // MARK: - Public Interface

    override func configure(with viewData: ViewData, interactionHandler: InteractionHandler? = nil) {
        // TODO: Should we pass in the correct type?
        guard let viewData = viewData as? QuestionCellViewData else {
            return
        }

        questionLabel?.text = viewData.question
        likeButton?.setTitle(viewData.likes, for: .normal)
        commentButton?.setTitle(viewData.answers, for: .normal)

        self.interactionHandler = interactionHandler as? QuestionCellInteractionHandler
    }

    @IBAction func likeButtonTapped(sender: UIButton) {
        interactionHandler?.didTapLikeButton(sender: sender)
    }

    @IBAction func commentButtonTapped(sender: UIButton) {
        interactionHandler?.didTapCommentButton(sender: sender)
    }
    
}

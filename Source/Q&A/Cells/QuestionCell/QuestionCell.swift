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

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!

    @IBOutlet weak var profileViewContainer: UIView!
    var authorView: ProfileView?

    // TODO: Move to base class? (base view class?)
    var interactionHandler: QuestionCellInteractionHandler?

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupProfileView()
    }

    // MARK: - Setup

    private func setupProfileView() {
        guard let profileView = UIView.loadFromNib(ProfileView.self) else {
            return
        }
        profileView.addAsSubviewAndPinEdges(toContainer: profileViewContainer)
        authorView = profileView
    }

    // MARK: - IBActions

    @IBAction func likeButtonTapped(sender: UIButton) {
        interactionHandler?.didTapLikeButton(sender: sender)
    }

    @IBAction func commentButtonTapped(sender: UIButton) {
        interactionHandler?.didTapCommentButton(sender: sender)
    }
    
}

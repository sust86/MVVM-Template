//
//  QuestionCellInteractionHandler.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/24/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

class QuestionCellInteractionHandler: InteractionHandler {

    func didTapLikeButton(sender: UIButton) {
        print("You liked a question!")
    }

    func didTapCommentButton(sender: UIButton) {
        print("Did tap comment...")
    }

}

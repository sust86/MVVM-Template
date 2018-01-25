//
//  AnswerCell.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

class AnswerCell: ReusableCell {

    @IBOutlet weak var authorNameLabel: UILabel?
    @IBOutlet weak var answerLabel: UILabel?
    
    override func configure(with viewData: ViewData, interactionHandler: InteractionHandler? = nil) {
        guard let answerCellViewData = viewData as? AnswerCellViewData else {
            return
        }
        authorNameLabel?.text = answerCellViewData.authorName
        answerLabel?.text = answerCellViewData.answer
    }
}

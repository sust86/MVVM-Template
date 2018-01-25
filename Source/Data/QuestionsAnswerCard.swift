//
//  QuestionsAnswerCard.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class QuestionAnswerCard: ServerModel {
    let questionURN: String
    let questionTitle: String
    let authors: [LILAuthorCard]

    let parentContent: QuestionAnswerCard?
    let childContent: [QuestionAnswerCard] // Consistency support?

    let videoOffsetInSeconds: Double // Make generic?
    let numberOfLikes: Double // Consistency support?
    let numberOfComments: Double // Consistency support?

    /*
    let isFromInstructor: Bool
    let isFromYourCompany: Bool
    let isFeaturedByInstructor: Bool
    let isMostLiked: Bool
    let isEdited: Bool // Unnessesary (we have updateAt)?
     */

    init(questionURN: String,
        questionTitle: String,
        authors: [LILAuthorCard],
        parentContent: QuestionAnswerCard?,
        childContent: [QuestionAnswerCard],
        videoOffsetInSeconds: Double,
        numberOfLikes: Double,
        numberOfComments: Double) {

        self.questionURN = questionURN
        self.questionTitle = questionTitle
        self.authors = authors
        self.parentContent = parentContent
        self.childContent = childContent
        self.videoOffsetInSeconds = videoOffsetInSeconds
        self.numberOfLikes = numberOfLikes
        self.numberOfComments = numberOfComments        
    }
}

extension QuestionAnswerCard {

    var authorName: String {
        let firstName = authors.first?.firstName ?? ""
        let lastName = authors.first?.lastName ?? ""
        return "\(firstName)" + " \(lastName)"
    }
}

struct LILAuthorCard: ServerModel {
    let urn: String
    let firstName: String
    let lastName: String
    let headline: String
    let thumbnails: [String]?
}

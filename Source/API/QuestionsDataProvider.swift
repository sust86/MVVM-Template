//
//  QuestionsDataProvider.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class QuestionDataProvider {


    // MARK: - Public Interface

    func getQuestions(completion: ((_ data: [QuestionAnswerCard]) -> Void)) {
        let data = fakeData()
        completion(data)
    }

    private func fakeData() -> [QuestionAnswerCard] {
        return fakeQuestions()
    }

    private func fakeQuestions() -> [QuestionAnswerCard] {
        var questionCards = [QuestionAnswerCard]()
        questionCards.append(QuestionAnswerCard(questionURN: "urn:li:question:1",
                                                questionTitle: "A question",
                                                authors: [fakeAuthor()],
                                                parentContent: nil,
                                                childContent: fakeAnswers(),
                                                videoOffsetInSeconds: 0,
                                                numberOfLikes: 3,
                                                numberOfComments: 3))
        questionCards.append(QuestionAnswerCard(questionURN: "urn:li:question:2",
                                                questionTitle: "A question",
                                                authors: [fakeAuthor()],
                                                parentContent: nil,
                                                childContent: fakeAnswers(),
                                                videoOffsetInSeconds: 0,
                                                numberOfLikes: 10,
                                                numberOfComments: 3))
        questionCards.append(QuestionAnswerCard(questionURN: "urn:li:question:3",
                                                questionTitle: "A question",
                                                authors: [fakeAuthor()],
                                                parentContent: nil,
                                                childContent: fakeAnswers(),
                                                videoOffsetInSeconds: 0,
                                                numberOfLikes: 1,
                                                numberOfComments: 3))
        return questionCards
    }

    private func fakeAnswers() -> [QuestionAnswerCard] {
        var answerCards = [QuestionAnswerCard]()
        answerCards.append(QuestionAnswerCard(questionURN: "urn:li:answer:1",
                                              questionTitle: "First answer.",
                                              authors: [fakeAuthor()],
                                              parentContent: nil,
                                              childContent: [],
                                              videoOffsetInSeconds: 0,
                                              numberOfLikes: 5,
                                              numberOfComments: 0))
        answerCards.append(QuestionAnswerCard(questionURN: "urn:li:answer:2",
                                              questionTitle: "A little longer second answer.",
                                              authors: [fakeAuthor()],
                                              parentContent: nil,
                                              childContent: [],
                                              videoOffsetInSeconds: 0,
                                              numberOfLikes: 1,
                                              numberOfComments: 0))
        answerCards.append(QuestionAnswerCard(questionURN: "urn:li:answer:3",
                                              questionTitle: "A third answer. This answer should span multiple lines. It's a really long answer. People like giving long answers. And people like long answers",
                                              authors: [fakeAuthor()],
                                              parentContent: nil,
                                              childContent: [],
                                              videoOffsetInSeconds: 0,
                                              numberOfLikes: 100,
                                              numberOfComments: 0))
        return answerCards
    }

    private func fakeAuthor() -> LILAuthorCard {
        return LILAuthorCard(urn: "urn:li:author:1",
                             firstName: "Tom",
                             lastName: "Hanks",
                             headline: "My mother used to say...",
                             thumbnails: nil)
    }
}

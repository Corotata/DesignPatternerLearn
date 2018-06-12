//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Rocky on 2018/6/12.
//  Copyright © 2018年 Rocky. All rights reserved.
//

import Foundation

public class SequentialQuestionStategy: QuestionStrategy {
    
    public var title: String {
        return questionGroup.title
    }
    
    public var correctCount: Int = 0
    
    public var incorrectCount: Int = 0
    
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    
    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }
    
    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questionGroup.questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }
    
    public func currentQuestion() -> Question {
        return questionGroup.questions[questionIndex]
    }
    
    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    
    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }
    
    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)" + "/" + "\(questionGroup.questions.count)"
    }
    
}

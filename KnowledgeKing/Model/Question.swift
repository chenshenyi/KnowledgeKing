//
//  Question.swift
//  KnowledgeKing
//
//  Created by CHEN-SHEN-YI on 2018/1/13.
//  Copyright © 2018年 Aptan. All rights reserved.
//

import Foundation

class Question{
    let question : String
    let answer : Bool
    
    init(ca correctAnswer:Bool, tt text:String){
        question = text
        answer = correctAnswer
    }
}

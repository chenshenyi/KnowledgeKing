//
//  ViewController.swift
//  KnowledgeKing
//
//  Created by CHEN-SHEN-YI on 2018/1/13.
//  Copyright © 2018年 Aptan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Score_Label: UILabel!
    @IBOutlet weak var Process_Label: UILabel!
    @IBOutlet weak var ProcessBar: UIImageView!
    @IBOutlet weak var Question_Label: UILabel!
    let allQusetion = QuestionBank()
    var maxAsk = 0
    var currentQuestion = Question(ca: true, tt: "按任意鍵開始")
    var asked = 0
    var score = 0
    var pickAnswer = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        StartOver()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ButtonPress(_ sender: UIButton) {
        if(maxAsk==0){
            StartOver()
        }
        else {
            pickAnswer = (sender.tag==1)
            CheckAnswer()
            NextQuestion()
        }
    }
    
    func NextQuestion(){
        asked+=1
        if(asked<=maxAsk){
            currentQuestion = allQusetion.GetQuestion()
            Display()
        }
        else{
            let alert = UIAlertController(title: "Very Good", message: "完成所有題目，共計\(score)分，是否重來", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler:{ (UIAlertAction) in
                self.StartOver()
            })
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func SelectMaxAsk(){
        let alert = UIAlertController(title: "開始問答", message: "請選則總題數：", preferredStyle: .alert)
        let five = UIAlertAction(title: "5題", style: .default, handler:{ (UIAlertAction) in
            self.maxAsk = 5
            self.Display()
        })
        let twenty = UIAlertAction(title: "20題", style: .default, handler:{ (UIAlertAction) in
            self.maxAsk = 20
            self.Display()
        })
        let fifty = UIAlertAction(title: "50題", style: .default, handler:{ (UIAlertAction) in
            self.maxAsk = 50
            self.Display()
        })
        alert.addAction(five)
        alert.addAction(twenty)
        alert.addAction(fifty)
        present(alert, animated: true, completion: nil)
    }
    
    func Display(){
        Question_Label.text = currentQuestion.question
        Score_Label.text = "\(score)"
        Process_Label.text =  "\(asked) / \(maxAsk)"
        ProcessBar.frame.size.width = view.frame.size.width / CGFloat(maxAsk) * CGFloat(asked)
    }
    
    func StartOver(){
        SelectMaxAsk()
        currentQuestion = allQusetion.GetQuestion()
        asked = 1
        score = 0
    }
    
    func CheckAnswer(){
        if(pickAnswer==currentQuestion.answer){
            print("Correct")
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }
        else{
            print("Wrong")
            ProgressHUD.showError("Incorrect!")
        }
    }

}


//
//  ViewController.swift
//  hw8SwifyWords
//
//  Created by chang on 2017/6/21.
//  Copyright © 2017年 chang. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    @IBOutlet weak var cluesLabel: UILabel!
    //少加個s  answers
    @IBOutlet weak var answersLabel: UILabel!
    @IBOutlet weak var currentAnswer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var letterButtons = [UIButton]()
    var activeateButtons = [UIButton]()
    var solutions = [String]()
    
    
    var level = 1
    
    var score:Int = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for subview in view.subviews where subview.tag == 1001 {
            let btn = subview as! UIButton
            letterButtons.append(btn)
            btn.addTarget(self,action: #selector(letterTapped), for: .touchUpInside)
        }
        //忘了加這行
        loadLevel()
    }
    
    func letterTapped(btn: UIButton){
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        activeateButtons.append(btn)
        btn.isHidden = true
    
    }
    
    func loadLevel(){
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFilePath = Bundle.main.path(forResource: "level\(level)", ofType: "txt"){
            if let levelContents = try? String(contentsOfFile: levelFilePath){
                //\n打錯
                var lines = levelContents.components(separatedBy: "\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.characters.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits
                }
            }
        }
        
        //StoryBoard 的cluesLabel的line忘了改0所以只出現一行
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        
        if letterBits.count == letterButtons.count{
            for i in 0 ..< letterBits.count{
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        if let solutionPosition = solutions.index(of: currentAnswer.text!){
            activeateButtons.removeAll()
            
            var splitClues = answersLabel.text!.components(separatedBy: "\n")
            splitClues[solutionPosition] = currentAnswer.text!
            answersLabel.text = splitClues.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0{
                let ac = UIAlertController(title: "做的好", message: "等級增加囉", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "繼續打拼", style: .default, handler: levelUp))
                present(ac,animated: true)
            }
        }
        
    }
    
    func levelUp(action:UIAlertAction){
        level += 1
        solutions.removeAll(keepingCapacity: true)
        
        loadLevel()
        
        for btn in letterButtons {
            btn.isHidden = false
        }
    }
    
    @IBAction func clearTapped(_ sender: Any) {
        currentAnswer.text = ""
        
        for btn in activeateButtons{
            btn.isHidden = false
        }
        
        activeateButtons.removeAll()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  Trivia
//
//  Created by Nemrud Demir on 11.11.19.
//  Copyright © 2019 Kajetan Kuczorski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var otherViews: [UIView]!
    @IBOutlet var arrayBtns: [CoolButton]!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelFrage: UILabel!
    var currentRightAnswer: String = ""
    var i: Int = 0
    var urlStringApi: String!
    var content: [Result] = []
    var score = 0 {
        didSet {
            labelScore.text = "Score: \(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        let urlString = urlStringApi
        
        if let url = URL(string: urlString!) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    
    @IBAction func btnAnswerTapped(_ sender: CoolButton) {
        sender.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            if sender.titleLabel?.text == self.currentRightAnswer {
                self.score += 10
                self.mainView.backgroundColor = UIColor(named: "Green-1")
                for btn in self.arrayBtns {
                    btn.alpha = 0.2
                }
                sender.alpha = 1
            } else {
                for btn in self.arrayBtns {
                    btn.alpha = 0.2
                    if btn.titleLabel!.text == self.currentRightAnswer {
                        btn.alpha = 1
                    }
                }
                self.mainView.backgroundColor = UIColor(named: "Red-2")
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            for btn in self.arrayBtns {
                btn.alpha = 1
                
            }
            self.mainView.backgroundColor = UIColor(named: "Gray-2")
            self.distributeData(api: self.content)
        })
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let maContent = try? decoder.decode(TriviaAPI.self, from: json) {
            content = maContent.results
            distributeData(api: content)
        } else {
            print("NO")
        }
    }
    
    func backToMainMenu(action: UIAlertAction) {
        performSegue(withIdentifier: "back", sender: self)
    }
    
    func playAgain() {
        i = 0
        let urlString = urlStringApi
        
        if let url = URL(string: urlString!) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func distributeData(api: [Result]) {
        let end: Int = api.count
        guard i < end else {
            let ac = UIAlertController(title: "Well Done", message: "You scored \(score) points.", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Again!", style: .default, handler: nil))
            ac.addAction(UIAlertAction(title: "Back", style: .cancel, handler: backToMainMenu))
            
            present(ac, animated: true)
            return
        }
        labelCategory.text = "\(api[i].category)"
        var currentAnswers: [String] = []
        labelFrage.text = api[i].question
        for answer in api[i].incorrectAnswers {
            currentAnswers.append(answer)
        }
        currentAnswers.append(api[i].correctAnswer)
        currentRightAnswer = api[i].correctAnswer
        currentAnswers.shuffle()
        
        
        for btn in arrayBtns {
            btn.setTitle(currentAnswers.last, for: .normal)
            currentAnswers.removeLast()
        }
        i += 1
    }
    
    func setupViews() {
        mainView.layer.cornerRadius = 8
        mainView.layer.masksToBounds = false
        for view in otherViews {
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = false
        }
    }
}


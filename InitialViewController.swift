//
//  InitialViewController.swift
//  Trivia
//
//  Created by Nemrud Demir on 12.11.19.
//  Copyright © 2019 Kajetan Kuczorski. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var initView: UIView!
    @IBOutlet weak var pickerCategory: UIPickerView!
    @IBOutlet weak var segmentDifficulty: UISegmentedControl!
    @IBOutlet weak var segmentNumberOfQuestions: UISegmentedControl!
    var dataCategory = ["Any", "Animals", "Anime & Manga", "Art", "Board Games", "Books", "Celebrities", "Comics", "Computers", "Film", "General Knowledge", "Geography", "History", "Mathematics", "Music", "Musicals & Theatres", "Mythology", "Politics", "Science & Nature", "Sports", "Television", "Vehicles", "Video Games"]
    var numberOfQuestions: String = "5"
    var difficulty: String = ""
    var category: String = ""
    var urlString: String = ""
    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerCategory.delegate = self
        self.pickerCategory.dataSource = self
        initView.layer.cornerRadius = 8
        initView.layer.masksToBounds = false
        segmentDifficulty.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentNumberOfQuestions.setTitleTextAttributes(titleTextAttributes, for: .normal)
    }
    
    
    @IBAction func difficultyChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            difficulty = ""
        case 1:
            difficulty = "easy"
        case 2:
            difficulty = "medium"
        case 3:
            difficulty = "hard"
        default:
            break
        }
    }
    
    @IBAction func numberOfQuestionsChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            numberOfQuestions = "5"
        case 1:
            numberOfQuestions = "10"
        case 2:
            numberOfQuestions = "15"
        case 3:
            numberOfQuestions = "20"
        default:
            break
        }
    }
    
    @IBAction func startTapped(_ sender: Any) {
        let cat = self.pickerView(self.pickerCategory, attributedTitleForRow: self.pickerCategory.selectedRow(inComponent: 0), forComponent: 0)
        let categoryOfPicker = getPickerValue(picker: cat!)
        
        urlString = "https://opentdb.com/api.php?amount=\(numberOfQuestions)&category=\(categoryOfPicker)&difficulty=\(difficulty)&type=multiple"
        let vc = ViewController()
        vc.urlStringApi = urlString
        
        performSegue(withIdentifier: "segueToQuiz", sender: self)
    }
    
    func getPickerValue(picker: NSAttributedString) -> String {
        switch picker.string {
        case "Art":
            return "25"
        case "Books":
            return "12"
        case "Computers":
            return "18"
        case "Film":
            return "11"
        case "General Knowledge":
            return "9"
        case "Geography":
            return "22"
        case "History":
            return "23"
        case "Mathematics":
            return "19"
        case "Music":
            return "14"
        case "Mythology":
            return "20"
        case "Politics":
            return "24"
        case "Science & Nature":
            return "17"
        case "Sports":
            return "21"
        case "Vehicles":
            return "28"
        case "Video Games":
            return "15"
        case "Musicals & Theatres":
            return "13"
        case "Television":
            return "14"
        case "Board Games":
            return "16"
        case "Celebrities":
            return "26"
        case "Animals":
            return "27"
        case "Comics":
            return "29"
        case "Anime & Manga":
            return "31"
        default:
            break
        }
        return ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToQuiz" {
            let vc = segue.destination as! ViewController
            vc.urlStringApi = urlString
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataCategory.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: dataCategory[row], attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
}

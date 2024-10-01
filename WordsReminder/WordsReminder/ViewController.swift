//
//  ViewController.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 01.10.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var list_of_words: UIScrollView!
    
    var currentYPosition: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list_of_words.isScrollEnabled = true
        
        addNewWord("pepe", description: "something")
        addNewWord("pepe", description: "something")
        addNewWord("pepe", description: "something")
        
    }


    @IBAction func newWordCreation(_ sender: UIButton) {
        print("new word creation")
        addNewWord("pepe", description: "something")
    }
    
    private func addNewWord(_ word: String, description: String) {
            let newWord = WordItem(word, description)
            let newWordView = WordItemView(word: newWord)
            
            newWordView.frame = CGRect(x: 10, y: currentYPosition, width: list_of_words.frame.width - 20, height: 50)
            
            list_of_words.addSubview(newWordView)
            
            currentYPosition += 60
            
            list_of_words.contentSize = CGSize(width: list_of_words.frame.width, height: currentYPosition)
        }
    
    @IBAction func editList(_ sender: UIButton) {
        print("nothing")
    }
    
}


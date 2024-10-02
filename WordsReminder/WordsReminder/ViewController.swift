//
//  ViewController.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 01.10.2024.
//

import UIKit

class ViewController: UIViewController, WordCreationDelegate {

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
        let creator: CreatorViewController = CreatorViewController()
        creator.delegate = self
        self.present(creator, animated: true, completion: nil)
        
//        addNewWord("pepe", description: "something")
    }
    
    public func addNewWord(_ word: String, description: String) {
        let newWord = WordItem(word, description)
        let newWordView = WordItemView(word: newWord)
        
        // Set the frame for the new word view, which will be added at the top
        newWordView.frame = CGRect(x: 10, y: 10, width: list_of_words.frame.width - 20, height: 50)

        // Shift all existing subviews down to make room for the new word at the top
        for subview in list_of_words.subviews {
            subview.frame = subview.frame.offsetBy(dx: 0, dy: 60)
        }

        // Add the new word view at the top
        list_of_words.addSubview(newWordView)

        // Update the content size of the scroll view
        currentYPosition += 60
        list_of_words.contentSize = CGSize(width: list_of_words.frame.width, height: currentYPosition)
    }
    
    @IBAction func editList(_ sender: UIButton) {
        print("nothing")
    }
    
}

protocol WordCreationDelegate: AnyObject {
    func addNewWord(_ word: String, description: String)
}


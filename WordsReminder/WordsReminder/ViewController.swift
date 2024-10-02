//
//  ViewController.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 01.10.2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, WordCreationDelegate {
    
    private var storage = Storage()
    
    @IBOutlet var list_of_words: UIScrollView!
    
    var currentYPosition: CGFloat = 10.0
    
    var words = [WordItem]()
    
    func get_data() async -> [WordItem]{
        do {
            try await storage.load()
            return storage.words
        }
        catch {
            fatalError(error.localizedDescription)
        }
        return []
    }
    
    func save_data() async {
        do{
            try await storage.save(words: words)
        }
        catch{
            fatalError(error.localizedDescription)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list_of_words.isScrollEnabled = true
        
        Task { 
            let last_words = await get_data()
            for word in last_words{
                addNewWord(word.word, description: word.description)
            }
        }
        
    }
  
    
    func clear(){
        words.removeAll()
    }
    

    @IBAction func newWordCreation(_ sender: UIButton) {
        print("new word creation")
        let creator: CreatorViewController = CreatorViewController()
        creator.delegate = self
        self.present(creator, animated: true, completion: nil)
    }
    
    public func addNewWord(_ word: String, description: String) {
        let newWord = WordItem(word, description)
        
        words.append(newWord)
        
        let newWordView = WordItemView(word: newWord)
        
        newWordView.frame = CGRect(x: 10, y: 10, width: list_of_words.frame.width - 20, height: 50)

        for subview in list_of_words.subviews {
            subview.frame = subview.frame.offsetBy(dx: 0, dy: 60)
        }

        list_of_words.addSubview(newWordView)
        
        currentYPosition += 60
        list_of_words.contentSize = CGSize(width: list_of_words.frame.width, height: currentYPosition)
        
        Task{
            await save_data()
        }
    }
    
    @IBAction func editList(_ sender: UIButton) {
        print("nothing")
    }
    
}

protocol WordCreationDelegate: AnyObject {
    func addNewWord(_ word: String, description: String)
}


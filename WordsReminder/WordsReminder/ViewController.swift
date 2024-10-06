//
//  ViewController.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 01.10.2024.
//

import UIKit
import SwiftUI

class ViewController: UIViewController, WordManagement {
    
    @IBOutlet var list_of_words: UIScrollView!
    
    var currentYPosition: CGFloat = 10.0

    var wordsViews = [String: WordItemView]()
    
    func clear_data(){
        Container.shared.clear_data()
        let subViews = self.list_of_words.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
        Container.shared.remove_all ()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list_of_words.isScrollEnabled = true
        list_of_words.showsVerticalScrollIndicator = false
        
        Task {
            let last_words = await Container.shared.get_data()
            for word in last_words{
                addNewWord(word.word, description: word.description)
            }
        }
        
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        self.clear_data()
    }
    
    @IBAction func newWordCreation(_ sender: UIButton) {
        print("new word creation")
        let creator: CreatorViewController = CreatorViewController()
        creator.delegate = self
        self.present(creator, animated: true, completion: nil)
    }
    
    public func addNewWord(_ word: String, description: String) {
        let newWord = WordItem(word, description)
        
        Container.shared.add_word(newWord)
        
        let newWordView = WordItemView(word: newWord)
        newWordView.delegate = self
        
        wordsViews[newWord.word] = newWordView
        
        newWordView.frame = CGRect(x: 10, y: 10, width: list_of_words.frame.width - 20, height: 50)

        for subview in list_of_words.subviews {
            subview.frame = subview.frame.offsetBy(dx: 0, dy: 60)
        }

        list_of_words.addSubview(newWordView)
        
        currentYPosition += 60
        list_of_words.contentSize = CGSize(width: list_of_words.frame.width, height: currentYPosition)
        
        Task{
            await Container.shared.save_data()
        }
    }
    
    public func removeWord(_ word: String) {
        let wordView = wordsViews[word]
        
        wordView?.removeFromSuperview()
        Container.shared.remove_word(word)
        let removedViewYPosition = wordView?.frame.origin.y ?? 0
        for subview in list_of_words.subviews {
            if subview.frame.origin.y > removedViewYPosition {
                subview.frame = subview.frame.offsetBy(dx: 0, dy: -60)
            }
        }
        
        currentYPosition -= 60
        list_of_words.contentSize = CGSize(width: list_of_words.frame.width, height: currentYPosition)
        
        Task {
            await Container.shared.save_data()
        }
    }
    
    public func editWord(_ old_version: String, _ word: String, description: String) {
        let word_to_change = Container.shared.get_word(old_version)
        word_to_change!.change(word, description)
        
        Task {
            await Container.shared.save_data()
        }
    }
    
    public func showDict(_ word: String, _ description: String, _ wordView: WordItemView) {
        let dictVC = DictionaryViewController()
        dictVC.delegate = wordView
        self.present(dictVC, animated: true, completion: nil)
        dictVC.onShow(word: word, description: description)
    }
    
}

protocol WordManagement: AnyObject {
    func addNewWord(_ word: String, description: String)
    func removeWord(_ word: String)
    func editWord(_ old_version: String, _ word: String, description: String)
    func showDict(_ word: String, _ description: String, _ wordView: WordItemView)
}


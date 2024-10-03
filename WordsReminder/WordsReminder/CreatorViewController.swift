//
//  CreatorViewController.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 01.10.2024.
//
import UIKit

class CreatorViewController: UIViewController {

    @IBOutlet var input_word: UITextField!
    
    @IBOutlet var input_description: UITextView!
    
    weak var delegate: WordManagement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        input_description.isEditable = true
        input_description.isScrollEnabled = true
        input_description.isUserInteractionEnabled = true
        
        // Do any additional setup after loading the view.
    }

    @IBAction func exitAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDone(_ sender: Any) {
        
        guard input_word.text?.isEmpty == false || input_word.text?.isEmpty == false else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        delegate?.addNewWord(String(input_word.text!), description: String(input_description.text!))
        self.dismiss(animated: true, completion: nil)
    }
}

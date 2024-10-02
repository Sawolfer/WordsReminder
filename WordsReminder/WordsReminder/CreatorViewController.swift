//
//  CreatorViewController.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 01.10.2024.
//
import UIKit

class CreatorViewController: UIViewController {

    @IBOutlet var input_word: UITextField!
    
    @IBOutlet var input_description: UITextField!
    
    weak var delegate: WordCreationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

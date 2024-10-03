//
//  DictionaryViewController.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 04.10.2024.
//

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet var TextInput: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TextInput.isEditable = true
        TextInput.isScrollEnabled = true
        TextInput.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    init(word: String, definition: String){
        
    }


    @IBAction func onDone(_ sender: Any) {
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

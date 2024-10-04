//
//  DictionaryViewController.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 04.10.2024.
//

import UIKit

class DictionaryViewController: UIViewController {

    @IBOutlet var wordView: UITextView!
    @IBOutlet var descriptionView: UITextView!
    
    weak var delegate: Changintable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionView.isEditable = true
        descriptionView.isScrollEnabled = true
        descriptionView.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    public func onShow(word: String, description: String){
        wordView.text = "\(word)"
        descriptionView.text = "\(description)"
    }


    @IBAction func onDone(_ sender: Any) {
        delegate?.change(wordView.text, descriptionView.text)
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

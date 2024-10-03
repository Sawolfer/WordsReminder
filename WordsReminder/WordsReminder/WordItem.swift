//
//  WordItem.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 01.10.2024.
//
import SwiftUI
import UIKit


class WordItem: Codable{
    var word: String
    var description: String
    
    
    public init(_ word: String, _ description: String) {
        self.word = word
        self.description = description
    }
    
}

class WordItemView: UIView {
    private let wordLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let swipe_to_delete = UISwipeGestureRecognizer()
    
    weak var delegate: WordManagement?
    
    init(word: WordItem) {
        super.init(frame: .zero)
        setupView(word)
        setupSwipeToDelete()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(_ word: WordItem) {
        self.layer.cornerRadius = 20
        
        wordLabel.text = word.word
        wordLabel.font = .systemFont(ofSize: 16, weight: .bold)
        wordLabel.frame = CGRect(x: 10, y: 5, width: 100, height: 20)
        wordLabel.textColor = .white
        addSubview(wordLabel)
        
        descriptionLabel.text = word.description
        descriptionLabel.frame = CGRect(x: 10, y: 25, width: 200, height: 20)
        descriptionLabel.textColor = .white
        addSubview(descriptionLabel)
        
        self.backgroundColor = .systemBlue
    }
    
    func setupSwipeToDelete() {
        swipe_to_delete.direction = .left
        swipe_to_delete.addTarget(self, action: #selector(handleSwipeToDelete))
        addGestureRecognizer(swipe_to_delete)
    }
    
    @objc private func handleSwipeToDelete() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = self.frame.offsetBy(dx: -self.frame.width, dy: 0)
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
        delegate?.removeWord(self.wordLabel.text!)
        print("Delete word: \(self.wordLabel.text ?? "")")
    }
}

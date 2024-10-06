//
//  Storage.swift
//  WordsReminder
//
//  Created by Савва Пономарев on 02.10.2024.
//

import Foundation
import SwiftUI


class Storage: ObservableObject{
    
    @Published var words: [WordItem] = []
    
    private static func fileURL() -> URL{
        let fileName = "words.json"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func clear() async throws{
        let fileURL = Self.fileURL()
        let text = ""
        try text.write(to: fileURL, atomically: false, encoding: .utf8)
    }
    
    func load() async throws{
        
        let task = Task<[WordItem], Error> {
            let fileURL = Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return[]
            }
            let words = try JSONDecoder().decode([WordItem].self, from: data)
            return words
        }
        let words = try await task.value
        self.words = words
    }
    
    
    func save(words: [WordItem]) async throws{
        let task = Task{
            let data = try JSONEncoder().encode(words)
            let outFileURL = Self.fileURL()
            try data.write(to: outFileURL)
        }
        
        try await task.value
    }
}

class Container{
    
    static let shared = Container()
    var storage: Storage
    
    var words = [WordItem]()
    
    init(){
        self.storage = Storage()
    }
    
    func container_load() async {
        do {
            try await storage.load()
            print("Storage loaded successfully")
        } catch {
            print("Failed to load storage: \(error.localizedDescription)")
        }
    }
    
    func add_word(_ word: String, _ description: String){
        let new_word = WordItem(word,description)
        words.append(new_word)
    }
    
    func add_word(_ word: WordItem){
        words.append(word)
    }
    
    func remove_word(_ word: String){
        words.removeAll(where: { $0.word == word })
    }
    
    func remove_all(){
        words.removeAll()
    }
    
    func get_length() -> Int{
        return words.count
    }
    
    func get_word(index: Int) -> WordItem?{
        if words.isEmpty{
            return nil
        }
        return words[index]
    }
    
    func get_word(_ word: String) -> WordItem?{
        if words.isEmpty{
            return nil
        }
        for wordItem in words{
            if wordItem.word == word{
                return wordItem
            }
        }
        return nil
    }
    
    func get_data() async -> [WordItem]{
        do {
            try await storage.load()
            return storage.words
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func save_data() async {
        do{
            try await storage.save(words: words)
        }
        catch{
            fatalError(error.localizedDescription)
        }
    }
    
    func clear_data(){
        Task{
            try await storage.clear()
        }
    }
    
}

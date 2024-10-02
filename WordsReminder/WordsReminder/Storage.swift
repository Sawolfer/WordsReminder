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
    
    private func clear() async throws{
        let fileURL = Self.fileURL()
        try FileManager.default.removeItem(at: fileURL)
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

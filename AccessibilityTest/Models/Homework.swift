//
//  Homework.swift
//  AccessibilityTest
//
//  Created by stakata on 2018/06/28.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

struct Homework: Decodable {
    let id: Int
    let imageUrl: String
    let title: String
    let description: String
    let priority: Priority
    var todos: [Todo]
    private(set) var isOnTrack: Bool
    
    mutating func toggleIsOnTrack() {
        isOnTrack = !isOnTrack
    }
}

struct Todo: Decodable {
    let id: String
    let content: String
    private(set) var isCompleted: Bool
    
    mutating func toggleIsCompleted() {
        isCompleted = !isCompleted
    }
}

enum Priority: Decodable {
    case norating, rating(value: Int)
}

extension Priority {
    
    enum PriorityCodingError: Error {
        case decoding(Int)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)

        if 0 > value || 5 < value {
            throw PriorityCodingError.decoding(value)
        }
        self = (value == 0) ? .norating : .rating(value: value)
    }
}


//
//  TeamModel.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/07/06.
//

import Foundation

    // MARK: - Welcome
struct Team: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: DataClass
}

struct DataClass: Codable {
    let myPuzzle: MyPuzzle
    let teamPuzzleBoard: [TeamPuzzleBoard]
}

struct MyPuzzle: Codable {
    let nickname: String
    let puzzleCount: Int
}

struct TeamPuzzleBoard: Codable {
    let reviewDay, reviewDate: String
    let reviewMemberCount: Int
}

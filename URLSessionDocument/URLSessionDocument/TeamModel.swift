//
//  TeamModel.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/07/06.
//

import Foundation

    // MARK: - TeamDashboardModel
struct TeamDashboardModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: TeamData
}

struct TeamData: Codable {
    let myPuzzle: MyPuzzle
    let teamPuzzleBoard: [TeamPuzzleBoard]
}

struct TeamPuzzleBoard: Codable {
    let reviewDay, reviewDate: String
    let reviewMemberCount: Int
}

    // MARK: - TeamProjectRankModel
struct TeamProjectRankModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [TeamProjectRank]
}

struct TeamProjectRank: Codable {
    let memberRank: Int
    let memberNickname, memberRole: String
    let memberPuzzleCount: Int
}

    // MARK: - TeamProject

//
//  IndivisualModel.swift
//  URLSessionDocument
//
//  Created by KYUBO A. SHIM on 2023/07/06.
//

import Foundation

    // MARK: - IndivisualDashBoardModel
struct IndivisualDashboardModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: IndivisualData
}

struct IndivisualData: Codable {
    let myPuzzle: MyPuzzle
    let userPuzzleBoard: [UserPuzzleBoard]
    let isReviewDay: Bool
}

    // MARK: MyPuzzle
struct MyPuzzle: Codable {
    let nickname: String
    let puzzleCount: Int
}

    // MARK: UserPuzzleBoard
struct UserPuzzleBoard: Codable {
    let reviewDay, reviewDate: String
    let reviewId: Int?
}


    // MARK: - ActionPlanModel
struct ActionPlanModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [ActionPlan]
}

struct ActionPlan: Codable {
    let actionPlanContent, actionPlanDate: String
}


    // MARK: - OngoingProjectsModel
struct OngoingProjectsModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [OngoingProjectInfo]
}

struct OngoingProjectInfo: Codable {
    let userProjectId: Int
    let projectName: String
}

//
//  Movie.swift
//  NetflexClone
//
//  Created by 김희진 on 2022/04/04.
//

import Foundation

struct TrendginTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

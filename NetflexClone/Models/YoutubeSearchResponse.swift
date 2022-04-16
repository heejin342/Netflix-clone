//
//  YoutubeSearchResponse.swift
//  NetflexClone
//
//  Created by 김희진 on 2022/04/14.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}

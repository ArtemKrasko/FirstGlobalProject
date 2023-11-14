//
//  YouTubeSearchResponse.swift
//  MyFirestWorkMovieApp
//
//  Created by Artem Krasko on 05.12.2022.
//

import Foundation

struct YouTubeSearchResponse: Codable{
    let items: [VideoElement]
}

struct VideoElement: Codable{
    let id: IdVideoElement
}

struct IdVideoElement: Codable{
    let kind: String
    let videoId: String
}

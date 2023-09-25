//
//  Youtube.swift
//  Spotidy
//
//  Created by Artem on 13/09/2023.
//

import Foundation

// MARK: - Youtube
struct Youtube: Codable {
    let kind, etag, nextPageToken, regionCode: String?
    let pageInfo: PageInfo?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let kind, etag: String?
    let id: ID?
}

// MARK: - ID
struct ID: Codable {
    let kind, videoID, channelID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
        case channelID = "channelId"
    }
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}

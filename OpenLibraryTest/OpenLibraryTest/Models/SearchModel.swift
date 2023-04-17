//
//  SearchModel.swift
//  OpenLibraryTest
//
//  Created by Александр Янчик on 14.04.23.
//

import Foundation

struct SearchModel: Decodable {
    var booksList: [BookModel]
    
    enum CodingKeys: String, CodingKey {
        case booksList = "docs"
    }
}
 
struct BookModel: Decodable {
    var keyWork: String
    var title: String
    var firstPublishYear: Int?
    var averageRating: Double?
    var coverEditKey: String?
    var coverId: Int?
    
    enum CodingKeys: String, CodingKey {
        case keyWork = "key"
        case title = "title"
        case firstPublishYear = "first_publish_year"
        case averageRating = "ratings_average"
        case coverEditKey = "cover_edition_key"
        case coverId = "cover_i"
    }
}

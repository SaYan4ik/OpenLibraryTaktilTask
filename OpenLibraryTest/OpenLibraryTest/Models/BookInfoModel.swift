//
//  BookInfoModel.swift
//  OpenLibraryTest
//
//  Created by Александр Янчик on 15.04.23.
//

import Foundation

struct BookInfoModel: Decodable {
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
    }
}

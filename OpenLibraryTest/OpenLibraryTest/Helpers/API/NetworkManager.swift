//
//  NetworkManager.swift
//  OpenLibraryTest
//
//  Created by Александр Янчик on 14.04.23.
//

import Foundation
import Moya

final class NetworkManager {
    private let provider = MoyaProvider<OpenLibraryAPI>(plugins: [NetworkLoggerPlugin()])
    
    func searchBooks(complition: @escaping (SearchModel) -> Void, failure: @escaping ((String) -> Void)) {
        provider.request(.searchBooks) { result in
            switch result {
                case .success(let response):
                    guard let books = try? JSONDecoder().decode(SearchModel.self, from: response.data) else { return }
                    print(books)
                    complition(books)
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
    
    func getBookDescription(key: String, complition: @escaping (String) -> Void, failure: @escaping ((String) -> Void)) {
        provider.request(.getBookDescription(key: key)) { result in
            switch result {
                case .success(let response):
                    guard let bookInfo = try? JSONDecoder().decode(BookInfoModel.self, from: response.data) else { return }
                    complition( bookInfo.description ?? "Book haven't description")
                case .failure(let error):
                    failure(error.localizedDescription)
            }
        }
    }
}

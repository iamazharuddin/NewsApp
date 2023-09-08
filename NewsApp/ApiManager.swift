//
//  ApiManager.swift
//  NewsApp
//
//  Created by Azharuddin 1 on 05/09/23.
//

import Foundation

enum ApiError : Error {
    case invalidUrl
}

let API_KEY = "8155dc406adb4fe3a168144452f8e4c6"
class ApiManager {
    static let shared = ApiManager()
    func fetchNews() async  throws -> [Article] {
        let urlString = "https://newsapi.org/v2/everything?q=bitcoin&apiKey=\(API_KEY)"
        guard  let url = URL(string: urlString) else { throw ApiError.invalidUrl }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
           let newsModel =  try  JSONDecoder().decode(NewsResponse.self, from: data)
            
            return newsModel.articles
            
        } catch let error  {
            print(error.localizedDescription)
            
            throw error
        }
    }
    
    func searchNews(with text : String ) async  throws -> [Article] {
        let urlString = "https://newsapi.org/v2/everything?q=\(text)&apiKey=\(API_KEY)"
        guard  let url = URL(string: urlString) else { throw ApiError.invalidUrl }
        let urlRequest = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
           let newsModel =  try  JSONDecoder().decode(NewsResponse.self, from: data)
            
            return newsModel.articles
            
        } catch let error  {
            print(error.localizedDescription)
            
            throw error
        }
    }
}



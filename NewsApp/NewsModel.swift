//
//  NewsModel.swift
//  NewsApp
//
//  Created by Azharuddin 1 on 05/09/23.
//

import Foundation
struct NewsResponse : Decodable{
    let  articles : [Article]
}


struct Article: Decodable {
    let title : String?
    let description : String?
    let urlToImage : String?
}

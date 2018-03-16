//
//  Article.swift
//  NewsFeed
//
//  Created by Abhishek K on 15/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
class Article:Codable{
    var source:Source?
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
}

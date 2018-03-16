//
//  News.swift
//  NewsFeed
//
//  Created by Abhishek K on 15/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
class News:Codable{
    var status:String?
    var totalResults:Int?
    var articles:[Article]?
}

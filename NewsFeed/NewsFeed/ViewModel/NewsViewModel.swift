//
//  NewsViewModel.swift
//  NewsFeed
//
//  Created by Abhishek K on 16/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
class NewsViewModel{
    
    var news:News?
    var artileViewModels:[ArticleViewModel]? = [ArticleViewModel]()
    var statusText:String{
        guard let status = news?.status else{
            return "No status"
        }
        return status
    }
    
    var totoalResult:Int{
        guard let total = news?.totalResults else{
            return 0
        }
        return total
    }
    var articleArr:[Article]{
        guard let arr = news?.articles else{
            return [Article]()
        }
        return arr
        
    }
    
    
    init(news:News) {
        self.news = news
    }
    
    
}
extension NewsViewModel{
    
    convenience init(data:News) {

        self.init(news: data)
        for article in data.articles!{
            let articleViewModel = ArticleViewModel(article: article)
            
            artileViewModels?.append(articleViewModel)
            
        }
    }
  
}

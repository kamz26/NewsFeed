//
//  AppManager.swift
//  NewsFeed
//
//  Created by Abhishek K on 15/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class AppManager{
    
    enum Keys:String{
        case title
        case author
        case description
        case urlToImage
        case publishedAt
        case image
        case url
        case status
        case totalResults
    }
    struct  Constant {
        static let url = "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=a8fabd9ff4234c82aad08eaaa4ea17a0&pageSize=5&page="
    }
    
    class DataManager{
        var delegate = UIApplication.shared.delegate as! AppDelegate
        var context:NSManagedObjectContext{
            return delegate.persistentContainer.viewContext
        }
        
        func add(strData:Dictionary<String,Any>) -> Bool{
            let article = ArticleData(context: context)
            article.title = strData[AppManager.Keys.title.rawValue] as? String
            article.author = strData[AppManager.Keys.author.rawValue] as? String
            article.url = strData[AppManager.Keys.url.rawValue] as? String
            article.urlToImage = strData[AppManager.Keys.urlToImage.rawValue] as? String
            article.publishedAt = strData[AppManager.Keys.publishedAt.rawValue] as? String
            article.image = strData[AppManager.Keys.image.rawValue] as? Data
            article.articleDescription = strData[AppManager.Keys.description.rawValue] as? String
            delegate.saveContext()
            return true
            
        }
        
        
        func fetch() -> [ArticleData]?{
            let fetchRequest = NSFetchRequest<ArticleData>(entityName: "ArticleData")
            do{
                let fetchResults = try context.fetch(fetchRequest)
                return fetchResults
            }catch{
                print("Error while fetching data!!!")
            }
            return nil
        }
        
        func delete(){
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "ArticleData")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do
            {
                try context.execute(deleteRequest)
                try context.save()
            }
            catch
            {
                print ("There was an error")
            }
        }
    }
}

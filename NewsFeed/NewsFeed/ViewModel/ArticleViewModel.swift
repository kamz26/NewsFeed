//
//  ArticleViewModel.swift
//  NewsFeed
//
//  Created by Abhishek K on 15/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import Foundation
import UIKit

protocol CellRepresent {
    func cellInstance(_ tableView:UITableView, indexPath:IndexPath) -> UITableViewCell
}

class ArticleViewModel:CellRepresent {

    var article:Article?
    
    var titleText:String{
        guard let title = article?.title else{
            return "No title"
        }
        return title
    }
    var descriptionText:String{
        guard let description = article?.description else {
            return "No Description"
        }
        return description
    }
    var imageData:UIImage?{
        
        guard let image = article?.urlToImage else{
            return UIImage.init(named: "No-image-available")!
        }
        
        do{
            let data = try Data.init(contentsOf: URL.init(string:image)!)
            return UIImage.init(data: data)!
        }catch{
            print("Error while Data Conversion")
        }
        return nil
    }
    
    var urlText:String{
        guard let url = article?.url else{
            return "https://www.google.com"
        }
        
        return url
    }
    
    
    
    init(article:Article) {
        self.article = article
    }
    
    
    func cellInstance(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AricleCellTableViewCell
        
        cell.configure(vm:self)
        return cell

    }
    
}

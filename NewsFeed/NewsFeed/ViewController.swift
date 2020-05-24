//
//  ViewController.swift
//  NewsFeed
//
//  Created by Abhishek K on 15/03/18.
//  Copyright © 2018 Abhishek K. All rights reserved.
//

import UIKit





class ViewController: UIViewController {

    
    @IBOutlet weak var articleTableView: UITableView!
    var urlString = AppManager.Constant.url
    var newsDataArr = [Article]()
    var page = 1
    var newsViewModel:NewsViewModel?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleFresh),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    var delegate = UIApplication.shared.delegate as! AppDelegate
    var newsCacheData:[ArticleData]? = [ArticleData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCacheData()
        if newsCacheData?.count == 0{
            loadData()
        }
        articleTableView.addSubview(self.refreshControl)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func handleFresh(){
//        newsViewModel?.artileViewModels = [ArticleViewModel]()
        AppManager.DataManager().delete()
        newsCacheData = [ArticleData]()
        self.page = 1
        loadData()
        refreshControl.endRefreshing()
        
    }
    func loadCacheData(){
        newsCacheData = AppManager.DataManager().fetch()!
    }
    
    func loadData(){
        let urlStr = urlString + "\(page)"
        let url = URL(string: urlStr)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else{
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let newsData = try decoder.decode(News.self, from: data)
                
                DispatchQueue.main.sync {
                    self.addNews(data: newsData)
                }
                if newsData.articles!.count > 0{
                    self.newsViewModel = NewsViewModel(data:newsData)
                    self.newsDataArr += newsData.articles!
                    self.page = self.page + 1
                    self.loadData()
                }
                DispatchQueue.main.async {
                    self.articleTableView.reloadData()
                    
                }
                
            } catch let err {
                print("Err", err)
            }
            
            
        }
        task.resume()
        
    }
    
    func addNews(data:News){
        
        
        for article in data.articles!{
            var dict = [String:Any?]()
            dict[AppManager.Keys.title.rawValue] = article.title
            dict[AppManager.Keys.description.rawValue] = article.description
            dict[AppManager.Keys.url.rawValue] = article.url
            dict[AppManager.Keys.urlToImage.rawValue] = article.urlToImage
            dict[AppManager.Keys.publishedAt.rawValue] = article.publishedAt
            dict[AppManager.Keys.author.rawValue] = article.author
            dict[AppManager.Keys.status.rawValue] = data.status
            dict[AppManager.Keys.totalResults.rawValue] = data.totalResults
            do{
                if let urltoimage = article.urlToImage , let url = URL.init(string: urltoimage){
                    let data = try Data.init(contentsOf: url)
                    dict[AppManager.Keys.image.rawValue] = UIImagePNGRepresentation(UIImage.init(data: data)!)
                }else{
                    
                }
            }catch{
                print("Erro while coverting image!!!")
            }
            
            if AppManager.DataManager().add(strData: dict as Any as! Dictionary<String, Any> ){
                print("added to core data!!")
            }
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




extension ViewController:UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
     
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.newsCacheData!.count > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AricleCellTableViewCell
            if let title = self.newsCacheData![indexPath.row].title{
                cell.title.text = title
            }
            
            if let url = self.newsCacheData![indexPath.row].url{
                cell.urlLink.text = url
            }
            if let description = self.newsCacheData?[indexPath.row].articleDescription{
                cell.articleDescription.text = description
            }
            do{
                if let urlToImage = self.newsCacheData![indexPath.row].urlToImage,
                    let url = URL.init(string: urlToImage){
                    DispatchQueue.main.async {
                        do{
                        cell.articleImage.image = UIImage.init(data: try Data.init(contentsOf: url))
                        }catch{
                            print(error)
                        }
                    }
                    
                }
            }catch{
                print("error in getting the data")
            }
            
            return cell
        }else if newsDataArr.count > 0 &&  newsViewModel!.artileViewModels!.count > 0{
            
            return (self.newsViewModel?.artileViewModels![indexPath.row].cellInstance(tableView,indexPath: indexPath))!
            
            

        }else{
            return UITableViewCell()
        }
    }
    
    
    
    
    
}


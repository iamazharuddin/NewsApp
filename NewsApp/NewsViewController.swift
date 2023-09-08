//
//  ViewController.swift
//  NewsApp
//
//  Created by Azharuddin 1 on 05/09/23.
//

import UIKit

class NewsViewController: UIViewController {
    
    let searchVC = UISearchController(searchResultsController: nil)
    
    var selectedIndex : Int = -1
    
    private var newsArticles = [Article]()
    
    private let newsTableView : UITableView = {
        let tableView = UITableView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifire)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(newsTableView)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        fetchNewsData()
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newsTableView.frame = view.bounds
    }
}


extension  NewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath.row{
            return UITableView.automaticDimension
        }
        return 120
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifire, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        let model = newsArticles[indexPath.row]
        cell.titleLabel.text = model.title ?? ""
        if indexPath.row == selectedIndex {
            cell.descriptionLabel.text = model.description ?? ""
        }else {
            cell.descriptionLabel.text  = ""
        }
        if let  url = URL(string: model.urlToImage ?? "") {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    cell.customImageView.image = image
                }
            }.resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex == -1{
            // 1rd case :- no cell is expanded
            selectedIndex = indexPath.row
            tableView.reloadRows(at: [ IndexPath(row: selectedIndex, section: indexPath.section) ], with: .fade)
        }else{
            if  selectedIndex == indexPath.row {
                // 2st case :- cell is already expanded and same cell clicked
                selectedIndex = -1
                tableView.reloadRows(at: [indexPath ], with: .fade)
            } else {
                // 3nd case :- cell is already expanded and other cell clicked
                let expandedIndex = selectedIndex
                selectedIndex = indexPath.row
                tableView.reloadRows(at: [indexPath, IndexPath(row: expandedIndex, section: indexPath.section)], with: .fade)
            }
        }
    }
}


extension NewsViewController {
    private func fetchNewsData(){
        Task{
            ActivityIndicatorManager.shared.showActivityIndicator(on: view)
            let artcles =  try?  await ApiManager.shared.fetchNews()
            ActivityIndicatorManager.shared.hideActivityIndicator()
            DispatchQueue.main.async {
                self.newsArticles = artcles ?? [Article]()
                self.newsTableView.reloadData()
            }
        }
    }
}



extension NewsViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        Task{
            ActivityIndicatorManager.shared.showActivityIndicator(on: view)
            let artcles =  try?  await ApiManager.shared.searchNews(with: text)
            ActivityIndicatorManager.shared.hideActivityIndicator()
            DispatchQueue.main.async {
                self.newsArticles = artcles ?? [Article]()
                self.newsTableView.reloadData()
                self.searchVC.dismiss(animated: true)
            }
        }

    }
}

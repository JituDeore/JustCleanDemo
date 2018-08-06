//
//  ViewController.swift
//  JustClean
//
//  Created by Jitendra Deore on 06/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import UIKit

// This is for storing the json array ..
typealias JSONItem = [String: Any]

class ViewController: UIViewController {

    var listItems = [ListItem](){
        didSet{
            tableView.reloadData()
        }
    }
    var navTitle: String!
    @IBOutlet weak var tableView: UITableView!
    
    var fetchService: APIService!
    
    /// Lazy instantiation of refersh control
    private lazy var refreshControl: UIRefreshControl = { [unowned self] in
        let _refreshControl = UIRefreshControl()
        _refreshControl.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)
        return _refreshControl
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchService = APIService()
        
        self.edgesForExtendedLayout = []
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchListData()
    }
    
    /// Method to fetch list data on pull to refresh.
    @objc func startRefreshing() {
        fetchService = APIService()
        refreshControl.beginRefreshing()
        listItems.removeAll()
        fetchListData()
    }
    
    /// Method to fetch list data
    func fetchListData() {
       // showProgress()
        
        fetchService.fetchData(apiURL: "https://api.themoviedb.org/3/discover/movie?api_key=1c1519996ca267ab6ebb958a0cd72555&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false") {  [weak self] (result) in
            guard let strongSelf = self else {
                return
            }

           // strongSelf.hideProgress()
            strongSelf.refreshControl.endRefreshing()
           // strongSelf.removeErrorView()
            switch result{
            case .success(let response):
                //strongSelf.listItems = response.listItems
                strongSelf.listItems.append(contentsOf: response.listItems)
//                strongSelf.navTitle = response.title
//                strongSelf.title = response.title
                strongSelf.tableView.reloadData()
                break
            case .failure(let error):
                //self?.handlePageError(error)
                break
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        cell.displayData(with: listItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        fetchListData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = listItems[indexPath.row]
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.listItem = listItem
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
}




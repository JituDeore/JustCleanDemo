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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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




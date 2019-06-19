//
//  FeedsTableViewController.swift
//  WDemo
//
//  Created by Admin on 13/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

class FeedsTableViewController: UITableViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var feedsArray = [Feed]();
    var viewModel: FeedsTableViewModel!
    
    override func viewDidLoad() {
        viewModel = FeedsTableViewModel()
        fetchData()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "feedViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.title = AppConstants.feedsTitle
        let refereshController = UIRefreshControl()
        refereshController.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.refreshControl = refereshController
    }
    
    @objc func refresh(){
        fetchData()
        self.refreshControl?.endRefreshing()
    }
    
    func fetchData() {
        activityIndicator.startAnimating()
        viewModel.fetchFeeds { [weak self] feeds in
            if(feeds.count > 0){
                self?.feedsArray.removeAll()
            }
            self?.feedsArray = feeds
            self?.tableView.reloadData()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedViewCell", for:indexPath) as! TableViewCell
        cell.feed = feedsArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feedDetailsVC = self.viewController(withId: "FeedsDetailsViewController") as! FeedsDetailsViewController
        feedDetailsVC.link = feedsArray[indexPath.row].link
        navigationController?.pushViewController(feedDetailsVC, animated: true)
    }
}

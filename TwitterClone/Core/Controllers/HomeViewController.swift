//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Tammana on 30/11/23.
//

import UIKit

class HomeViewController: UIViewController {

    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.frame = view.bounds
    }
    

}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier) as? TweetTableViewCell else {
            return UITableViewCell()
            
        }
        return cell
    }
    
    
}

//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Tammana on 04/12/23.
//

import UIKit

class ProfileViewController: UIViewController {

    private var profileTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()
    
    private func configureConstraints(){
       let profileTableViewConstraints = [
        profileTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
       ]
        
        NSLayoutConstraint.activate(profileTableViewConstraints)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.addSubview(profileTableView)
        configureConstraints()
        
        let tableHeaderView = ProfileTableHeaderView(frame: CGRect(x: 0, y: 0, width: profileTableView.contentSize.width, height: 380))
        profileTableView.tableHeaderView = tableHeaderView
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .systemBackground
    }


}

extension ProfileViewController : UITableViewDataSource, UITableViewDelegate {
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

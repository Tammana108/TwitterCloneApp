//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by Tammana on 30/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    var XLogo = UIImageView()
    private var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
        
    }()
    
    func configureNavigationBar(){
        let size : CGFloat = 36
        XLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        setLogoImage()
        
        let titleView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        titleView.addSubview(XLogo)
        navigationItem.titleView = titleView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(profileButtonTapped))
        
    }
    
    @objc private func profileButtonTapped(){
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    private func setLogoImage(){
        if self.traitCollection.userInterfaceStyle == .dark{
            XLogo.image = UIImage(named: "XLogoDark")
        }
        else{
            XLogo.image = UIImage(named: "XLogoLight")
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setLogoImage()
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.frame = view.bounds
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
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
        cell.delegate = self
        return cell
    }
}

extension HomeViewController : TweetCellButtonsTappedDelegate {
    func replyButtonTapped() {
        print("Reply")
    }
    
    func likeButtonTapped() {
        print("Like")
    }
    
    func retweetButtonTapped() {
        print("Retweet")
    }
    
    func shareButtonTapped() {
        print("Share")
    }
    
    
}

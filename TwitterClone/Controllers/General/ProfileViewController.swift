//
//  ProfileViewController.swift
//  TwitterClone
//
//  Created by Tammana on 04/12/23.
//

import UIKit
import Combine
import SDWebImage   

class ProfileViewController: UIViewController {

    private var isStatusBarHidden = true
    private lazy var tableHeaderView = ProfileTableHeaderView(frame: CGRect(x: 0, y: 0, width: profileTableView.contentSize.width, height: 380))
    private let viewModel = ProfileViewViewModel()
    private let statusBarView : UIView = {
        let view = UIView()
        view.layer.opacity = 0
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    private var profileTableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
        return tableView
    }()
    
    private var subscriptions : Set<AnyCancellable> = []
    
    private func configureConstraints(){
       let profileTableViewConstraints = [
        profileTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
        profileTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
        profileTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        profileTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
       ]
        let statusBarConstraints = [
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.heightAnchor.constraint(equalToConstant: view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
        ]
        
        NSLayoutConstraint.activate(profileTableViewConstraints)
       // NSLayoutConstraint.activate(statusBarConstraints)
    }
    
    func bindViews() {
        viewModel.$user.sink {[weak self] user in
            guard let user = user else { return }
            
            self?.tableHeaderView.displayNameLabel.text = user.displayName
            self?.tableHeaderView.userNameLabel.text = "@\(user.userName)"
            self?.tableHeaderView.userBioLabel.text = user.bio
            self?.tableHeaderView.joinDateLabel.text = "\(user.createdOn)"
            self?.tableHeaderView.followersCountLabel.text = "\(user.followersCount)"
            self?.tableHeaderView.followingCountLabel.text = "\(user.followingCount)"
            self?.tableHeaderView.joinDateLabel.text = "Joined \(Helper.shared.convertDate(from: user.createdOn))"
            self?.tableHeaderView.profileAvatarImageView.sd_setImage(with: URL(string: user.avatarPath))
        }
        .store(in: &subscriptions)
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        navigationController?.isNavigationBarHidden = true
        //view.addSubview(statusBarView)
        view.addSubview(profileTableView)
        configureConstraints()
        profileTableView.tableHeaderView = tableHeaderView
        profileTableView.contentInsetAdjustmentBehavior = .never
        profileTableView.dataSource = self
        profileTableView.delegate = self
        bindViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.retrieveUser()
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPosition = scrollView.contentOffset.y
        if yPosition > 150 && isStatusBarHidden {
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {[weak self] in
                self?.statusBarView.layer.opacity = 1
                self?.setNeedsStatusBarAppearanceUpdate()
                self?.profileTableView.contentInset.top = 20
            } completion: { _ in

            }
          
        }
        else if yPosition < 0 && !isStatusBarHidden {
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear) {[weak self] in
                self?.statusBarView.layer.opacity = 0
                self?.setNeedsStatusBarAppearanceUpdate()
                self?.profileTableView.contentInset.top = 0
            } completion: { _ in
                
            }
        }
    }
}


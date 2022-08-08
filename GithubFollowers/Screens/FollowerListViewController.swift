//
//  FollowerListViewController.swift
//  GithubFollowers
//
//  Created by Oscar Cristaldo on 2022-07-22.
//

import UIKit

class FollowerListViewController: GFDataLoadingViewController {
    
    enum Section { case main }
    
    var username: String!
    var followers: [Follower]           = []
    var filteredFollowers: [Follower]   = []
    var page                            = 1
    var per_page                        = 100
    var hasMoreFollowers                = true
    var isSearching                     = false
    var isLoadingMoreFollowers          = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearchController()
        configureViewController()
        getFollowers(username: username, page: page, per_page: per_page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        navigationController?.navigationBar.prefersLargeTitles  = true
        view.backgroundColor                                    = .systemBackground
        
        let addButton                                           = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem                       = addButton
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        view.addSubview(collectionView)
        
        collectionView.delegate         = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for an username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    func getFollowers(username: String, page: Int, per_page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page, per_page: per_page)
                updateUI(with: followers)
                dismissLoadingView()
                isLoadingMoreFollowers = false
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlertOnMainThread(title: "Error", message: gfError.rawValue, button: "Ok")
                } else {
                    presentDefaultGFAlert()
                }
                
                isLoadingMoreFollowers = false
                dismissLoadingView()
            }
        }
    }
    
    //    Without async await feature
    //
    //    func getFollowers(username: String, page: Int, per_page: Int) {
    //        showLoadingView()
    //        isLoadingMoreFollowers = true
    //
    //        NetworkManager.shared.getFollowers(for: username, page: page, per_page: per_page) { [weak self] result in
    //            guard let self = self else { return }
    //            self.dismissLoadingView()
    //
    //            switch result {
    //            case .success(let followers):
    //                self.updateUI(with: followers)
    //            case .failure(let error):
    //                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, button: "Ok")
    //            }
    //
    //            self.isLoadingMoreFollowers = false
    //        }
    //    }
    
    func updateUI(with followers: [Follower]) {
        if followers.count < per_page { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😄."
            DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
        }
        
        self.updateData(on: self.followers)
    }
    
    func configureDataSource() {
        dataSource      = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: username)
                addUserToFavorites(user: user)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlertOnMainThread(title: "Error", message: gfError.rawValue, button: "Ok")
                } else {
                    presentDefaultGFAlert()
                }
                dismissLoadingView()
            }
        }
    }
    
    //    Without async await feature
    //
    //    @objc func addButtonTapped() {
    //        showLoadingView()
    //
    //        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
    //            guard let self = self else { return }
    //            self.dismissLoadingView()
    //
    //            switch result {
    //            case .success(let user):
    //                self.addUserToFavorites(user: user)
    //            case .failure(let error):
    //                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, button: "Ok")
    //            }
    //        }
    //    }
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user.", button: "Ok")
                return
            }
            
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, button: "Ok")
        }
    }
}

extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page, per_page: per_page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray                     = isSearching ? filteredFollowers : followers
        let follower                        = activeArray[indexPath.item]
        
        let destinationViewController       = UserInfoViewController()
        destinationViewController.username  = follower.login
        destinationViewController.delegate  = self
        
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        present(navigationController, animated: true)
    }
}

extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
}

extension FollowerListViewController: UserInfoViewControllerDelegate {
    
    func didRequestFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1
        per_page        = 100
        
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page, per_page: per_page)
    }
}

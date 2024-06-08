//
//  FavoritesListVC.swift
//  GitHubFollowers
//
//  Created by Sedat on 3.05.2024.
//

import UIKit

class FavoritesListVC: GFDataLoadingVC {
    
    let tableView = UITableView()
    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearFavoritesTapped))
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let favorites):
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen 😘", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentGFAlert(title: "Something went wrong!", message: error.rawValue, buttonTitle: "Ok")
                }
            }
        }
    }
    
//    @objc func clearFavoritesTapped() {
//        PersistenceManager.clearAllFavorites { [weak self] error in
//            guard let self else { return }
//            if let error {
//                self.presentGFAlert(title: "Unable to clear favorites", message: error.rawValue, buttonTitle: "Ok")
//            } else {
//                presentGFAlert(title: "Clear Favorites List", message: "Favorites list will be cleared, are you sure?", buttonTitle: "Yes"){
//                    self.favorites.removeAll()
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                        self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen 😘", in: self.view)
//                    }
//                }
//            }
//        }
//    }
    
    @objc func clearFavoritesTapped() {
        PersistenceManager.clearAllFavorites { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.presentGFAlert(title: "Unable to clear favorites", message: error.rawValue, buttonTitle: "Ok")
            } else {
                self.presentGFAlert(
                    title: "Clear Favorites List",
                    message: "Favorites list will be cleared, are you sure?",
                    buttonTitle: "Cancel",
                    yesButtonAction: {
                        self.favorites.removeAll()
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen 😘", in: self.view)
                        }
                    }
                )
            }
        }
    }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell        = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite    = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC(username: favorite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove){ [weak self] error in
            guard let self else { return }
            guard let error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                if self.favorites.isEmpty{
                    self.showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen 😘", in: self.view)
                }
                return
            }
            DispatchQueue.main.async {
                self.presentGFAlert(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

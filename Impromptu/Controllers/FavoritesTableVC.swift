//
//  FavoritesTableVC.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/14/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit

class FavoritesTableVC: UITableViewController {
    
    var favoritesIndex = PersistenceManager.getFavorites()
    var currentColor: UIColor!
    
    init(color: UIColor) {
        super.init(nibName: nil, bundle: nil)
        currentColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = currentColor
        navigationController?.navigationBar.tintColor = .white
        if favoritesIndex.count == 0 {
            self.showEmptyStates(message: "You don't have favorite questions yet :)", inView: self.view)
        } else {
            self.view.bringSubviewToFront(self.tableView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)

    }

    @objc func dismissVC() {
        dismiss(animated: true, completion: {
            print("}}}}}")        })
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoritesIndex.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        let questionIndex = favoritesIndex[indexPath.row]
        let text = Question.questions[questionIndex]
        cell.set(text: text, color: currentColor, questionIndex: questionIndex)
        cell.delegate = self
        return cell
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension FavoritesTableVC: HomeVCDelegate, FavoriteCellDelegate {
    func deleteFavorite(questionIndex: Int) {
        PersistenceManager.update(favoriteIndex: questionIndex, type: .remove) { _ in
            self.favoritesIndex = PersistenceManager.getFavorites()
            if self.favoritesIndex.count == 0 {
                self.showEmptyStates(message: "You don't have favorite questions yet :)", inView: self.view)
            } else {
                self.tableView.reloadData()
            }
            
            
        }
    }
    
    func colorGetter(color: UIColor) {
        currentColor = color
    }
    
    func showEmptyStates(message: String, inView view: UIView) {
        let emptyStateView = EmptyState(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}



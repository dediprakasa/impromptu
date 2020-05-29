//
//  FavoritesTableVC.swift
//  Impromptu
//
//  Created by Dedi Prakasa on 5/14/20.
//  Copyright © 2020 Dedi Prakasa. All rights reserved.
//

import UIKit


class FavoritesTableVC: UITableViewController {
    
    let favoritesIndex = PersistenceManager.getFavorites()
    var currentColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.separatorStyle = .none
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc func dismissVC() {
        dismiss(animated: true)
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
        let text = Question.questions[favoritesIndex[indexPath.row]]
        cell.set(text: text, color: currentColor ?? UIColor.myRed)
        
        return cell
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension FavoritesTableVC: HomeVCDelegate {
    func colorGetter(color: UIColor) {
        print("++++")
        currentColor = color
    }
    
}



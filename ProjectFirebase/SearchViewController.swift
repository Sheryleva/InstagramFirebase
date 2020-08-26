//
//  SearchViewController.swift
//  ProjectFirebase
//
//  Created by Sheryl Evangelene Pulikandala on 8/10/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var usernames = [Users]()
    
    @IBOutlet weak var tblView: UITableView!
    
    var isSearch : Bool = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var arrFilter: [Users] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
         loadData()
        
        
        searchBar.delegate = self
        

    }
    
    func loadData() -> [Users]  {
        FirebaseManager.shared.getUsernames() { (snapshot) in
            print(snapshot.value)
            if let dict = snapshot.value as? [String: Any] {
                let username = dict["Username"] as! String
                print(username)
                let users = Users(user: username)
                self.usernames.append(users)
                print(self.usernames)
                self.tblView.reloadData()
            }
        }
        print(usernames)
        return self.usernames
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearch == false) {
       
        print(usernames.count)
        return usernames.count
    }
        return arrFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let username = usernames[indexPath.row].Username
        DispatchQueue.main.async {
             cell?.textLabel?.text = username
        }
        configureCell(cell: cell!, indexPath: indexPath)
        return cell ?? UITableViewCell()
        
    }
    
    func configureCell(cell: UITableViewCell, indexPath: IndexPath) {
        if(isSearch){
            cell.textLabel?.text = "\(arrFilter[indexPath.row])"
        } else {
            cell.textLabel?.text = "\(usernames[indexPath.row])"
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    isSearch = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    isSearch = false;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    isSearch = false;
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    isSearch = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    if searchText.count == 0 {
    isSearch = false;
    self.tblView.reloadData()
    } else {
        arrFilter = usernames.filter({ (text) -> Bool in
    let tmp: NSString = "text"
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
    return range.location != NSNotFound
    })
    if(arrFilter.count == 0){
    isSearch = false;
    } else {
    isSearch = true;
    }
    self.tblView.reloadData()
    }
    }
    
 

}
//
//  HeroView.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import UIKit

class HeroView: MainView, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var searchBar:UISearchBar = UISearchBar()
    
    let heroVM = HeroViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    private func initialize() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: "\(CellView.self)", bundle: nil), forCellReuseIdentifier: "cell")

        self.modifiyView()
    }
    
    private func modifiyView() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Buscar..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.heroVM.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellView
        let entity = self.heroVM.list[indexPath.row]
        
        cell.lblAlias.text = entity.name
        cell.lblName.text = entity.biography?.full_name
        cell.lblStrength.text = "Strength: \(entity.strength)"
        
        ImageLoader.image(for: URL(string: entity.image)!) { image in
            cell.imgProfile.image = image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity = self.heroVM.list[indexPath.row]
        self.heroEntity = entity
        performSegue(withIdentifier: "DetailView", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        self.heroVM.search(textSearched) { response in
            print(self.heroVM.list.count)
            print(response)
            self.tableView.reloadData()
        } onFailure: { error in
            self.showError(error)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
    }
    
}

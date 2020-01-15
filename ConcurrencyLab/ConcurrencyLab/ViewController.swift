//
//  ViewController.swift
//  ConcurrencyLab
//
//  Created by Tanya Burke on 12/29/19.
//  Copyright © 2019 Tanya Burke. All rights reserved.
//

import UIKit

enum CellID:String {
   
    case countryTableViewID = " countryCell"
}
class ViewController: UIViewController {
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var countryTableView: UITableView!
    
    var countries = [CountryList](){
        didSet{
            DispatchQueue.main.async {
                self.countryTableView.reloadData()
            }
        }
    }
    
    var countrySearchText: String? = nil{
        didSet{
            DispatchQueue.main.async {
                self.countryTableView.reloadData()
            }
        }
    }
       
    var searchResults:[CountryList]{
        guard let searchQuerry = countrySearchText else{
            return countries
        }
        guard !searchQuerry.isEmpty else {
            return countries
        }
        
        return countries.filter({$0.name.lowercased().replacingOccurrences(of: " ", with: "").contains(searchQuerry.lowercased().replacingOccurrences(of: " ", with: ""))})
    }
        
        
        override func viewDidLoad() {
        super.viewDidLoad()
            countryTableView.delegate = self
            countrySearchBar.delegate = self
            countryTableView.dataSource = self
        loadData()
            
        }
    
    
        
    func loadData(){
        CountryListAPI.getListOfCountries {[weak self] (result) in
           // DispatchQueue.main.async {
            switch result{
            case .failure (let appError):
                print(appError.localizedDescription) //gives error in string form
                
            case .success(let data):
                self?.countries = data
        //    }
        }
        
    }
        
    }
        
        
    }
    
    extension ViewController: UITableViewDataSource, UITableViewDelegate{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResults.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = countryTableView.dequeueReusableCell(withIdentifier: CellID.countryTableViewID.rawValue) as? CountryCell else{
            return UITableViewCell()
           }
            
            
            cell.configureCell(withFlagUrlString: searchResults[indexPath.row].alpha2Code, for: searchResults[indexPath.row])
          
           
            return cell
        }
        
        
        
        
    }
    
    extension ViewController: UISearchBarDelegate{
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         
       countrySearchText = searchText
            
        }
}

//
//  CountrCell.swift
//  ConcurrencyLab
//
//  Created by Tanya Burke on 1/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

//import UIKit
//
//class CountryCell: UITableViewCell {
//
//    @IBOutlet weak var countryImage: UIImageView!
//    @IBOutlet weak var countryNameAndCap:UILabel!
//    @IBOutlet weak var countryPop:UILabel!
//    
//    func configureCell(withFlagUrlString: String, for country: CountryList){
//        countryImage.setImage(with: withFlagUrlString) { (result) in
//            switch result{
//            case .failure:
//                DispatchQueue.main.async {
//                    self.countryImage.image = UIImage(systemName: "person.fill")
//                }
//            case .success(let image):
//                DispatchQueue.main.async {
//                    self.countryImage.image = image
//                }
//            }
//        }
//        
//        countryNameAndCap.text = "Name: \(country.name) \nCapital: \(country.capital), Location: \(country.subregion), \(country.region)"
//        countryPop.text = "Population: \(country.population)"
//        
//    }
//    
//}

//
//  UIImage+Extension.swift
//  ConcurrencyLab
//
//  Created by Tanya Burke on 1/6/20.
//  Copyright © 2020 Tanya Burke. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(with urlString: String, completionHandler: @escaping (Result<UIImage, AppError>)->()){
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.center = center
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL(urlString)))
            return}
        NetworkHelper.shared.performDataTask(with: url) { (result) in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
            }
            switch result{
            case .failure(let appError):
                completionHandler(.failure(.networkClientError(appError)))
            case .success(let data):
                if let image = UIImage(data: data){
                    completionHandler(.success(image))
                }
            }
        }
        
    }

}

//
//  PrynyakTableViewCell.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var imageTitleLabel: UILabel!
    
    var imageURL: String!
    
    override func prepareForReuse() {
        cellImageView.image = nil
        imageTitleLabel.text = ""
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from stringUrl: String) {
        guard let url = URL(string: stringUrl)  else {
            return
        }
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.cellImageView.image = UIImage(data: data)
            }
        }
    }
    
}

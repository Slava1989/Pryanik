//
//  SelectorTableViewCell.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

protocol TapVariantDelegate {
    func didTap(on label: UILabel, of index: Int, from labels: [UILabel])
}

class SelectorTableViewCell: UITableViewCell {

    @IBOutlet var variantLabels: [UILabel]!
    
    var delegate: TapVariantDelegate?
    
    override func prepareForReuse() {
        for label in variantLabels {
            label.text = ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        for (index, label) in variantLabels.enumerated() {
            let gestureRecognizer = CustomTapGesture(target: self, action: #selector(didTapOnLabel(_:)))
            label.addGestureRecognizer(gestureRecognizer)
            gestureRecognizer.indexOfLabel = index
            gestureRecognizer.label        = label
            gestureRecognizer.labels       = variantLabels
            label.isUserInteractionEnabled = true
        }
    }
    
    @objc func didTapOnLabel(_ sender: CustomTapGesture) {
        delegate?.didTap(on: sender.label, of: sender.indexOfLabel, from: sender.labels)
    }
}

class CustomTapGesture: UITapGestureRecognizer {
    var indexOfLabel: Int!
    var label: UILabel!
    var labels: [UILabel]!
}

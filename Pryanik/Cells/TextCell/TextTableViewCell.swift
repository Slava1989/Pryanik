//
//  TextTableViewCell.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func prepareForReuse() {
        label.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//
//  SecondViewController.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/15/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!

    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultLabel.text = name!
        
    }

}

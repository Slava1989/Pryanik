//
//  ViewController.swift
//  Pryanilk
//
//  Created by Veaceslav Chirita on 7/14/20.
//  Copyright © 2020 Veaceslav Chirita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var imageTitle = [String: String]()
    private var responseView: [String]?
    private var responseData: [ResponseData]?
    private var selectedName: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: IMAGE_CELL, bundle: nil),
                           forCellReuseIdentifier: IMAGE_CELL)
        tableView.register(UINib(nibName: TEXT_CELL, bundle: nil),
                           forCellReuseIdentifier: TEXT_CELL)
        tableView.register(UINib(nibName: SELECTOR_CELL, bundle: nil),
                           forCellReuseIdentifier: SELECTOR_CELL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let presenter = Presenter()
        presenter.getAPIResponse { [weak self] response in
            if let response = response {
                self?.responseView = response.view
                self?.responseData = response.data
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == RESULT_VC {
            let vc = segue.destination as! SecondViewController
            vc.name = selectedName
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(responseView![indexPath.row])
        
        selectedName = responseView![indexPath.row]
        
        performSegue(withIdentifier: RESULT_VC, sender: self)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseView?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewString = responseView![indexPath.row]
        
        let cellType = responseData?.first(where: { (response) -> Bool in
            return response.name == viewString
        })
        
        switch viewString {
        case ViewResponseEnum.hz.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: TEXT_CELL, for: indexPath)
            as! TextTableViewCell
            
            cell.label.text = cellType!.data.text
            
            return cell
        case ViewResponseEnum.picture.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: IMAGE_CELL, for: indexPath)
                as! ImageTableViewCell
            
            cell.downloadImage(from: cellType!.data.url ?? "")
            cell.imageTitleLabel.text = cellType!.data.text ?? ""
            
            return cell
        case ViewResponseEnum.selector.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: SELECTOR_CELL, for: indexPath)
                        as! SelectorTableViewCell
            cell.delegate = self
            for (index, label) in cell.variantLabels.enumerated() {
                label.text = cellType!.data.variants![index].text
                if cellType!.data.variants![index].id == cellType!.data.selectedId {
                    label.backgroundColor = .red
                }
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ViewController: TapVariantDelegate {
    func didTap(on label: UILabel, of index: Int, from labels: [UILabel]) {
        for label in labels {
            label.backgroundColor = .white
        }
        label.backgroundColor = .red
        
        selectedName = "\(index)"
        performSegue(withIdentifier: RESULT_VC, sender: self)
    }
    
    
}


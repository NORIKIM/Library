//
//  MainVC.swift
//  Library
//
//  Created by 김지나 on 2023/09/03.
//

import UIKit

class MainVC: UIViewController, Storyboarded {
    @IBOutlet weak var bookTB: UITableView!
    
    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

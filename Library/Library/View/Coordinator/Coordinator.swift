//
//  Coordinator.swift
//  Library
//
//  Created by 김지나 on 2023/09/03.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navi: UINavigationController { get set }
    
    func start()
}

class AppCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var navi: UINavigationController
    
    init(navi: UINavigationController) {
        self.navi = navi
    }
    
    func start() {
        let mainVC = MainVC.instantiate()
        mainVC.coordinator = self
        navi.setViewControllers([mainVC], animated: true)
    }
    
    func moveToDetailVC() {
        let detailVC = DetailVC.instantiate()
        detailVC.coordinator = self
        navi.pushViewController(detailVC, animated: true)
    }
}

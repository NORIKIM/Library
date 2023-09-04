//
//  MainVC.swift
//  Library
//
//  Created by 김지나 on 2023/09/03.
//

import UIKit

class MainVC: UIViewController, Storyboarded, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, MainVMDelegate {

    @IBOutlet weak var bookTB: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    weak var coordinator: AppCoordinator?
    private let mainVM = MainVM()
    private let cellID = "MainCell"
    
    private var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setTable()
    }
    
    func setUI() {
        indicator.stopAnimating()
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0))
        searchBar.placeholder = " 제목, 저자 검색"
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        mainVM.delegate = self
    }
    
    func setTable() {
        bookTB.delegate = self
        bookTB.dataSource = self
        bookTB.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
    }
    
    // MainVM delegate method
    // 검색 결과 search 후 호출
    func finishLoad() {
        DispatchQueue.main.async {
            self.bookTB.reloadData()
            self.indicator.stopAnimating()
        }
    }
}

// MARK: - searchBar
extension MainVC {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            indicator.startAnimating()
            searchBar.resignFirstResponder()
            mainVM.load(with: searchText)
        }
    }
}

// MARK: - table
extension MainVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVM.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? MainCell else { return UITableViewCell() }
        let book = mainVM.book(at: indexPath)
        cell.book = book
        
        return cell
    }
}

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
        searchBar.returnKeyType = .default
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
        
        mainVM.delegate = self
    }
    
    func setTable() {
        bookTB.delegate = self
        bookTB.dataSource = self
        bookTB.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        bookTB.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
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
            mainVM.load(with: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - scroll
extension MainVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY >= (contentHeight - height) {
            mainVM.loadNextPage()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = mainVM.book(at: indexPath)
        view.endEditing(true)
        coordinator?.moveToDetailVC(book: book)
    }
}

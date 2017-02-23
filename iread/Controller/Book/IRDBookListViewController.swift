//
//  IRDBookListViewController.swift
//  iread
//
//  Created by honglianglu on 04/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let bookListCellID = "bookListCell"

class IRDBookListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel = IRDBookListViewModel.init()
    var tableView = UITableView.init()
    
    var dataSouce = [IRDBook]()
    
    //MARK: lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchBookList()
    }
    
    func bindData() {
        _ = self.viewModel.bookList.asObservable().filter({ (x) -> Bool in
            return !x.isEmpty
        }).subscribe({ (n) in
            if let booklist = (n.element as? [IRDBook]) {
                self.dataSouce = booklist
            }
            self.tableView.reloadData()
        })
    }
    
    func setupUI() {
        self.title = "bookList"
        
        let item = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addBook))
        self.navigationItem.setRightBarButton(item, animated: true)
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: bookListCellID)
        
        tableView.dataSource = self
        tableView.delegate = self;
        
        self.view.addSubview(tableView)
    }
    
    //MARK: private
    
    func addBook() {
        let addBookViewController = IRDAddBookViewController.init()
        self.navigationController?.pushViewController(addBookViewController, animated: true)
    }
    
    //MARK: tableView DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSouce.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bookListCellID, for: indexPath as IndexPath)
        let book = (self.dataSouce[indexPath.row])
        cell.textLabel?.text = "\(book.name)"
        return cell
    }
    
    //MARK: tableView Delegate
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataSouce.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookDetailViewController = IRDBookDeitalViewController.init()
        bookDetailViewController.viewModel.book = self.dataSouce[indexPath.row]
        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
}

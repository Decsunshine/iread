//
//  IRDBookDetailViewController.swift
//  iread
//
//  Created by honglianglu on 05/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import UIKit

let BookDetialCellID = "bookDetailCellID"

class IRDBookDeitalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel = IRDBookDetailViewModel.init()
    var tableView = UITableView.init()

    lazy var book: IRDBook = {
        return self.viewModel.book
    }()!
    
    var dataSouce = [IRDProgress]()
    
    // MARK: life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchProgressList()
    }
    
    // MARK: table view datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSouce.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookDetialCellID, for: indexPath as IndexPath)
        let progress = (self.dataSouce[indexPath.row])
        cell.textLabel?.text = "\(progress.time)" + "  " + "\(progress.startPage)" + "  =>  " + "\(progress.endPage)"
        return cell
    }

    // MARK: table view delegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let progress = self.dataSouce[indexPath.row];
        let alert = UIAlertController(title: "", message: "确认删除？", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "删除", style: UIAlertActionStyle.default, handler: { action in
            self.viewModel.deleteProgress(progressID: progress.ID);
        }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: private
    
    func addReadingProgress() -> Void {
        let addReadingProgressViewController = IRDAddBookProgressViewController.init()
        addReadingProgressViewController.viewModel.book = self.book
        self.navigationController?.pushViewController(addReadingProgressViewController, animated: true)
    }
    
    func bindData() {
        _ = self.viewModel.progressList.asObservable().subscribe({ (n) in
            self.dataSouce = (n.element as? [IRDProgress])!
            self.tableView.reloadData()
        })
        _ = self.viewModel.deleteSuccess.asObservable().subscribe({ (n) in
            if n.element! {
                self.viewModel.fetchProgressList()
            }
        })
    }
    
    func setupUI() {
        self.title = (self.book.name)
        
        let item = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(addReadingProgress))
        self.navigationItem.setRightBarButton(item, animated: true)
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: BookDetialCellID)
        tableView.dataSource = self
        tableView.delegate = self;
        self.view.addSubview(tableView)
    }
}

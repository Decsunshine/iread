//
//  IRDTaskListViewController.swift
//  iread
//
//  Created by honglianglu on 04/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import UIKit
import Foundation

let taskListCellID = "taskListCell"

class IRDTaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var viewModel = IRDTaskListViewModel.init()
    var tableView = UITableView.init()
    var dataSouce = [IRDTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchTaskList()
    }
    
    // MARK: table datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSouce.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: taskListCellID, for: indexPath as IndexPath)
        let task = (self.dataSouce[indexPath.row])
        cell.textLabel?.text = "\(task.desc)"
        return cell
    }
    //MARK: tableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = self.dataSouce[indexPath.row]
        let alert = UIAlertController(title: "每日复习", message: "确定完成复习任务", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "已完成", style: UIAlertActionStyle.default, handler: { action in
            self.viewModel.finishTask(taskID: task.ID)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: private
    
    func setupUI() -> Void {
        self.title = "taskList"
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: taskListCellID)
        tableView.dataSource = self
        tableView.delegate = self;
        self.view.addSubview(tableView)
    }
    
    func bindData() -> Void {
        _ = self.viewModel.finishTask.asObservable().subscribe({ (n) in
            if n.element! {
                self.viewModel.fetchTaskList()
            }
        })
        _ = self.viewModel.taskList.asObservable().filter({ (x) -> Bool in
            return !x.isEmpty
        }).subscribe({ (n) in
            if let taskList = n.element as? [IRDTask] {
                self.dataSouce = taskList
            }
            self.tableView.reloadData()
        })
    }
}

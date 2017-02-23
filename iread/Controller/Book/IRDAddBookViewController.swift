//
//  IRDAddBookViewController.swift
//  iread
//
//  Created by honglianglu on 16/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class IRDAddBookViewController: UIViewController {
    var textField: UITextField!
    let viewModel = IRDAddBookViewModel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.setupUI()
        self.bindData()
    }
    
    func setupUI() -> Void {
        self.title = "addBook"
        
        let label = UILabel.init(frame: CGRect(x: 20, y: 80, width: 80, height: 20))
        label.text = "书籍名称:"
        self.view.addSubview(label)
        
        self.textField = UITextField.init(frame: CGRect(x: 105, y: 78, width: 200, height: 25))
        self.textField.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.textField)
        
        let button = UIButton.init(type: UIButtonType.system)
        button.frame = CGRect(x: (SCRREN_MIDDLE - (80 / 2)), y: 120, width: 80, height: 20)
        button.setTitle("提交", for: UIControlState.normal)
        button.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
    func click() -> Void {
        self.viewModel.addBook(bookName: self.textField.text!)
    }
    
    func bindData() -> Void {
        
    }
}

//
//  IRDAddBookProgressViewController.swift
//  iread
//
//  Created by honglianglu on 18/02/2017.
//  Copyright © 2017 cc. All rights reserved.
//

import UIKit

class IRDAddBookProgressViewController: UIViewController {
    let viewModel = IRDAddBookProgressViewModel.init()
    var startTextField: UITextField?
    var endTextField: UITextField?
    
    override func viewDidLoad() {
        self.setupUI()
        self.bindData()
    }
    
    //MARK: private
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        self.title = self.viewModel.book?.name
        
        let startPage = UILabel.init(frame: CGRect(x: 20, y: 80, width: 80, height: 20))
        startPage.text = "起始页数:"
        self.view.addSubview(startPage)
        
        self.startTextField = UITextField.init(frame: CGRect(x: 105, y: 78, width: 200, height: 25))
        self.startTextField?.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.startTextField!);
        
        let endPage = UILabel.init(frame: CGRect(x: 20, y: 130, width: 80, height: 20))
        endPage.text = "终止页数:"
        self.view.addSubview(endPage)
        
        self.endTextField = UITextField.init(frame: CGRect(x: 105, y: 128, width: 200, height: 25))
        self.endTextField?.backgroundColor = UIColor.lightGray
        self.view.addSubview(self.endTextField!);
        
        let button = UIButton.init(type: UIButtonType.system)
        button.frame = CGRect(x: (SCRREN_MIDDLE - (80 / 2)), y: 180, width: 80, height: 20)
        button.setTitle("提交", for: UIControlState.normal)
        button.addTarget(self, action: #selector(click), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
    }
    
    func click() -> Void {
        if let startText = self.startTextField?.text {
            if let endText = self.endTextField?.text {
                self.viewModel.addBookProgress(startPage: startText, endPage: endText)
            }
        }
    }
    
    func bindData() -> Void {
        _ = self.viewModel.addBookProgressSuccess.asObservable().subscribe({ (n) in
            if n.element! {
                _ = self.navigationController?.popViewController(animated: true)
            }
        })
    }
}

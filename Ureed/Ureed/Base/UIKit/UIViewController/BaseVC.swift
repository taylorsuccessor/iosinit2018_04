//
//  BaseVC.swift
//  Ureed
//
//  Created by Amjad Tubasi on 12/5/17.
//  Copyright © 2017 Amjad Tubasi. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        prepareLeftBarItem()
        self.edgesForExtendedLayout = []
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationBarStyle().setTheme(for: self.navigationController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "SEARCH_LABEL".localized
        searchBar.searchBarStyle = .prominent
        searchBar.backgroundImage = UIImage()
        searchBar.textField?.tintColor = UIColor.black
        return searchBar
    }()
    
    func endEditing(){
        self.view.endEditing(true)
    }
    
    
    private func closeVC(completion:(()->())? = nil){
        self.dismissVC(completion: completion)
    }
    
    private func popCurrentVC(completion:(()->())? = nil) {
        self.popVC()
        completion?()
    }
    
     func closeController(_ completion:(()->())? = nil){
        self.endEditing()
        if isModal {
            self.closeVC(completion: completion)
        }else {
            self.popCurrentVC(completion: completion)
        }
    }
    
    @objc func closeCurrentController(){
        closeController(nil)
    }
    
    func show(viewController:UIViewController){
        if isModal {
           self.presentVC(viewController)
        }else {
            self.pushVC(viewController)
        }
    }
    
    func prepareLeftBarItem(){
        let image = self.isModal ? #imageLiteral(resourceName: "close_icon") : #imageLiteral(resourceName: "back_icon")
        let backItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.closeCurrentController))
        self.navigationItem.leftBarButtonItems = [backItem]
    }
    
    func addRightBarItem(barButtonSystemItem:UIBarButtonSystemItem = .save,title:String? = nil){
        if let barbuttonTitle = title {
            self.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: barbuttonTitle, style: .plain, target: self, action: #selector(self.rigthBarButtonAction))
        }else {
            self.navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem:barButtonSystemItem, target: self, action: #selector(self.rigthBarButtonAction))
        }
    }
    
    @objc func rigthBarButtonAction(){
        
    }
    
//    func startListening(to name:Notification.Name,selector:Selector){
//        NotificationsCenterHelper.startListening(to: name, at: self, selector: selector)
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func navigationBarStyle()->NavigationBarStyle{
        return .default
    }
}

//
//  BottomSheetController.swift
//  Ureed
//
//  Created by Amjad Tubasi on 1/7/18.
//  Copyright © 2018 Amjad Tubasi. All rights reserved.
//

import Foundation
import UIKit

class BottomSheet : UIViewController {
    
    var closeCompleteion:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.insertSubview(backdropView, at: 0)
        view.shadow = true
        view.addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        setupConsrints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
    }
    
    func setupConsrints(){
        sheetView.heightAnchor.constraint(equalToConstant: sheetViewHeight).isActive = true
        sheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        sheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        UIApplication.shared.isStatusBarHidden = true
//    }
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        UIApplication.shared.isStatusBarHidden = false
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        closeCompleteion?()
//    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var isPresenting = false
    lazy var backdropView: UIView = {
        
        let visualEffectView = UIView(frame: self.view.bounds)
//        visualEffectView.colorTint = UIColor.lightBlack
//        visualEffectView.blurRadius = 5
//        visualEffectView.colorTintAlpha = 0.2
//        visualEffectView.scale = 1
        visualEffectView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        return visualEffectView
        
    }()
    
    var sheetView = UIView()
    var sheetViewHeight : CGFloat = 0
    
    init(sheetView:UIView) {
        super.init(nibName: nil, bundle: nil)
        self.sheetView = sheetView
        self.sheetViewHeight = sheetView.frame.height
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
extension BottomSheet: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            
            sheetView.frame.origin.y += sheetViewHeight
            backdropView.alpha = 0
            
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.sheetView.frame.origin.y -= self.sheetViewHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut], animations: {
                self.sheetView.frame.origin.y += self.sheetViewHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}

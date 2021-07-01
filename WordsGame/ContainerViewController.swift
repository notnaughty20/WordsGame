//
//  ContainerViewController.swift
//  WordsGame
//
//  Created by Влад Мади on 14.05.2021.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var startVC: UIViewController!
    var menuVC: UIViewController!
    
    var isMove: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemOrange
        configStartVC()
        
    }

    func configStartVC() {
        
        let start = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! StartViewController
        start.delegate = self
        startVC = start
        self.addChild(startVC)
        view.addSubview(startVC.view)
        
    }
    
    func configMenuVC() {
        
        if menuVC == nil {
            let menu = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "menuVC")
            menuVC = menu
            view.insertSubview(menuVC.view, at: 0)
            addChild(menuVC)
            
            
        }
        
    }
    
    func showMenu(isMove: Bool) {
        
        if !isMove {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut) {
                self.startVC.view.frame.origin.x = 300
            } completion: { result in
                print(result)
            }
        } else {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.9,
                           initialSpringVelocity: 0,
                           options: .curveLinear) {
                self.startVC.view.frame.origin.x = 0
            } completion: { result in
                print(!result)
            }
        }
    }
}

extension ContainerViewController: StartViewControllerDelegate {
    
    func toggleMenu() {
        
        configMenuVC()
        showMenu(isMove: isMove)
        isMove = !isMove
    }
    
    
}

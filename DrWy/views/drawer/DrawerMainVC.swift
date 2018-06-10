//
//  DrawerMainVC.swift
//  DrWy
//
//  Created by wangyu on 2018/6/10.
//  Copyright © 2018 wangyu. All rights reserved.
//

import UIKit

class DrawerMainVC: UIViewController {
    
    var mainVC: UIViewController?
    var leftVC:UIViewController?
    
    let maxWith = DrawerMaxWidth
    
    //Mark -单例
    static let drawerVC = UIApplication.shared.keyWindow?.rootViewController as? DrawerMainVC
    
    init(leftVC:UIViewController,mainVC:UIViewController){
        super.init(nibName: nil, bundle: nil)
        
        self.leftVC = leftVC
        self.mainVC = mainVC
        
        self.view.addSubview(leftVC.view)
        self.view.addSubview(mainVC.view)
        
        addChildViewController(leftVC)
        addChildViewController(mainVC)
        
        for childVc in mainVC.childViewControllers{
            addEdgeGesture(view: childVc.view)
        }
        
    }
    
    //Mark -添加边缘事件
    func addEdgeGesture(view: UIView?){
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(openWithGuesture(_:)))
        pan.edges = .left
        view?.addGestureRecognizer(pan)
    }
    
    //Mark -打开sideBar事件
    @objc func openWithGuesture(_ pan: UIPanGestureRecognizer) {
        let offsetX = pan.translation(in: pan.view).x
        
        if offsetX < 0 {
            return
        }
        
        if pan.state == .changed && offsetX <= maxWith{
            self.leftVC?.view.transform = CGAffineTransform(translationX: (offsetX-maxWith)/2, y: 0)
            self.mainVC?.view.transform = CGAffineTransform(translationX: offsetX, y: 0)
        }else if pan.state == .cancelled || pan.state == .ended || pan.state == .failed{
            if offsetX >= maxWith/2 {
                openSideBar()
            }else{
               closeSideBar()
            }
        }
    }
    
    //Mark -关闭sideBar事件
    @objc func closeWithGuesture(_ pan: UIPanGestureRecognizer) {
        let offsetX = pan.translation(in: pan.view).x

        if offsetX > 0 {
            return
        }
        
        if pan.state == .changed && -offsetX <= maxWith{
            self.leftVC?.view.transform = CGAffineTransform(translationX: offsetX/2, y: 0)
            self.mainVC?.view.transform = CGAffineTransform(translationX: self.maxWith+offsetX, y: 0)
        }else if pan.state == .cancelled || pan.state == .ended || pan.state == .failed{
            if -offsetX >= maxWith/2 {
                closeSideBar()
            }else{
                openSideBar()
            }
        }
    }
    

    //Mark -打开测滑栏
    func openSideBar() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.leftVC?.view.transform = CGAffineTransform.identity
            self.mainVC?.view.transform = CGAffineTransform(translationX:self.maxWith, y: 0)
        }, completion: {
            (finish:Bool) in
            self.mainVC?.view.addSubview(self.coverBtn)
        })
    }
    
    
    //Mark -关闭测滑栏
    @objc func closeSideBar() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.leftVC?.view.transform = CGAffineTransform(translationX: -self.maxWith/2, y: 0)
            self.mainVC?.view.transform = CGAffineTransform.identity
        }, completion: {
            (finish:Bool) in
            self.coverBtn.removeFromSuperview()
        })
    }
    
    private lazy var coverBtn: UIButton = {
        let coverBtn = UIButton(frame: screenBounds)
        coverBtn.backgroundColor = .black
        coverBtn.alpha = 0.2
        coverBtn.addTarget(self, action: #selector(closeSideBar), for: .touchUpInside)
        coverBtn.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(closeWithGuesture(_:))))
        return coverBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leftVC?.view.transform = CGAffineTransform(translationX: -maxWith/2, y: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

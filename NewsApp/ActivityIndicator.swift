//
//  ActivityIndicator.swift
//  NewsApp
//
//  Created by Azharuddin 1 on 06/09/23.
//

import UIKit
class ActivityIndicatorManager1 {
    static let shared = ActivityIndicatorManager1()
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private init() {
        // Initialize the activity indicator here
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
    }
    
    func showActivityIndicator(on view: UIView) {
        DispatchQueue.main.async {
            self.activityIndicator.center = view.center
            self.activityIndicator.hidesWhenStopped = true
            view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
}


class ActivityIndicatorManager {
      static let shared = ActivityIndicatorManager()
      private var activityIndicator : UIActivityIndicatorView!
      private init() {
          activityIndicator = UIActivityIndicatorView(style: .large)
          activityIndicator.color = .gray
    }
    
    func showActivityIndicator(on view:UIView){
        DispatchQueue.main.async {
            self.activityIndicator.center = view.center
            self.activityIndicator.hidesWhenStopped = true
            view.addSubview(self.activityIndicator)
            self.activityIndicator.startAnimating()
        }
    }
    
    func hideActivityIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
      
}

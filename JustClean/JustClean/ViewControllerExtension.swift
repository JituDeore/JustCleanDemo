//
//  ViewControllerExtension.swift
//  JustClean
//
//  Created by Jitendra Deore on 06/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation
import UIKit

extension ViewController{
    /**
     Shows progress.
     */
    func showProgress() {
        if progressView == nil {
            let progressView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            view.addSubview(progressView)
            
            progressView.translatesAutoresizingMaskIntoConstraints = false;
            view.addConstraint(NSLayoutConstraint(item: progressView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: progressView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0))
            progressView.startAnimating()
            self.progressView = progressView
        }else{
            self.progressView?.startAnimating()
        }
    }
    
    /**
     Hides progress.
     */
    func hideProgress() {
        progressView?.stopAnimating()
        _ = progressView?.hidesWhenStopped
    }
}

extension ViewController : ErrorPresentableViewController{
    var errorView: ErrorView {
        let adapter = ErrorView.inflateView()
        adapter.delegate = self
        self.errView = adapter
        return adapter
    }
    
    var canFullScreenErrorBePresented: Bool {
        return true
    }
    func showErrorScreen(error: NSError){
        handlePageError(error)
    }
}

extension ViewController: ErrorViewDelegate{
    func errorViewDidTapOnButton(_ errorView: ErrorView, and errorWithContent: ErrorContentType) {
        
    }
    
    func removeErrorView() {
        if let errView1 = errView{
            errView1.removeErrorView()
        }
    }
}





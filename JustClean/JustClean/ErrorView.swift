//
//  ErrorView.swift
//  ListDemo
//
//  Created by Jitendra Deore on 21/06/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import UIKit

protocol ErrorViewDelegate : class{
    func errorViewDidTapOnButton(_ errorView: ErrorView , and errorWithContent: ErrorContentType)
}

struct ErrorViewContent {
    var title: String
    let subTitle: String
    let actionTitle: String
    let image: UIImage?
}

@objc enum ErrorContentType: Int {
    case noNetwork = 1
    case noContent = 2
    case serverTimeout = 3
    case defaultError = 4
    
    func errorCotent() -> ErrorViewContent {
        switch self {
        case .noNetwork:
            return ErrorViewContent(title:"Please check your connection", subTitle: "", actionTitle: "Refresh", image: UIImage(named: "errorIcon"))
        case .noContent:
            return ErrorViewContent(title: "No content found", subTitle: "We dont have content at this movement", actionTitle:"Refresh", image: UIImage(named: "errorIcon"))
        case .serverTimeout:
            return ErrorViewContent(title: "Time out error", subTitle: "Please check your connection", actionTitle:"Refresh", image: UIImage(named: "errorIcon"))
        case .defaultError:
            return ErrorViewContent(title: "API Failure", subTitle: "Please check your error", actionTitle:"Refresh", image: UIImage(named: "errorIcon"))
            
        }
    }
}

class ErrorView: UIView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var errorContent: ErrorContentType = .defaultError
    
    var errorMessage: String?
    private var padding: UIEdgeInsets = UIEdgeInsets.zero    
    class func inflateView(with paddingForNav: UIEdgeInsets) -> ErrorView {
        
        let nib = Bundle.main.loadNibNamed("ErrorView", owner: nil, options: nil)!
        let errorView = nib[0] as! ErrorView
        errorView.padding = paddingForNav
        return errorView
    }
    
    class func inflateView() -> ErrorView {
        return inflateView(with: UIEdgeInsets.zero)
    }
    
    weak var delegate: ErrorViewDelegate?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superViewFrame = superview?.bounds{
            frame = UIEdgeInsetsInsetRect(superViewFrame, padding)
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        let errorContentView = errorContent.errorCotent()
        if let errorMessage = errorMessage{
            titleLabel.text = errorMessage
            subtitleLabel.text = ""
        }else{
            titleLabel.text = errorContentView.title
            subtitleLabel.text = errorContentView.subTitle
        }
        titleLabel.textAlignment = .center
        subtitleLabel.textAlignment = .center
        imageView.image = errorContentView.image
        actionButton.setTitle(errorContentView.actionTitle, for: .normal)
    }
    
    func presentInView(parentView: UIView , errorContent: ErrorContentType =  .defaultError)  {
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.activityIndicator.stopAnimating()
            weakSelf.errorContent = errorContent
            parentView.addSubview(weakSelf)
        }
    }
    
    func removeErrorView() {
        removeFromSuperview()
    }
    
    @IBAction func tappedOnHome(_ sender: Any) {
        
        // For no content we should not start the loader we are naviafating user back to headline...
        if errorContent != .noContent{
            activityIndicator.startAnimating()
        }
        delegate?.errorViewDidTapOnButton(self, and: errorContent)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
}

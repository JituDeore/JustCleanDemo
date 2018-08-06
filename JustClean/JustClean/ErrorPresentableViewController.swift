//
//  ErrorPresentableViewController.swift
//  JustClean
//
//  Created by Jitendra Deore on 07/08/18.
//  Copyright © 2018 Jitendra Deore. All rights reserved.
//

import Foundation
import UIKit

/**
 ErrorPresentableViewController needs to be implemented by UIViewControllers
 which wants to display error full page, in a view which encapsulates
 ListViewController.
 */
protocol ErrorPresentableViewController {
    /// ErrorView which will be used to render error.
    var errorView: ErrorView    { get }
    
    var errorContainer: UIView { get }
}

extension ErrorPresentableViewController where Self: UIViewController {
    
    /// Adds a full page error to the caller view
    func handlePageError(_ _error: Error?) {
        guard let error = _error as NSError? else {
            return
        }
        switch error.code {
        case ListErrorCodes.noNetWork:
            showErrorScreenIfRequired(errorContentType: .noNetwork)
        case ListErrorCodes.noContent:
            showErrorScreenIfRequired(errorContentType: .noContent)
        case ListErrorCodes.timeOut:
            showErrorScreenIfRequired(errorContentType: .serverTimeout)
        default:
            showErrorScreenIfRequired(errorContentType: .defaultError)
            break
        }
    }
    
    /// Removes error from view controller.
    func removeErrorScreen() {
        self.errorView.removeErrorView()
    }
    
    /// Handling of refres logic
    ///
    /// - Parameter errorContentType: returns type of error
    private func showErrorScreenIfRequired(errorContentType: ErrorContentType) {
        errorView.presentInView(parentView: errorContainer, errorContent: errorContentType)
    }
    
    var errorContainer: UIView { return view }
}

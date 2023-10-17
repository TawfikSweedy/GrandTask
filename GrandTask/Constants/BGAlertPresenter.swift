//
//  BGAlertPresenter.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/17/23.
//

import Foundation
import AJMessage

class BGAlertPresenter{
    // MARK: - Display alert
    static public func displayToast(title: String , message : String ){
        AJMessage(title: title, message: message , status : .error ).show()
    }
}

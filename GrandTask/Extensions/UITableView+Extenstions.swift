//
//  UITableView+Extenstions.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/16/23.
//

import Foundation
import UIKit

extension UITableView {
    
    func RegisterNib<cell : UITableViewCell>(cell : cell.Type){
        
        
        let nibName = String(describing : cell.self)
        
        self.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
        
        
    }
    
    
    func dequeue<cell : UITableViewCell>() -> cell{
        
        let identifier = String(describing: cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier) as? cell else {
            fatalError("error in cell")
        }
        
        return cell
    }
    
}

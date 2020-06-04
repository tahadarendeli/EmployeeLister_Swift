//
//  TableViewCell.swift
//  BunqSwift
//
//  Created by Taha Darendeli on 31.05.2020.
//  Copyright © 2020 Taha Darendeli. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let cellIdentifier = "cell_identifier"
    
    var employee: Employee?
    var employeeView: EmployeeView?
    
    func setEmployee(employee: Employee?) {
        if let employee = employee {
            self.employee = employee
        }
    }
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.DemoApp.mainColor
        self.employeeView?.removeFromSuperview()
        self.employeeView = EmployeeView(with: employee, frame: CGRect(x: self.contentView.frame.origin.x + 10,
                                                                       y: self.contentView.frame.origin.y + 5,
                                                                       width: self.contentView.frame.size.width - 20,
                                                                       height: self.contentView.frame.size.height - 10))
        self.contentView.addSubview(self.employeeView!)
    }
}

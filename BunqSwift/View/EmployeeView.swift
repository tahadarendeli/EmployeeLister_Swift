//
//  EmployeeView.swift
//  BunqSwift
//
//  Created by Taha Darendeli on 31.05.2020.
//  Copyright © 2020 Taha Darendeli. All rights reserved.
//

import UIKit

class EmployeeView: UIView {
    var labelName: UILabel!
    var labelBirthdate: UILabel!
    var labelSalary: UILabel!
    
    init(with employee: Employee?, frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        
        setLabels()
        setStackViews()
        
        setEmployee(employee: employee)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEmployee(employee: Employee?) {
        guard let employee = employee else {
            return
        }
        
        labelName.text = employee.name
        labelBirthdate.text = employee.birthYear.description
        if employee.responds(to: employee.salarySelector) {
            labelSalary.text = employee.perform(employee.salarySelector)?.takeUnretainedValue() as? String
        }
    }
    
    func setLabels() {
        labelName = UILabel.init(frame: .zero)
        labelBirthdate = UILabel.init(frame: .zero)
        labelSalary = UILabel.init(frame: .zero)
        
        labelName.textAlignment = .center
        labelBirthdate.textAlignment = .center
        labelSalary.textAlignment = .center
        
        labelName.backgroundColor = .clear
        labelBirthdate.backgroundColor = .clear
        labelSalary.backgroundColor = .clear
        
        labelName.textColor = .black
        labelBirthdate.textColor = .lightGray
        labelSalary.textColor = UIColor.DemoApp.greenColor
        
        labelName.font = UIFont.DemoApp.nameFont
        labelBirthdate.font = UIFont.DemoApp.birthDateFont
        labelSalary.font = UIFont.DemoApp.salaryFont
    }
    
    func setStackViews() {
        let mainStackViewFrame = CGRect(x: 10, y: 5, width: self.frame.size.width - 20, height: self.frame.size.height - 10)
        let mainStackView = UIStackView(frame: mainStackViewFrame)
        mainStackView.axis = .horizontal
        mainStackView.distribution = .equalSpacing
        mainStackView.alignment = .fill
        mainStackView.spacing = 10
        
        let innerStackView = UIStackView()
        innerStackView.axis = .vertical
        innerStackView.distribution = .fill
        innerStackView.alignment = .leading
        innerStackView.spacing = 5
        
        innerStackView.addArrangedSubview(labelName)
        innerStackView.addArrangedSubview(labelBirthdate)
        mainStackView.addArrangedSubview(innerStackView)
        mainStackView.addArrangedSubview(labelSalary)
        
        addSubview(mainStackView)
    }
}

//
//  ViewController.swift
//  BunqSwift
//
//  Created by Taha Darendeli on 31.05.2020.
//  Copyright © 2020 Taha Darendeli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var directory: EmployeeDirectory = EmployeeDirectory()
    var tableView: UITableView!
    
    let navigationBarHeight: CGFloat = 50.0
    var navigationBarOriginX: CGFloat!
    var navigationBarOriginY: CGFloat!
    var navigationBarOriginWidth: CGFloat!
    var navigationBarOriginHeigth: CGFloat!
    var statusBarHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        setTableView()
        
        directory.update()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loadData), name: NSNotification.Name.employeeDirectoryDidUpdate, object: nil)
    }
    
    func setTableView() {
        let frame = CGRect(x: self.view.frame.origin.x,
                           y: self.view.frame.origin.y + statusBarHeight + navigationBarHeight,
                           width: self.view.frame.size.width,
                           height: self.view.frame.size.height - statusBarHeight - navigationBarHeight)
        
        tableView = UITableView(frame: frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.DemoApp.mainColor
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        
        self.view.addSubview(tableView)
    }
    
    func setNavigationBar() {
        let manager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        statusBarHeight = manager?.statusBarFrame.size.height
        
        navigationBarOriginX = 0
        navigationBarOriginY = statusBarHeight
        navigationBarOriginWidth = self.view.frame.size.width
        navigationBarOriginHeigth = navigationBarHeight + statusBarHeight
        
        let navigationBar = UINavigationBar(frame: CGRect(origin: CGPoint(x: navigationBarOriginX, y: navigationBarOriginY),
                                                          size: CGSize(width: navigationBarOriginWidth, height: navigationBarOriginHeigth)))
        navigationBar.backgroundColor = UIColor.DemoApp.mainColor
        navigationBar.barTintColor = .white
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.DemoApp.mainColor
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.DemoApp.mainColor]
        
        let navigationItem = UINavigationItem(title: "Employees")
        let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortEmployees))
        
        navigationItem.rightBarButtonItem = sortButton
        navigationBar.setItems([navigationItem], animated: true)
        navigationBar.delegate = self
        view.addSubview(navigationBar)
    }
    
    @objc func loadData() {
        tableView.reloadData()
    }
    
    @objc func sortEmployees() {
        self.directory.sortEmployees() { result in
            self.directory = result
            self.loadData()
        }
    }
}

extension ViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directory.employees?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as! TableViewCell
        let employee = directory.employees?[indexPath.row]
        cell.setEmployee(employee: employee)
        cell.isUserInteractionEnabled = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

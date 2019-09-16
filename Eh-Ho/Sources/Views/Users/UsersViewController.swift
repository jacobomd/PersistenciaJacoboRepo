//
//  UsersViewController.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 26/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var tableUsers: UITableView!
    
    
    let viewModel: UsersViewModel
    var users: [User4] = []
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableUsers.delegate = self
        tableUsers.dataSource = self
        print("la cantidad de usuarios son \(users.count)")
        tableUsers.rowHeight = 60
        self.title = "Usuarios"

        let cell = UINib(nibName: "UsersTableViewCell", bundle: nil)
        tableUsers.register(cell, forCellReuseIdentifier: UITableViewCell.identifier)
        viewModel.viewDidLoad()
    }

}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
            as? UsersTableViewCell else {
                return UITableViewCell()
        }
        
        let userName = users[indexPath.row].username
        let name = users[indexPath.row].name

        
        
        cell.configure(userName: userName, name: name)
        
        return cell
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let userName = users[indexPath.row].username
        viewModel.didTapInTopic(username: userName)
    }
}

// MARK: - ViewModel Communication
protocol UsersViewControllerProtocol: class {
    func showListUsers(users: [User4])
    func showError(with message: String)
}

extension UsersViewController: UsersViewControllerProtocol {
    func showListUsers(users: [User4]) {
        self.users = users
        self.tableUsers.reloadData()
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print(message)
    }
}

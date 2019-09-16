//
//  PostsViewController.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 20/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var tableViewPosts: UITableView!
    
    var posts : [Post2] = []
    
    let viewModel : PostViewModel
    
    var id: Int = 0
    var newTitle: String = ""
    var editable_topic: Bool = false
    
    lazy var refreshControl:UIRefreshControl = {
        let refresControl = UIRefreshControl()
        //QUE AL CAMBIAR EL VALOR, SE EJECUTE UN MÉTODO
        refresControl.addTarget(self, action: #selector(PostsViewController.actualizarDatos(_:)), for: .valueChanged)
        //ESTABLECER EL COLOR DE LA RULETILLA
        refresControl.tintColor = UIColor.blue
        return refresControl
    }()
    
    @objc func actualizarDatos(_ refresControl: UIRefreshControl){
        //AQUI TU TIENES QUE ACTUALIZAR TUS DATOS. TU DATASOURCE. LLAMAR A TU SERVIDOR, VOLVER A TRAER LOS DATOS. ELIMINAR O AÑADIR AL ELEMENTO PERSISTIDO
        viewModel.viewDidLoad()
        //REFRESCO LA VISTA DE TABLA
        self.tableViewPosts.reloadData()
        //PARO EL REFRESH CONTROL
        refresControl.endRefreshing()
        
    }
    
    init(viewModel : PostViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPosts.dataSource = self
        tableViewPosts.delegate = self
        tableViewPosts.rowHeight = 60
        self.title = "Posts"
        
        tableViewPosts.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        viewModel.viewDidLoad()
        
        tableViewPosts.refreshControl = refreshControl

    }
    
    // Mark: - UI
    func setupUI() {
        // Button creation
        let editTopic = UIBarButtonItem(title: "Editar topic", style: .plain, target: self, action: #selector(displayEdit))
        // Add button
        navigationItem.rightBarButtonItems = [editTopic]
    }
    
    // Mark: - Navigation
    @objc func displayEdit() {
       showPustTopicAlert()
    }
    
    private func showPustTopicAlert()  {
        //Create the alert
        let alert = UIAlertController(title: "Editar topic", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (UITextField) in
            UITextField.placeholder = "Enter new title topic"
            UITextField.textAlignment = .center
        }
        
        //Creamos la accion
        let action = UIAlertAction(title: "ok", style: .default) { [unowned alert] _ in
            self.newTitle = alert.textFields![0].text!
            self.viewModel.didUpDateTopic(title: self.newTitle)
        }
        
        //Aañadimos a la alerta
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func ButtonAddPost(_ sender: Any) {
        
        viewModel.didTapInTopic(id: self.id)
    }

}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewPosts.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].cooked
        
        id = posts[indexPath.row].topicID
        editable_topic  = posts[indexPath.row].canEdit
        
        if (editable_topic) {
            setupUI()
        }

        return cell
    }
    
}


extension PostsViewController: UITableViewDelegate {
    
}

// MARK: - ViewModel Communication

protocol PostsViewControllerProtocol: class {
    func showListPostssByTopic(posts: [Post2])
    func showError(with message: String)
}

extension PostsViewController: PostsViewControllerProtocol {

    func showListPostssByTopic(posts: [Post2]) {
        self.posts = posts
        self.tableViewPosts.reloadData()
    }
    
    func showError(with message: String) {
        //AQUI ENSEÑAMOS ALERTA
        print("ERROR")
    }
}

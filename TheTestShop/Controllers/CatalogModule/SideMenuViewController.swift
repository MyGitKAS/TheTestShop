//
//  SideMenuViewController.swift
//  TheTestShop
//
//  Created by Aleksey Kuhlenkov on 20.03.24.
//

import UIKit

final class SideMenuViewController: UITableViewController {
    
    private var categories: Categories?
    
    var didSelectItem: ((String) -> Void)?
    
    init() {
        super.init(style: .plain)
        getCategories()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SideCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideCell", for: indexPath)
        guard let categories = categories else { return cell }
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let categories = categories else { return }
        didSelectItem?(categories[indexPath.row])
    }
}

// MARK: - Private methods
extension SideMenuViewController {
    private func getCategories() {
        ShopApiManager.shared.performRequest(for: .getAllCategories) { [weak self] (result: Result<Categories?, Error>) in
            guard let self = self else { return }
            switch result {
                case .success(let categories):
                    if let categories = categories {
                        self.categories = categories
                        DispatchQueue.main.async{
                            self.tableView.reloadData()
                        }
                    } else {
                        self.showErrorAlert(withMessage: "Categories found.")
                    }
                case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

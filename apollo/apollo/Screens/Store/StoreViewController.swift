//
//  StoreViewController.swift
//  apollo
//
//  Created by Sear Ahmad on 16/03/23.
//

import UIKit

class StoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Mock Data
    private let sectionHeaders: [PrimaryHeaderViewModel] = [.init(title: "Apollo Care & Protect", subtitle: "Protect your new scooter"), .init(title: "Accessories", subtitle: "Buy new great stuff for your scooter"), .init(title: "Upgrades", subtitle: "Hardware & Software Updates")]
    private let section1Data: [StorePrimaryCollectionViewCellViewModel] = [.init(image: "element2", title: "Apollo Care + Theft and Loss", subtitle: "$129 USD or $6.99/mo."), .init(image: "element1", title: "Apollo Care", subtitle: "$129 USD or $6.99/mo.")]
    private let section2Data: [StorePrimaryCollectionViewCellViewModel] = [.init(image: "element3", title: "Apollo Bag", subtitle: "Some interesting description here", price: "$19.99 USD")]

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PrimaryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: PrimaryTableViewHeader.nameOfClass)
        tableView.register(StorePrimaryTableViewCell.self, forCellReuseIdentifier: StorePrimaryTableViewCell.nameOfClass)
        tableView.register(StoreSecondaryTableViewCell.self, forCellReuseIdentifier: StoreSecondaryTableViewCell.nameOfClass )
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
        tableView.allowsSelection = false
        return tableView
    }()
    
    private let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    
    private lazy var profileImageView: UIImageView = {
        let profileImageView = UIImageView(image: UIImage(named: "avatar"))
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.frame = CGRect(x: customView.bounds.width - 76, y: 0, width: 40, height: 40)
        profileImageView.backgroundColor = .gray
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        return profileImageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: -4, y: 0, width: customView.bounds.width - 40, height: 44))
        titleLabel.text = "Store"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        view.addSubview(tableView)
        makeConstraints()
    }
    
    private func setupNavigation() {
        customView.addSubview(profileImageView)
        customView.addSubview(titleLabel)
        navigationItem.titleView = customView
    }
    
    // MARK: - Constraints
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - TableView Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionHeaders.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case .zero: return 1
        case 1: return 1
        default: return 1
        }
    }
    
    // MARK: - TableView Data Source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StorePrimaryTableViewCell.nameOfClass, for: indexPath) as! StorePrimaryTableViewCell
        
        switch indexPath.section {
        case .zero:
            cell.content = section1Data
            cell.cellType = .careAndProtect
            
        case 1:
            cell.content = section2Data
            cell.cellType = .accessories
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: StoreSecondaryTableViewCell.nameOfClass, for: indexPath) as! StoreSecondaryTableViewCell
            return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PrimaryTableViewHeader.nameOfClass) as! PrimaryTableViewHeader
        header.content = sectionHeaders[section]
        return header
    }
}

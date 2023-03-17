//
//  StorePrimaryTableViewCell.swift
//  apollo
//
//  Created by Sear Ahmad on 16/03/23.
//

import UIKit

class StorePrimaryTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Data Layer
    var content: [StorePrimaryCollectionViewCellViewModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var cellType: StorePrimaryCollectionViewCell.CellType?
    
    // MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: StorePrimaryCollectionViewCell.cellViewWidth, height: StorePrimaryCollectionViewCell.cellViewHeight+8)

        collectionView.register(StorePrimaryCollectionViewCell.self,
                                forCellWithReuseIdentifier: StorePrimaryCollectionViewCell.nameOfClass)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(collectionView)
    }
    
    override func updateConstraints() {
        collectionView.snp.updateConstraints { maker in
            maker.edges.equalToSuperview()
            maker.height.equalTo(StorePrimaryCollectionViewCell.cellViewHeight+8)
        }
        super.updateConstraints()
    }
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let content = content else {
            return 0
        }
        return content.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StorePrimaryCollectionViewCell.nameOfClass, for: indexPath) as! StorePrimaryCollectionViewCell
        if let content = content {
            cell.content = content[indexPath.item]
            cell.cellType = cellType ?? .careAndProtect
        }
        return cell
    }
}

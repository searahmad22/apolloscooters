//
//  PrimaryTableViewHeader.swift
//  apollo
//
//  Created by Sear Ahmad on 16/03/23.
//

import UIKit

struct PrimaryHeaderViewModel {
    var title: String
    var subtitle: String
}

class PrimaryTableViewHeader: UITableViewHeaderFooterView {
    
    // MARK: - Data Layer
    var content: PrimaryHeaderViewModel? {
        didSet {
            guard let content = content else {
                return
            }
            titleLable.text = content.title
            subTitleLable.text = content.subtitle
            setNeedsUpdateConstraints()
        }
    }
    
    // MARK: - UI
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = "Apollo Care & Protect"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subTitleLable: UILabel = {
        let label = UILabel()
        label.text = "Protect your new scooter"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentMode = .bottom
        return button
    }()
    
    // MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLable.text = nil
        subTitleLable.text = nil
    }
    
    private func setupUI(){
        contentView.addSubview(titleLable)
        contentView.addSubview(subTitleLable)
        contentView.addSubview(button)
    }
    
    override func updateConstraints() {
        titleLable.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(16)
        }
        
        subTitleLable.snp.updateConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(titleLable.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(16)
        }
        
        button.snp.updateConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(titleLable.snp.height)
            make.centerY.equalTo(titleLable.snp.centerY)
        }
        super.updateConstraints()
    }
}

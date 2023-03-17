//
//  StorePrimaryCollectionViewCell.swift
//  apollo
//
//  Created by Sear Ahmad on 16/03/23.
//

import UIKit

struct StorePrimaryCollectionViewCellViewModel {
    var image: String
    var title: String
    var subtitle: String
    var price: String?
}

class StorePrimaryCollectionViewCell: UICollectionViewCell {
    
    enum CellType {
        case careAndProtect
        case accessories
    }
    
    // MARK: - Static Properties
    static let cellViewWidth = 242.0
    static let cellViewHeight = 329.0
    
    // MARK: - Data Layer
    var content: StorePrimaryCollectionViewCellViewModel? {
        didSet {
            guard let content = content else {
                return
            }
            imageView.image = UIImage(named: content.image)
            titleLable.text = content.title
            subtitleLabel.text = content.subtitle
            
            if let price = content.price {
                priceLabel.text = price
            }
            setNeedsUpdateConstraints()
        }
    }
    
    var cellType: CellType? {
        didSet {
            guard let cellType = cellType, cellType == .accessories else {
                return
            }
            cellView.addSubview(buttonStackView)
            setNeedsUpdateConstraints()
        }
    }
    
    // MARK: - UI
    private lazy var cellView: UIView = {
        let cellView = UIView()
        cellView.layer.cornerRadius = 16
        cellView.clipsToBounds = true
        cellView.layer.cornerCurve = .continuous
        cellView.layer.borderColor = UIColor.darkGray.cgColor
        cellView.layer.borderWidth = 1
        cellView.backgroundColor = .clear
        return cellView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var sepratorView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    private lazy var precentageContainer: UIView = {
        let container = UIView()
        if #available(iOS 13.0, *) {
            container.layer.cornerCurve = .continuous
        }
        container.backgroundColor = .systemYellow
        return container
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .gray
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.addArrangedSubview(titleLable)
        stackView.addArrangedSubview(subtitleLabel)
        return stackView
    }()
    
    private let button = ApolloPrimaryButton(title: "Buy")
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .gray
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(priceLabel)
        return stackView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLable.text = nil
        subtitleLabel.text = nil
        priceLabel.text = nil
    }
    
    private func setupUI() {
        contentView.addSubview(cellView)
        cellView.addSubview(imageView)
        cellView.addSubview(sepratorView)
        cellView.addSubview(precentageContainer)
        cellView.addSubview(labelsStackView)
    }
    
    override func updateConstraints() {
        cellView.snp.updateConstraints { make in
            make.width.equalTo(Self.cellViewWidth)
            make.height.equalTo(Self.cellViewHeight)
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        imageView.snp.updateConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(Self.cellViewHeight * 0.75)
        }
        
        sepratorView.snp.updateConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.height.equalTo(1)
            make.width.equalToSuperview()
        }
        
        if cellType == .careAndProtect {
            labelsStackView.snp.remakeConstraints { make in
                make.top.equalTo(sepratorView.snp.bottom).offset(16)
                make.width.equalTo(100)
                make.bottom.leading.trailing.equalToSuperview().inset(16)
            }
        } else {
            labelsStackView.snp.remakeConstraints { make in
                make.top.equalTo(sepratorView.snp.bottom).offset(16)
                make.width.equalTo(100)
                make.bottom.leading.equalToSuperview().inset(16)
            }
            
            buttonStackView.snp.updateConstraints { make in
                make.leading.greaterThanOrEqualTo(labelsStackView.snp.trailing)
                make.trailing.bottom.equalToSuperview().inset(16)
                make.top.equalTo(sepratorView.snp.bottom).offset(16)
            }
        }
        
        super.updateConstraints()
    }

    override func layoutSubviews() {
        precentageContainer.layer.cornerRadius = precentageContainer.frame.height/2
        super.layoutSubviews()
    }
}

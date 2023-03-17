//
//  StoreSecondaryTableViewCell.swift
//  apollo
//
//  Created by Sear Ahmad on 16/03/23.
//

import UIKit

class StoreSecondaryTableViewCell: UITableViewCell {
    
    // MARK: - UI
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImage(named: "element4")
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.layer.cornerCurve = .continuous
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 1
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var labelsHolderView: UIView = {
        let view = UIView()
        let blurEffect = UIBlurEffect(style: .prominent)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(visualEffectView)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Phantom V3 Kit"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "At magnum periculum adiit in oculis quidem exercitus quid ex eo delectu rerum."
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let button = ApolloPrimaryButton(title: "Buy")
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    // MARK: - Lifecycle
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
        contentView.addSubview(backgroundImageView)
        backgroundImageView.addSubview(labelsHolderView)
        labelsHolderView.addSubview(stackView)
        labelsHolderView.addSubview(button)
    }
    
    override func updateConstraints() {
        backgroundImageView.snp.updateConstraints { make in
            make.height.equalTo(380)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
        
        labelsHolderView.snp.updateConstraints { make in
            make.height.equalTo(380 * 0.25)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        stackView.snp.updateConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(16)
            make.trailing.lessThanOrEqualToSuperview().inset(60)
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.leading.equalTo(stackView.snp.trailing)
            make.centerY.equalTo(stackView.snp.centerY)
        }
        super.updateConstraints()
    }

}

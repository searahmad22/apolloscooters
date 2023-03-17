//
//  BluetoothDeviceTableViewCell.swift
//  apollo
//
//  Created by Sear Ahmad on 15/03/23.
//

import UIKit
import CoreBluetooth

class BluetoothDeviceTableViewCell: UITableViewCell {
    
    // MARK: - Data Layer
    var deviceTitle: String? {
        didSet {
            deviceTitleLabel.text = deviceTitle
            setNeedsUpdateConstraints()
        }
    }
    
    // MARK: - UI
    private lazy var iconImageView: UIImageView = {
        let image = UIImage(named: "bluetooth.icon")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var deviceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Apollo Air - 917215273"
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let accessoryIcon = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryView = accessoryIcon
        accessoryView?.tintColor = .systemBlue
        
        backgroundColor = .black

        contentView.backgroundColor = .clear
        contentView.addSubview(iconImageView)
        contentView.addSubview(deviceTitleLabel)
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // TODO: - prepare for reuse all dynamic labels
        deviceTitleLabel.text = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func updateConstraints() {
        iconImageView.snp.updateConstraints { make in
            make.size.equalTo(32)
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview()
        }
        
        deviceTitleLabel.snp.updateConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.leading.equalTo(iconImageView.snp.trailing).offset(4)
            make.trailing.equalTo(accessoryView!.snp.leading)
        }
        super.updateConstraints()
    }

}

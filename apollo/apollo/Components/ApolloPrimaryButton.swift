//
//  ApolloPrimaryButton.swift
//  apollo
//
//  Created by Sear Ahmad on 17/03/23.
//

import UIKit
import SnapKit

class ApolloPrimaryButton: UIButton {
    
    var onDidTap: (() -> Void)?
    
    init(title: String, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.onDidTap = action
        setTitle(title, for: .normal)
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton() {
        titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        backgroundColor = .orange
        layer.cornerRadius = 15
    }
    
    override func updateConstraints() {
        snp.makeConstraints { make in
            make.width.equalTo(66)
            make.height.equalTo(30)
        }
        super.updateConstraints()
    }
    
    @objc
    private func didTap() {
        self.onDidTap?()
    }
    
}

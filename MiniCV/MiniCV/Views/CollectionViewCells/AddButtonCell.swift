//
//  AddButtonCell.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 04.08.2023.
//

import UIKit

final class AddButtonCell: UICollectionViewCell {

    private lazy var addButtonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        addSubview(addButtonLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            addButtonLabel.topAnchor.constraint(
                equalTo: topAnchor,
                constant: 12
            ),
            addButtonLabel.bottomAnchor.constraint(
                equalTo: bottomAnchor,
                constant: -12
            ),
            addButtonLabel.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            addButtonLabel.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            )
        ])
    }
}

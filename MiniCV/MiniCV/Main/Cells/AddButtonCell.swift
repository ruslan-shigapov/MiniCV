//
//  AddButtonCell.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 04.08.2023.
//

import UIKit

final class AddButtonCell: UICollectionViewCell {

    private lazy var addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    var delegate: AddButtonCellDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
        contentView.addSubview(addButton)
        setConstraints()
        setAddButtonAction()
    }
    
    private func setAddButtonAction() {
        let addButtonPressed = UIAction { [weak self] _ in
            self?.delegate.addButtonWasPressed?()
        }
        addButton.addAction(addButtonPressed, for: .touchUpInside)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: 57),
            contentView.heightAnchor.constraint(equalToConstant: 44),
            
            addButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

//
//  AboutSectionCell.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 06.08.2023.
//

import UIKit

final class AboutSectionCell: UITableViewCell {
    
    private lazy var aboutSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "О себе"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(aboutSectionLabel)
        addSubview(aboutLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            aboutSectionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            aboutSectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            aboutLabel.topAnchor.constraint(equalTo: aboutSectionLabel.bottomAnchor, constant: 8),
            aboutLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            aboutLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            aboutLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}

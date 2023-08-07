//
//  ProfileSectionCell.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 07.08.2023.
//

import UIKit

final class ProfileSectionCell: UITableViewCell {

    // MARK: - Private Properties
    private lazy var locationStackView = UIStackView()
    
    private lazy var locationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Pin")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - Public Properties
    lazy var photoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UITableViewCell Lifecycle 
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        backgroundColor = .secondarySystemBackground
        locationStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photoImageView)
        addSubview(fullNameLabel)
        addSubview(infoLabel)
        addSubview(locationStackView)
        locationStackView.addArrangedSubview(locationImageView)
        locationStackView.addArrangedSubview(locationLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 287),
            
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            photoImageView.widthAnchor.constraint(equalToConstant: 120),
            photoImageView.heightAnchor.constraint(equalToConstant: 120),
            photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            fullNameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            fullNameLabel.widthAnchor.constraint(equalToConstant: 189),
            fullNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            infoLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            locationStackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor),
            locationStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            locationStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
}

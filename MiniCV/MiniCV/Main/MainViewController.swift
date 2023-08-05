//
//  MainViewController.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 04.08.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    private let profile = Profile.getProfile()
    
    private var viewModel: MainViewModelProtocol! {
        didSet {
            viewModel.fetchData {
                skillsCollectionView.reloadData()
            }
            viewModel.deleteButtonWasPressed = { [weak self] in
                self?.viewModel.fetchData {
                    self?.skillsCollectionView.reloadData()
                }
            }
        }
    }
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: profile.photo)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = profile.fullName
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = profile.info
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    private lazy var locationImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Pin")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = profile.location
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var lowerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var skillsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    private lazy var skillsSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мои навыки"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Pencil"), for: .normal)
        return button
    }()
    
    private lazy var skillsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: makeLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private lazy var aboutSectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "О себе"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = profile.about
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    var contentSizeHeight: CGFloat!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        title = profile.title
        view.backgroundColor = .secondarySystemBackground
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        skillsCollectionView.dataSource = self
        skillsCollectionView.delegate = self
        skillsCollectionView.register(
            SkillCell.self,
            forCellWithReuseIdentifier: "skillCell"
        )
        skillsCollectionView.register(
            AddButtonCell.self,
            forCellWithReuseIdentifier: "addButtonCell"
        )
        addSubviews()
        setConstraints()
        setEditButtonAction()
    }
    
    private func setEditButtonAction() {
        let editButtonPressed = UIAction { [unowned self] _ in
            viewModel.isEditingMode.toggle()
            editButton.setImage(
                UIImage(named: viewModel.isEditingMode ? "Done" : "Pencil"),
                for: .normal
            )
            skillsCollectionView.reloadData()
        }
        editButton.addAction(editButtonPressed, for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(topView)
        scrollView.addSubview(lowerView)
        topView.addSubview(imageView)
        topView.addSubview(fullNameLabel)
        topView.addSubview(infoLabel)
        topView.addSubview(locationStackView)
        locationStackView.addArrangedSubview(locationImageView)
        locationStackView.addArrangedSubview(locationLabel)
        lowerView.addSubview(skillsStackView)
        skillsStackView.addArrangedSubview(skillsSectionLabel)
        skillsStackView.addArrangedSubview(editButton)
        lowerView.addSubview(skillsCollectionView)
        lowerView.addSubview(aboutSectionLabel)
        lowerView.addSubview(aboutLabel)
    }
        
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            topView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            topView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            topView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            topView.heightAnchor.constraint(equalToConstant: 287),

            lowerView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            lowerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            lowerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            lowerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            lowerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            imageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),

            fullNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            fullNameLabel.widthAnchor.constraint(equalToConstant: 189),
            fullNameLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            infoLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),

            locationStackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor),
            locationStackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20),
            locationStackView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            locationImageView.widthAnchor.constraint(equalToConstant: 16),
            
            skillsStackView.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 20),
            skillsStackView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 16),
            skillsStackView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -16),
            skillsStackView.heightAnchor.constraint(equalToConstant: 24),
            
            editButton.widthAnchor.constraint(equalToConstant: 24),
            
            skillsCollectionView.topAnchor.constraint(equalTo: skillsStackView.bottomAnchor),
            skillsCollectionView.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 16),
            skillsCollectionView.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -16),
            skillsCollectionView.heightAnchor.constraint(equalToConstant: 100),

            aboutSectionLabel.topAnchor.constraint(equalTo: skillsCollectionView.bottomAnchor, constant: 24),
            aboutSectionLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 16),
            aboutSectionLabel.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -16),
            
            aboutLabel.topAnchor.constraint(equalTo: aboutSectionLabel.bottomAnchor, constant: 8),
            aboutLabel.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -24),
            aboutLabel.leadingAnchor.constraint(equalTo: lowerView.leadingAnchor, constant: 16),
            aboutLabel.trailingAnchor.constraint(equalTo: lowerView.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - Collection View Data Source
extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell?
        if (viewModel.isEditingMode ? indexPath.row + 1 : indexPath.row) < viewModel.numberOfItems() {
            let skillCell = collectionView.dequeueReusableCell(withReuseIdentifier: "skillCell",
                                                               for: indexPath) as? SkillCell
            if viewModel.isEditingMode {
                skillCell?.deleteButton.isHidden = false
                skillCell?.skillNameLabelTrailingConstraint.constant = -48
            } else {
                skillCell?.deleteButton.isHidden = true
                skillCell?.skillNameLabelTrailingConstraint.constant = -24
            }
            skillCell?.viewModel = viewModel.getSkillCellViewModel(at: indexPath)
            skillCell?.delegate = viewModel as SkillCellDelegate
            cell = skillCell
        } else {
            let addButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addButtonCell",
                                                                   for: indexPath) as? AddButtonCell
            cell = addButtonCell
        }
        // TODO: ДИНАМИЧЕСКАЯ ВЫСОТА
        contentSizeHeight = skillsCollectionView.collectionViewLayout.collectionViewContentSize.height
        return cell ?? UICollectionViewCell()
    }
}

// MARK: - Collection View Delegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if viewModel.isEditingMode, viewModel.numberOfItems() == indexPath.item + 1 {
            showAddAlert()
        }
    }
}

// MARK: - Collection View Compositional Layout
extension MainViewController {
    
    private func makeLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(80),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(56)
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item]
            )
            group.contentInsets = .init(top: 12, leading: 0, bottom: 0, trailing: 0)
            group.interItemSpacing = .fixed(12)
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
}

// MARK: - Alert Controller
extension MainViewController {
    
    private func showAddAlert() {
        let alert = UIAlertController(
            title: "Добавление навыка",
            message: "Введите название навыка, которым вы владеете",
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let doneAction = UIAlertAction(
            title: "Добавить",
            style: .default
        ) { [weak self] _ in
            guard let name = alert.textFields?.first?.text else { return }
            guard !name.isEmpty else { return }
            self?.viewModel.createSkill(by: name) {
                self?.viewModel.fetchData {
                    self?.skillsCollectionView.reloadData()
                }
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        alert.addTextField { textField in
            textField.placeholder = "Введите название"
        }
        present(alert, animated: true)
    }
}


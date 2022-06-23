//
//  DynamicHeightCollectionViewCell.swift
//  DynamicCollectionView
//
//  Created by BS901 on 6/22/22.
//

import UIKit

class DynamicHeightCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: DynamicHeightCollectionViewCell.self)
    
    var viewModel: DynamicCollectionViewCellViewModel? {
        didSet {
            
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, imageView, messageLabel])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 22.0
        view.axis = .vertical
        
        return view
    }()
    
    private lazy var cardWidth: NSLayoutConstraint = {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let cons = stackView.widthAnchor.constraint(equalToConstant: 1000)
        cons.isActive = true
        return cons
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureAppearance()
        configureSubviews()
    }
    
    private func applyConstraints () {
        let imageViewConstraints = [
            imageView.widthAnchor.constraint(equalToConstant: 200.0),
            imageView.heightAnchor.constraint(equalToConstant: 200.0)
        ]
        
        let stackViewConstraints = [
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    required init(viewModel: DynamicCollectionViewCellViewModel?) {
        self.init()
        self.viewModel = viewModel
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DynamicHeightCollectionViewCell {
    
    static func expectedCardSize (_ targetSize: CGSize, viewModel: DynamicCollectionViewCellViewModel) -> CGSize {
        
        let cell = DynamicHeightCollectionViewCell(viewModel: viewModel)
        let acsize = cell.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 0.0), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        print(acsize)
        return acsize
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        cardWidth.constant = targetSize.width
        
        return stackView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    }
}

extension DynamicHeightCollectionViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }
    
    
    
    private func updateSubviews() {
        guard let vModel = viewModel else {
            return
        }
        
        titleLabel.text = vModel.title
        imageView.image = vModel.image
        messageLabel.text = vModel.message
    }
}

extension DynamicHeightCollectionViewCell {
    
    func configureAppearance() {
        self.contentView.backgroundColor = .white
    }
    
    func configureSubviews() {
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        applyConstraints()
    }
}

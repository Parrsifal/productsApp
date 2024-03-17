//
//  ProductCollectionViewCell.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 15.03.2024.
//

import UIKit
import Kingfisher


//-------------------------------------------------------
// MARK: - Properties -
//-------------------------------------------------------
class ProductCollectionViewCell: UICollectionViewCell {
    
    private lazy var contentContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImage(systemName: "person")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.Fonts.titlesBig
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textColor = .Constants.darkBlueColor
        label.textAlignment = .left
        
        
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""

        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = UIFont.Fonts.mainTextInfo
        label.textColor = .Constants.mainTextColor
        
        return label
    }()
    
    private lazy var firstPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.Fonts.subTitlesMediun
        label.textColor = .Constants.lightBlue
        
        return label
    }()
    
    private lazy var secondPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.Fonts.subTitlesMediun
        label.textColor = .Constants.darkBlueColor
        
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let image = UIImage(named: "rightBarItem")
        let button = UIButton.roundButton(size: CGSize(width: 36, height: 36), image: image!)
        
        let action = UIAction { _ in
            print("tapped")
        }
                
        button.addTarget(self, action:#selector(tapped), for: .touchUpInside)
        
        return button
    }()
    
    @objc
    func tapped() {
        print("tapped")
    }
    
    private lazy var cartButton: UIButton = {
        let image = UIImage(named: "cartButton")
        let button = UIButton.roundButton(size: CGSize(width: 36, height: 36), image: image!)
        
        let action = UIAction { _ in
            print("tapped")
        }
        
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with product: Product) {
        
        self.titleLabel.text = product.name
        self.subTitle.text = product.details
        let imageUrl = URL(string: product.mainImage)
        
        self.imageView.kf.setImage(with: imageUrl)
        self.firstPrice.text =  "$ \(product.price),-"
        self.secondPrice.text = "$ \(product.price),-"
    }
}

//-------------------------------------------------------
// MARK: - Layout & Style -
//-------------------------------------------------------
extension ProductCollectionViewCell {
    private func setupViews() {
        setupContainer()
        setupDelimeter()
        setupImageView()
        setupInfo()
    }
    
    private func setupContainer() {
        contentView.addSubview(contentContainer)
        
        NSLayoutConstraint.activate([
            
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupImageView() {
        contentContainer.addSubview(imageView)
        imageView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 110),
            imageView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    private func setupInfo() {
        let mainContainer = UIStackView()
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.axis = .vertical
        mainContainer.spacing = 20
        mainContainer.isUserInteractionEnabled = true
        
        let infoContainer = UIStackView()
        infoContainer.translatesAutoresizingMaskIntoConstraints = false
        infoContainer.axis = .vertical
        infoContainer.spacing = 10
        infoContainer.alignment = .leading
        
        infoContainer.addArrangedSubview(titleLabel)
        infoContainer.addArrangedSubview(subTitle)
        
        let priceContainer = UIStackView()
        priceContainer.axis = .horizontal
        priceContainer.spacing = 12
        priceContainer.alignment = .center
        
        priceContainer.addArrangedSubview(firstPrice)
        priceContainer.addArrangedSubview(secondPrice)
        infoContainer.addArrangedSubview(priceContainer)
        
        let buttonContainer = UIView()
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        
        buttonContainer.addSubview(likeButton)
        buttonContainer.addSubview(cartButton)
        
        mainContainer.addArrangedSubview(infoContainer)
        mainContainer.addArrangedSubview(buttonContainer)
        
        contentContainer.addSubview(mainContainer)
        NSLayoutConstraint.activate([
            
            mainContainer.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            mainContainer.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            mainContainer.topAnchor.constraint(equalTo: contentContainer.topAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            
            likeButton.topAnchor.constraint(equalTo: buttonContainer.topAnchor),
            likeButton.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor),
            
            cartButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            cartButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 15)
        ])
    }
    
    private func setupPriceLabels() {
        contentContainer.addSubview(firstPrice)
        contentContainer.addSubview(secondPrice)
        
        NSLayoutConstraint.activate([
            
            firstPrice.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 10),
            firstPrice.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            
            
            secondPrice.leadingAnchor.constraint(equalTo: firstPrice.trailingAnchor, constant: 12),
            secondPrice.centerYAnchor.constraint(equalTo: firstPrice.centerYAnchor),
        ])
    }
    
    private func setupButtons() {
        contentContainer.addSubview(likeButton)
        contentContainer.addSubview(cartButton)
        
        NSLayoutConstraint.activate([
            
            likeButton.topAnchor.constraint(equalTo: firstPrice.bottomAnchor, constant: 20),
            likeButton.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            
            cartButton.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            cartButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 15),
            
        ])
    }
    
    func setupDelimeter() {
        
        let delimeter = UIView()
        delimeter.backgroundColor = .Constants.mainTextColor
        delimeter.layer.opacity = 0.1
        delimeter.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(delimeter)
        NSLayoutConstraint.activate([
            
            delimeter.heightAnchor.constraint(equalToConstant: Constants.delimeterHeight),
            delimeter.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            delimeter.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            delimeter.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
        ])
    }
    
}

//-------------------------------------------------------
// MARK: - Constants -
//-------------------------------------------------------

extension ProductCollectionViewCell {
    enum Constants {
        static let delimeterHeight: CGFloat = 1
    }
}

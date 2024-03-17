//
//  ProductViewController.swift
//  ProductApp
//
//  Created by Dmitrii Sorochin on 16.03.2024.
//

import Foundation
import UIKit
import Kingfisher

final class ProductViewController: UIViewController {
    
    private var productID = 0
    
    private lazy var presenter: ProductViewPresenter = {
        let presenter = ProductViewPresenter()
        presenter.controller = self
        
        return presenter
    }()
    
    private lazy var mainContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Constants.appBackgoundColor
        
        return view
    }()
 
    private lazy var productImageView = UIImageView()
    
    private lazy var detailsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .Constants.appBackgoundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.Fonts.titlesBig
        label.textColor = .Constants.darkBlueColor
        
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        var label = UILabel()
        label.text = ""
        label.font = UIFont.Fonts.mainTextInfo
        label.textColor = .Constants.mainTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.textColor = .Constants.lightBlue
        label.font = UIFont.Fonts.subTitlesMediun
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    private lazy var secondPriceLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.textColor = .Constants.lightGreyColor
        label.font = UIFont.Fonts.subTitlesMediun

        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var informationContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .Constants.appBackgoundColor
        
        return view
    }()
    
    private lazy var informationTitleLabel: UILabel = {
        var label = UILabel()
        label.text = "INFORMATION"
        label.textColor = .Constants.darkBlueColor
        label.font = UIFont.Fonts.titlesBig
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private lazy var informationLabel: UILabel = {
        var label = UILabel()
        label.text = ""
        label.textColor = .Constants.mainTextColor
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.Fonts.mainTextInfo
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var addToCardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ADD TO CARD", for: .normal)
        button.backgroundColor = .Constants.darkBlueColor
        
        return button
    }()
    
    private lazy var buyNowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("BUY NOW", for: .normal)
        button.backgroundColor = .Constants.firstButtonColor
        
        return button
    }()

    
    init(id: Int) {
        self.productID = id
        super.init(nibName: nil, bundle: nil)
  
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//-------------------------------------------------------
// MARK: - View lifcycle -
//-------------------------------------------------------
extension ProductViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.fetchProduct(id: productID)
        
        setupViews()
    }
}
//-------------------------------------------------------
// MARK: - Style & layout -
//-------------------------------------------------------
extension ProductViewController {
    
    func updateData() {
        let url = presenter.product?.mainImage
        productImageView.kf.setImage(with: URL(string: url!))
        
        titleLable.text = presenter.product?.name
        subTitle.text = presenter.product?.size
        priceLabel.text = "$ \(presenter.product!.price),-"
        secondPriceLabel.text = "$ \(presenter.product!.price),-"
        informationLabel.text = presenter.product?.details
    }
    
   
    private func setupViews(){
        view.backgroundColor = .Constants.darkBlueColor
        setupMainContainerView()
        setupProductImageView()
        setupNavigationBar()
        setupContainerStackView()
        setupInfomationContainer()
        setupInformationTitleLabel()
        setupInformationContainerLabel()
        setupButtons()
    }
    
    private func setupMainContainerView() {
        view.addSubview(mainContainerView)
        
        NSLayoutConstraint.activate([
            mainContainerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mainContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupProductImageView() {
        mainContainerView.addSubview(productImageView)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.backgroundColor = .Constants.appBackgoundColor
        productImageView.contentMode = .scaleAspectFit
        
        let delimeter = UIView()
        delimeter.translatesAutoresizingMaskIntoConstraints = false
        delimeter.backgroundColor = .Constants.mainTextColor
        delimeter.layer.opacity = 0.2
        
        productImageView.addSubview(delimeter)

        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 314),
            
            delimeter.heightAnchor.constraint(equalToConstant: 1),
            delimeter.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor),
            delimeter.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            delimeter.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -1),
        ])
    }
    
    private func setupContainerStackView() {
        mainContainerView.addSubview(detailsContainerView)
        
        let containerStack = UIStackView()
        containerStack.axis = .vertical
        containerStack.spacing = 10
        containerStack.alignment = .center
        containerStack.distribution = .fillEqually
        containerStack.backgroundColor = .Constants.appBackgoundColor
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        
        let priceContainer = UIStackView()
        priceContainer.axis = .horizontal
        priceContainer.spacing = 12
        priceContainer.alignment = .center

        containerStack.addArrangedSubview(titleLable)
        containerStack.addArrangedSubview(subTitle)
        
        priceContainer.addArrangedSubview(priceLabel)
        priceContainer.addArrangedSubview(secondPriceLabel)
        
        containerStack.addArrangedSubview(priceContainer)
        
        detailsContainerView.addSubview(containerStack)

        
        NSLayoutConstraint.activate([
            detailsContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            detailsContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            detailsContainerView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 1),
            
            containerStack.topAnchor.constraint(equalTo: detailsContainerView.topAnchor, constant: 25),
            containerStack.bottomAnchor.constraint(equalTo: detailsContainerView.bottomAnchor, constant: -25),
            containerStack.leadingAnchor.constraint(equalTo: detailsContainerView.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: detailsContainerView.trailingAnchor),
            
            detailsContainerView.bottomAnchor.constraint(greaterThanOrEqualTo: containerStack.bottomAnchor),
        ])
    }
    
    private func setupInfomationContainer(){
        mainContainerView.addSubview(informationContainerView)
        
        let delimeter = UIView()
        delimeter.translatesAutoresizingMaskIntoConstraints = false
        delimeter.backgroundColor = .Constants.mainTextColor
        delimeter.layer.opacity = 0.2
        
        informationContainerView.addSubview(delimeter)
                
        NSLayoutConstraint.activate([
    
            informationContainerView.topAnchor.constraint(equalTo: detailsContainerView.bottomAnchor, constant: 1),
            informationContainerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            informationContainerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            informationContainerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            
            delimeter.heightAnchor.constraint(equalToConstant: 1),
            delimeter.leadingAnchor.constraint(equalTo: informationContainerView.leadingAnchor),
            delimeter.trailingAnchor.constraint(equalTo: informationContainerView.trailingAnchor),
            delimeter.topAnchor.constraint(equalTo: informationContainerView.topAnchor, constant: 1),
        ])
    }
    
    private func setupInformationTitleLabel() {
        informationContainerView.addSubview(informationTitleLabel)
        
        NSLayoutConstraint.activate([
            informationTitleLabel.leadingAnchor.constraint(equalTo: informationContainerView.leadingAnchor, constant: 20),
            informationTitleLabel.topAnchor.constraint(equalTo: informationContainerView.topAnchor, constant: 25),
        ])
    }
    
    private func setupInformationContainerLabel() {
        informationContainerView.addSubview(informationLabel)
        
        NSLayoutConstraint.activate([
            informationLabel.leadingAnchor.constraint(equalTo: informationContainerView.leadingAnchor, constant: 20),
            informationLabel.trailingAnchor.constraint(equalTo: informationContainerView.trailingAnchor, constant: -20),
            informationLabel.topAnchor.constraint(equalTo: informationTitleLabel.bottomAnchor, constant: 10),
        ])
    }
    
    private func setupButtons() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .red
        
        containerView.addSubview(addToCardButton)
        containerView.addSubview(buyNowButton)
        
        mainContainerView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 65),
            containerView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor, constant: 65),
            containerView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            addToCardButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 17),
            addToCardButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            addToCardButton.widthAnchor.constraint(equalToConstant: 167),
            
            buyNowButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -17),
            buyNowButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            buyNowButton.widthAnchor.constraint(equalToConstant: 167)
            
        ])
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = .Constants.darkBlueColor
        self.navigationController?.navigationBar.backgroundColor = .Constants.darkBlueColor
        
        let item = UIBarButtonItem(image: UIImage(named: "rightBarItem"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(itemWasTapped))
        item.tintColor = .Constants.appBackgoundColor
        
        self.navigationItem.rightBarButtonItem = item
        
        let backItem = UIBarButtonItem(image: UIImage(named: "backArrow"),
                                       style: .plain,
                                       target: self,
                                       action: #selector(arrowWasTapped))
        
        backItem.tintColor = .Constants.appBackgoundColor
        
        self.navigationItem.leftBarButtonItem = backItem
    }
    
    @objc
    private func itemWasTapped() {
        print("item was tapped")
    }
    
    @objc
    private func arrowWasTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}

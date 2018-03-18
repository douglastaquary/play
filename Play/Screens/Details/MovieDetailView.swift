//
//  MovieDetailView.swift
//  Play
//
//  Created by douglas taquary on 17/03/2018.
//  Copyright © 2018 douglas taquary. All rights reserved.
//

import UIKit

public class MovieDetailView: UIView {
    
    let cancelButton: UIButton = UIButton(type: .system)
    
    let posterImageView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    public var viewModel: MovieDetailViewModelType = MovieDetailViewModel() {
        didSet {
            updateView()
        }
    }
    
    public var topOffset: CGFloat {
        set(topOffset) {
            topConstraint?.constant = topOffset
        }
        
        get {
            return topConstraint?.constant ?? 0
        }
    }
    
    var topConstraint: NSLayoutConstraint?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        updateView()
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        if #available(iOS 11.0, *) {
            contentView.topAnchor
                .constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            contentView.leftAnchor
                .constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
            contentView.rightAnchor
                .constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
            contentView.bottomAnchor
                .constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
            topConstraint?.isActive = true
            contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        
        backgroundColor = UIColor.black
        
        let topBar = UIView()
        let grid: CGFloat = 8
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(bottomLine)
        
        bottomLine.leftAnchor.constraint(equalTo: topBar.leftAnchor).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: topBar.rightAnchor).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        bottomLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: topBar.topAnchor,
                                        constant: grid * 3).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomLine.topAnchor,
                                           constant: -grid * 3).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: topBar.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: topBar.centerYAnchor).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: grid)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        topBar.addSubview(cancelButton)
        
        cancelButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor,
                                              constant: grid * 2).isActive = true
        
        cancelButton.addTarget(self,
                               action: #selector(MovieDetailView.cancelTap),
                               for: .touchUpInside)
        
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topBar)
        
        topBar.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topBar.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        topBar.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: 68).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(posterImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(overviewLabel)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: grid).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -grid).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: grid*2).isActive = true
        
    }
    
    func updateView() {
        titleLabel.attributedText = viewModel.title
        cancelButton.setAttributedTitle(viewModel.cancelButtonText,
                                        for: .normal)
        posterImageView.layer.cornerRadius = 5
        posterImageView.image = viewModel.image.image
        nameLabel.attributedText = viewModel.nameMovie
        overviewLabel.attributedText = viewModel.overview
        
    }

    @objc func cancelTap() {
        viewModel.didTapCancel()
    }
    
}

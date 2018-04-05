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
    
    let trailerButton: PlayButton = {
        let btn = PlayButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        return btn
    }()
    
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
        label.textAlignment = .right
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
        setUpTrailerButton()
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
        trailerButton.addTarget(self,
                               action: #selector(MovieDetailView.watchTrailerTap),
                               for: .touchUpInside)
        
        trailerButton.translatesAutoresizingMaskIntoConstraints = false
        trailerButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        trailerButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
        topBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topBar)
        
        topBar.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topBar.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        topBar.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        topBar.heightAnchor.constraint(equalToConstant: grid*8).isActive = true
        
        posterImageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = grid
        stackView.addArrangedSubview(posterImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(overviewLabel)
        stackView.addArrangedSubview(trailerButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topBar.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: grid).isActive = true
        stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -grid).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -grid*4).isActive = true
        
    }
    
    func updateView() {
        titleLabel.attributedText = viewModel.title
        cancelButton.setAttributedTitle(viewModel.cancelButtonText,
                                        for: .normal)
        posterImageView.layer.cornerRadius = 5
        posterImageView.download(image: viewModel.imagePath)
        nameLabel.attributedText = viewModel.nameMovie
        overviewLabel.attributedText = viewModel.overview
    }

    @objc func cancelTap() {
        viewModel.didTapCancel()
    }
    
    @objc func watchTrailerTap() {
        viewModel.didTapWatchTrailer()
    }
    
    func setUpTrailerButton() {
        trailerButton.alpha = 0.5
        trailerButton.isEnabled = false
        trailerButton.layer.cornerRadius = 9
        trailerButton.setAttributedTitle(NSAttributedString(string: "Assistir trailer",
                                                            font: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold),
                                                            color: .black), for: .normal)
    }
    
}

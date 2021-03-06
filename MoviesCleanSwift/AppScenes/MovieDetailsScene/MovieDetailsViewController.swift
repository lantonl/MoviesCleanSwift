//
//  MovieDetailsViewController.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 20.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    func displayMovieDetails(viewModel: MovieDetails.UI.ViewModel)
}

class MovieDetailsViewController: BaseViewController, ModuleConfiguratorBased {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    @IBOutlet private var closeButton: UIButton!
    
    var interactor: MovieDetailsBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailsRoutingLogic & MovieDetailsDataPassing)?
    
    var moduleConfigurator: MovieDetailsModuleConfigurator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.getMovieDetails()
    }
    
    func setup() {
        moduleConfigurator.module(configure: self)
        interactor?.getMovieDetails()
    }
    
    private func setupUI(with configuration: MovieDetailsViewControllerConfiguration) {
        titleLabel.font = configuration.titleLabelFont
        descriptionTextView.font = configuration.descriptionTextViewFont
        ratingLabel.font = configuration.ratingLabelFont
        releaseDateLabel.font = configuration.releaseDateLabelFont
        
        closeButton.setTitle(configuration.closeButtonTitleText, for: .normal)
        closeButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic {
    func displayMovieDetails(viewModel: MovieDetails.UI.ViewModel) {
        setupUI(with: viewModel.configuration)
        
        titleLabel.text = viewModel.configuration.titleText
        descriptionTextView.text = viewModel.configuration.desriptionText
        ratingLabel.text = viewModel.configuration.ratingText
        releaseDateLabel.text = viewModel.configuration.releaseDateText
    }
}



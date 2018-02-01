//
//  ProfileView.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/28/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var primaryMetadataLabel: UILabel!
    @IBOutlet weak var secondarMetadataLabel: UILabel!

    var interactionHandler: ProfileViewInteractionHandler?

    // MARK: - Lifecycle

    override func layoutSubviews() {
        super.layoutSubviews()
        setupImageView()
    }

    // MARK: - Setup

    private func setupImageView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.height / 2.0
    }

    // MARK: - Public Interface

    func configure(with viewData: ProfileViewData, interactionHandler: ProfileViewInteractionHandler? = nil) {
        nameLabel.text = viewData.name
        primaryMetadataLabel.text = viewData.primaryMetadata
        secondarMetadataLabel.text = viewData.secondaryMetadata

        self.interactionHandler = interactionHandler

        // Even here, we can setup bindings. Example:
        /*
         viewData.name.bind { (newValue) in
            nameLabel?.text = newValue
         }
         */
    }

    // MARK: - IBActions

    @IBAction func viewTapped(sender: UIButton) {
        interactionHandler?.didTapView(sender: self)
    }
}

//
//  ProfileViewDataTransformer.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/28/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class ProfileViewDataTransformer {

    static func viewData(from authorCard: LILAuthorCard, createdDate: Date) -> ProfileViewData {

        // Image url
        var imageURL: URL? {
            if let thumbnailPath = authorCard.thumbnails?.first {
                return URL(string: thumbnailPath)
            }
            return nil
        }

        // Created date
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/YY hh:mm:ss"
        let secondaryMetadata = formatter.string(from: createdDate)

        return ProfileViewData(imageURL: imageURL, name: authorCard.fullName, primaryMetadata: authorCard.headline, secondaryMetadata: secondaryMetadata)
    }

}

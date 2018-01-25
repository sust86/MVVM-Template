//
//  ViewSpec.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/24/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

class ViewSpecMap {

    private var map = [String: ViewSpec]()

    init(map: [String: ViewSpec]) {
        self.map = map
    }

    func spec(for viewDataType: String) -> ViewSpec? {
        return map[viewDataType]
    }

}

class ViewSpec {

    var viewClass: UIView.Type
    var interactionHandler: InteractionHandler?
    //    var binder: ViewBinderType
    //    var style: ViewStyleType

    init(viewClass: UIView.Type, interactionHandler: InteractionHandler?) {
        self.viewClass = viewClass
        self.interactionHandler = interactionHandler
    }
}

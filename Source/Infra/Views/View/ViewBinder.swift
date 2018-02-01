//
//  ViewBinder.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/31/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

// ....mäh?
//class ViewBinder {
//
//    typealias ViewBinderBind = (_ viewData: ViewData, _ toView: UIView, _ viewSpec: ViewSpecMap) -> Void
//
//    private var bindingClosure: ViewBinderBind
//
//    init(bindingClosure: @escaping ViewBinderBind) {
//        self.bindingClosure = bindingClosure
//    }
//
//    func bindViewData(viewData: ViewData, toView view: UIView, using viewSpecMap: ViewSpecMap) {
//        bindingClosure(viewData, view, viewSpecMap)
//    }
//}

protocol ViewBinderProtocol {
    func bindView(_ view: UIView, to data: ViewData, using viewSpecMap: ViewSpecMap)
}

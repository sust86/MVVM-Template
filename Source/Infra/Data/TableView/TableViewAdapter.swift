//
//  TableViewAdapter.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation
import UIKit

class TableViewAdapter: NSObject {

    private let viewDataCollection: ViewDataCollection
    private let viewSpecMap: ViewSpecMap
    private var registeredCellIds = [String]()

    // MARK: - Lifecycle

    init(viewDataCollection: ViewDataCollection, viewSpecMap: ViewSpecMap) {
        self.viewDataCollection = viewDataCollection
        self.viewSpecMap = viewSpecMap
        super.init()
    }
}

// MARK: - UITableViewDataSource
extension TableViewAdapter: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewDataCollection.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewDataCollection.numberOfItems(inSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get view data
        guard let viewData = viewDataCollection.viewData(atIndexPath: indexPath) else {
            return UITableViewCell() // We should have an empty cell as a fallback in case anything goes wrong.
        }
        // Get view spec
        guard let viewSpec = viewSpecMap.spec(for: String(describing: type(of: viewData))) else {
            return UITableViewCell()
        }
        // Get cell class
        guard let reusableCellClass = viewSpec.viewClass as? ReusableCell.Type else {
            return UITableViewCell()
        }
        // Register cell
        registerCellIfNeeded(reusableCellClass, for: tableView)

        // Dequeue cell
        guard let reusableCell = tableView.dequeueReusableCell(withIdentifier: reusableCellClass.reuseIdentifier, for: indexPath) as? ReusableCell else {
            return UITableViewCell()
        }
        // Configure cell
        viewSpec.viewBinder?.bindView(reusableCell, to: viewData, using: viewSpecMap)

        return reusableCell
    }

    private func registerCellIfNeeded(_ reusableCellClass: ReusableCell.Type, for tableView: UITableView) {
        let cellReuseIdentifier = reusableCellClass.reuseIdentifier
        guard !registeredCellIds.contains(cellReuseIdentifier) else {
            return
        }
        let cellNib = UINib(nibName: cellReuseIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellReuseIdentifier)
        registeredCellIds.append(cellReuseIdentifier)
    }

}

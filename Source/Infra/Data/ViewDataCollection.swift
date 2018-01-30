//
//  ViewDataCollection.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class ViewDataCollection {

    private var data: [[ViewData]]

    // MARK: - Lifecycle

    init(data: [[ViewData]] = [[]]) {
        self.data = data
    }

    // MARK: - Public Methods

    // MARK: Accessing Data

    func viewData(atIndexPath indexPath: IndexPath) -> ViewData? {
        return data[indexPath.section][indexPath.row]  // add safe access
    }

    // MARK: Querying Data

    func numberOfSections() -> Int {
        return data.count
    }

    func numberOfItems(inSection section: Int) -> Int {
        return data[section].count
    }

    func indexPathOfLastItem() -> IndexPath {
        let lastSection = numberOfSections() - 1
        let lastRow = numberOfItems(inSection: lastSection) - 1
        return IndexPath(row: lastRow, section: lastSection)
    }

    // MARK: Updating Data

    func updateData(data: [[ViewData]]) {
        self.data = data
    }

    func appendData(data: [[ViewData]]) {
        self.data.append(contentsOf: data)
    }

    func updateDataInSections(sectionDataMap: [Int: [ViewData]]) {
        // TODO
    }

    func updateItemsAtIndexPaths(indexPathDataMap: [IndexPath: ViewData]) {
        // TODO
    }

}

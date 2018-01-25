//
//  ViewDataCollection.swift
//  QA
//
//  Created by Stefan Stumpfl on 1/16/18.
//  Copyright © 2018 LinkedIn. All rights reserved.
//

import Foundation

class ViewDataCollection {

    var data: [[ViewData?]]

    init(data: [[ViewData?]]) {
        self.data = data
    }

    // MARK: - Public Interface

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
    // MARK: Updating Data

    //#pragma mark - Accessing Data
    //- (nullable NSObject<NEOViewData> *)viewDataAtIndexPath:(nonnull NSIndexPath *)indexPath;
    //
    //#pragma mark - Querying Data
    //- (NSInteger)numberOfSections;
    //- (NSInteger)numberOfItemsInSection:(NSInteger)section;
    //
    //#pragma mark - Updating Data
    //- (void)updateData:(nonnull NSArray<id> *)data;
    //- (void)updateDataInSections:(nonnull NSDictionary<NSNumber *, NSArray<id> *> *)sectionDataMap;
    //- (void)updateItemsAtIndexPaths:(nonnull NSDictionary<NSIndexPath *, id> *)indexPathDataMap;
}

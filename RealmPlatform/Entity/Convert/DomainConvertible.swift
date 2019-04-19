//
//  DomainConvertible.swift
//  RealmPlatform
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation
import RealmSwift
internal protocol DomainConvertible: Object {
    associatedtype Domain
    func asDomain() -> Domain
}

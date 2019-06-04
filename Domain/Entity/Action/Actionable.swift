//
//  Actionable.swift
//  Domain
//
//  Created by 이광용 on 28/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public protocol ActionParantable: AnyObject {
}

public protocol Actionable: RoadMapComponentable, AnyObject {
    var identifier: TimerXIdentifier { get }
    var parent: ActionParantable? { get set }
    var uuid: String { get }
    var title: String { get }
}



//
//  EventCombination.swift
//  Domain
//
//  Created by 이광용 on 18/04/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import Foundation

public struct EventCombination {
    public let uuid: String
    public let title: String
    public var events: [AbstractEvent]
    public init(uuid: String = UUID().uuidString,
                title: String,
                events: [AbstractEvent]) {
        self.uuid = uuid
        self.title = title
        self.events = events
    }
}

public extension EventCombination {
    static func == (lhs: EventCombination,
                    rhs: EventCombination) -> Bool {
        return lhs.uuid == rhs.uuid &&
            lhs.title == rhs.title
    }
}

//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation


class EventsProvider {

    let displayedDate: Date

    init(displayedDate: Date) {
        self.displayedDate = displayedDate
    }

    func events() -> [ExampleCalendarEvent] {
        var events = [ExampleCalendarEvent]()

        events.append(ExampleCalendarEvent(name: "TDD Workshop Summary",
                startDate: 8.hours.from(date: displayedDate)!,
                endDate: 10.hours.from(date: displayedDate)!))

        events.append(ExampleCalendarEvent(name: "RxSwift Workshop - Planning",
                startDate: 12.hours.from(date: displayedDate)!,
                endDate: 13.hours.from(date: displayedDate)!))

        events.append(ExampleCalendarEvent(name: "Animations Workshop - Scope",
                startDate: 16.hours.from(date: displayedDate)!,
                endDate: 18.hours.from(date: displayedDate)!))

        return events
    }
}

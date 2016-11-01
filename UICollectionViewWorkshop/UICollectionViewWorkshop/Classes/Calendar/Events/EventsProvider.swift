//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation


class EventsProvider {
    
    let displayedDate: Date
    
    init(displayedDate: Date) {
        self.displayedDate = displayedDate
    }
    
    func makeEvents() -> [CalendarEvent] {
        var events = [CalendarEvent]()
        
        events.append(ExampleCalendarEvent(name: "TDD Workshop Summary",
                                           startDate: Date(),
                                           endDate: Date()))
        
        events.append(ExampleCalendarEvent(name: "RxSwift Workshop - Planning",
                                           startDate: Date(),
                                           endDate: Date()))
        
        events.append(ExampleCalendarEvent(name: "Animations Workshop - Scope",
                                           startDate: Date(),
                                           endDate: Date()))
        
        return events
    }
}

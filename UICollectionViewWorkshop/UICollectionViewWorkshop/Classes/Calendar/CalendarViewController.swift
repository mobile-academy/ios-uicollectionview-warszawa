//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate

final class CalendarViewController: UICollectionViewController {

    let eventsProvider = EventsProvider(displayedDate: Date().startOfDay)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        title = "Calendar"
        tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "Clock"), tag: 2)
    }

    //MARK: UICollectionView Delegate & Data Source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsProvider.events().count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CalendarCollectionViewCell
        let event = eventsProvider.events()[indexPath.item]

        cell.textLabel.text = event.name

        return cell
    }
}

extension CalendarViewController: CalendarCollectionViewLayoutDelegate {

    func startOfDisplayedDay(forCalendarCollectionViewLayout: CalendarCollectionViewLayout) -> Date {
        return eventsProvider.displayedDate.startOfDay
    }

    func endOfDisplayedDay(forCalendarCollectionViewLayout: CalendarCollectionViewLayout) -> Date {
        return eventsProvider.displayedDate.endOfDay
    }

    func handViewDate(forCalendarCollectionViewLayout: CalendarCollectionViewLayout) -> Date {
        return Date()
    }

    func calendarEvents(forCalendarCollectionViewLayout: CalendarCollectionViewLayout) -> [CalendarEvent] {
        return eventsProvider.events()
    }
}

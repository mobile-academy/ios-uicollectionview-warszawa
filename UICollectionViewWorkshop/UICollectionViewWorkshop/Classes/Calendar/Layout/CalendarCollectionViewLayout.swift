//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import SwiftDate

protocol CalendarEvent {
    var startDate: Date { get }
    var endDate: Date { get }
}

enum CalendarDecorationViewKind: String {

    case hand = "Hand"
    case separator = "Separator"
}

protocol CalendarCollectionViewLayoutDelegate: UICollectionViewDelegate {

    func startOfDisplayedDay(forCalendarCollectionViewLayout: CalendarCollectionViewLayout) -> Date

    func endOfDisplayedDay(forCalendarCollectionViewLayout: CalendarCollectionViewLayout) -> Date

    func handViewDate(forCalendarCollectionViewLayout: CalendarCollectionViewLayout) -> Date

    func calendarEvents(forCalendarCollectionViewLayout: CalendarCollectionViewLayout) -> [CalendarEvent]
}

class CalendarCollectionViewLayout: UICollectionViewLayout {

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .short
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()

    fileprivate var startOfDisplayedDay: Date!
    fileprivate var endOfDisplayedDay: Date!

    fileprivate var handViewDate: Date!

    fileprivate var cachedCellsLayoutAttributes = [UICollectionViewLayoutAttributes]()
    fileprivate var cachedSeparatorsLayoutAttributes = [UICollectionViewLayoutAttributes]()

    //MARK: UICollectionViewLayout

    override func prepare() {
        super.prepare()

        guard let calendarDelegate = collectionView?.delegate as? CalendarCollectionViewLayoutDelegate else {
            fatalError("Attempted to use calendar collection view layout, but no valid calendar delegate is set!")
        }

        startOfDisplayedDay = calendarDelegate.startOfDisplayedDay(forCalendarCollectionViewLayout: self)
        endOfDisplayedDay = calendarDelegate.endOfDisplayedDay(forCalendarCollectionViewLayout: self)
        handViewDate = calendarDelegate.handViewDate(forCalendarCollectionViewLayout: self)

        register(HandView.self, forDecorationViewOfKind: CalendarDecorationViewKind.hand.rawValue)
        register(SeparatorView.self, forDecorationViewOfKind: CalendarDecorationViewKind.separator.rawValue)

        let events = calendarDelegate.calendarEvents(forCalendarCollectionViewLayout: self)
        cachedCellsLayoutAttributes = calculateCellLayoutAttributes(forEvents: events)
        cachedSeparatorsLayoutAttributes = calculateSeparatorLayoutAttributes()
    }

    override var collectionViewContentSize: CGSize {
        var collectionViewContentSize = super.collectionViewContentSize
        collectionViewContentSize.height = CGFloat(startOfDisplayedDay.minutes(toDate: endOfDisplayedDay))
        return collectionViewContentSize
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()

        layoutAttributes.append(contentsOf: cachedCellsLayoutAttributes)
        layoutAttributes.append(contentsOf: cachedSeparatorsLayoutAttributes)
        layoutAttributes.append(calculateHandViewLayoutAttributes())

        return layoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedCellsLayoutAttributes[indexPath.item]
    }

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let kind = CalendarDecorationViewKind(rawValue: elementKind) else {
            return nil
        }

        switch kind {
        case .hand:
            return calculateHandViewLayoutAttributes()
        case .separator:
            return cachedSeparatorsLayoutAttributes[indexPath.item]
        }
    }

    override func invalidateLayout() {
        super.invalidateLayout()

        cachedCellsLayoutAttributes = [UICollectionViewLayoutAttributes]()
        cachedSeparatorsLayoutAttributes = [UICollectionViewLayoutAttributes]()
    }
}

//MARK: Helpers

fileprivate extension CalendarCollectionViewLayout {

    func calculateCellLayoutAttributes(forEvents events: [CalendarEvent]) -> [UICollectionViewLayoutAttributes] {
        var cellsAttributes = [UICollectionViewLayoutAttributes]()
        let numberOfItems = collectionView!.numberOfItems(inSection: 0)

        for a in 0 ..< numberOfItems {
            let event = events[a]

            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: a, section: 0))

            let yPosition = CGFloat(startOfDisplayedDay.minutes(toDate: event.endDate))
            let cellHeight = CGFloat(event.startDate.minutes(toDate: event.endDate))

            var frame = CGRect.zero
            frame.origin = CGPoint(x: 0, y: yPosition)
            frame.size = CGSize(width: collectionView!.frame.width, height: cellHeight)

            attributes.frame = frame

            cellsAttributes.append(attributes)
        }

        return cellsAttributes
    }

    func calculateHandViewLayoutAttributes() -> UICollectionViewLayoutAttributes {
        let indexPath = IndexPath(item: 0, section: 0)
        let attributes = CalendarCollectionViewLayoutAttributes(calendarDecorationViewKind: .hand, with: indexPath)
        attributes.zIndex = 1

        let xPosition = CGFloat(startOfDisplayedDay.minutes(toDate: handViewDate))
        var frame = CGRect.zero
        frame.size = CGSize(width: collectionView!.frame.width, height: 1)
        frame.origin = CGPoint(x: 0, y: xPosition)

        attributes.frame = frame

        return attributes
    }

    func calculateSeparatorLayoutAttributes() -> [UICollectionViewLayoutAttributes] {
        var separatorAttributes = [UICollectionViewLayoutAttributes]()

        // We make a small assumption here that start of displayed date is a full hour
        let hours = startOfDisplayedDay.hours(toDate: endOfDisplayedDay)

        var elementIndex = 0

        for hour in 0...hours {
            let fullHour = startOfDisplayedDay + hour.hour
            let attributes = CalendarCollectionViewLayoutAttributes(calendarDecorationViewKind: .separator, with: IndexPath(item: elementIndex, section: 0))
            attributes.separatorColor = .lightGray
            attributes.separatorText = dateFormatter.string(from: fullHour)
            attributes.frame = CGRect(x: 0, y: CGFloat(startOfDisplayedDay.minutes(toDate: fullHour)) - 20, width: collectionView!.frame.width, height: 40)

            separatorAttributes.append(attributes)

            elementIndex += 1

            let halfHour = fullHour + 30.minutes
            let halfAttributes = CalendarCollectionViewLayoutAttributes(calendarDecorationViewKind: .separator, with: IndexPath(item: elementIndex, section: 0))
            halfAttributes.separatorColor = .darkGray
            halfAttributes.frame = CGRect(x: 0, y: CGFloat(startOfDisplayedDay.minutes(toDate: halfHour)) - 20, width: collectionView!.frame.width, height: 40)

            separatorAttributes.append(halfAttributes)

            elementIndex += 1
        }

        return separatorAttributes
    }
}

extension UICollectionViewLayoutAttributes {

    convenience init(calendarDecorationViewKind: CalendarDecorationViewKind, with indexPath: IndexPath) {
        self.init(forDecorationViewOfKind: calendarDecorationViewKind.rawValue, with: indexPath)
    }
}

fileprivate extension Date {

    func minutes(toDate date: Date) -> Int {
        let calendar = Calendar.current

        return calendar.dateComponents([.minute], from: self, to: date).minute!
    }

    func hours(toDate date: Date) -> Int {
        let calendar = Calendar.current

        return calendar.dateComponents([.hour], from: self, to: date).hour!
    }
}

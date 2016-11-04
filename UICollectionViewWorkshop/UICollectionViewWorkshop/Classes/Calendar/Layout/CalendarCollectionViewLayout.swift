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
}

class CalendarCollectionViewLayout: UICollectionViewLayout {

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
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

        //TODO  Assignment 2: Register hand view class
        //TODO  Assignment 3: Register separator view class
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

        //TODO Assignment 2: Add hand view attributes

        return super.layoutAttributesForElements(in: rect)
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

        for a in 0 ... numberOfItems {
            //TODO Assignment 2: Calculate position and size of layout attributes for cell for given event, based on its start and end date
        }

        return cellsAttributes
    }

    func calculateHandViewLayoutAttributes() -> UICollectionViewLayoutAttributes {
        let indexPath = IndexPath(item: 0, section: 0)
        let attributes = CalendarCollectionViewLayoutAttributes(calendarDecorationViewKind: .hand, with: indexPath)
        attributes.zIndex = 1

        //TODO Assignment 2: Calculate appropriate frame for hand view

        attributes.frame = CGRect.zero

        return attributes
    }

    func calculateSeparatorLayoutAttributes() -> [UICollectionViewLayoutAttributes] {
        var cellsAttributes = [UICollectionViewLayoutAttributes]()

        // TODO Assignment 3: Calculate separator layout attributes based on number of full hours (include half hour separators as well!)

        return cellsAttributes
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
}

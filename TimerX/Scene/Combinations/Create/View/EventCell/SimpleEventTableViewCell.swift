//
//  SimpleEventTableViewCell.swift
//  TimerX
//
//  Created by 이광용 on 06/05/2019.
//  Copyright © 2019 GwangYongLee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class SimpleEventTableVeiwCell: EventTableViewCell {
    private var dataSource: RxTableViewSectionedReloadDataSource<SimpleEventSection>?
    fileprivate let timeIntervalSelectionTrigger = PublishSubject<TimeInterval>()
    fileprivate let countSegmentSelectionTrigger = PublishSubject<Int>()
    override func initialize() {
        super.initialize()
        tableView.register(class: EventTimeTableViewCell.self)
        tableView.register(class: EventCountTableViewCell.self)
        dataSource = makeDataSource()
    }
}
extension SimpleEventTableVeiwCell: CellViewProtocol {
    func bind(_ cellViewModel: SimpleEventCellViewModel) {
        guard let dataSource = dataSource else { return }
        let rowSelection = tableView.rx.modelSelected(SimpleEventRow.self).asDriver()
        let countSegmentSelectionTrigger = self.countSegmentSelectionTrigger.asDriverOnErrorJustComplete()
        let input = SimpleEventCellViewModel.Input(rowSelectionTrigger: rowSelection,
                                                   countSegmentSelectionTrigger: countSegmentSelectionTrigger)
        let output = cellViewModel.transform(input)
        [output.title.drive(titleLabel.rx.text),
         output.sections.drive(tableView.rx.items(dataSource: dataSource)),
         output.countSegmentSelection.drive()].forEach {
            $0.disposed(by: disposeBag)
        }
    }
    private func makeDataSource() -> RxTableViewSectionedReloadDataSource<SimpleEventSection> {
        return RxTableViewSectionedReloadDataSource<SimpleEventSection>(
            configureCell: { [weak self] (dataSource, tableView, indexPath, _) -> UITableViewCell in
                guard let self = self else { return UITableViewCell() }
                switch dataSource[indexPath] {
                case let .time(viewModel):
                    let cell = tableView.dequeueReusableCell(with: EventTimeTableViewCell.self, for: indexPath)
                    cell.bind(viewModel)
                    return cell
                case let .countType(viewModel):
                    let cell = tableView.dequeueReusableCell(with: EventCountTableViewCell.self, for: indexPath)
                    cell.bind(viewModel)
                    cell.segmentControl.rx.selectedSegmentIndex
                        .bind(to: self.countSegmentSelectionTrigger)
                        .disposed(by: cell.disposeBag)
                    return cell
                }
            })
    }
}

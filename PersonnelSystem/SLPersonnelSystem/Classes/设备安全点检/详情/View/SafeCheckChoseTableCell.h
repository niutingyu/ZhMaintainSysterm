//
//  SafeCheckChoseTableCell.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/23.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SafeCheckListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SafeCheckChoseTableCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *swithBut;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic,copy)NSString *auditTypeString;

@property(nonatomic,strong)SafeCheckListModel *model;

@end

NS_ASSUME_NONNULL_END

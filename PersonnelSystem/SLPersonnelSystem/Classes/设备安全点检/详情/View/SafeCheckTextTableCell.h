//
//  SafeCheckTextTableCell.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/23.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SafeCheckListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SafeCheckTextTableCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *txtF;

@property(nonatomic,strong)SafeCheckListModel *model;

@property (nonatomic,copy)NSString *auditTypeString;
@end

NS_ASSUME_NONNULL_END

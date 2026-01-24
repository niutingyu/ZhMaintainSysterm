//
//  SafeCheckResultTableCell.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/23.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SafeCheckModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SafeCheckResultTableCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *txtF;

@property (nonatomic,strong)SafeCheckModel *model;

@property (nonatomic,assign)NSInteger cellTag;

@property (nonatomic,copy)NSString *auditTypeString;
@end

NS_ASSUME_NONNULL_END

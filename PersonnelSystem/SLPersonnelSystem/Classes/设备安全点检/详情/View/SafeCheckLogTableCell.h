//
//  SafeCheckLogTableCell.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/24.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SafeCheckLogTableCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *infoLab;

@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *remarkLab;
@end

NS_ASSUME_NONNULL_END

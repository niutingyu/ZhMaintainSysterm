//
//  SafeCheckTaskCell.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/7.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SafeCheckListModel.h"
#import "SafeCheckModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SafeCheckTaskCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *durationLab;


-(void)configCellWithModel:(SafeCheckModel*)model count:(NSString*)countStr;

@end

NS_ASSUME_NONNULL_END

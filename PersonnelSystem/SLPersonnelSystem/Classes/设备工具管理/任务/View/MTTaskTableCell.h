//
//  MTTaskTableCell.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/19.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTTaskTableCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *yearLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UILabel *depLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *reasonLab;
@property (weak, nonatomic) IBOutlet UILabel *indexLab;

@end

NS_ASSUME_NONNULL_END

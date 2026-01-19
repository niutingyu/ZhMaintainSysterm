//
//  MTToolCell.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/16.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MTToolModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MTToolCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lalLab;

@property (weak, nonatomic) IBOutlet UITextView *tfValue;
@property (nonatomic,strong)MTToolModel *model;


@end

NS_ASSUME_NONNULL_END

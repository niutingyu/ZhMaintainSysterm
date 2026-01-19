//
//  MTToolTypeTableCell.h
//  ServiceSysterm
//
//  Created by Andy on 2019/5/29.
//  Copyright © 2019 SLPCB. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ToolMaterialModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MTToolTypeTableCell : BaseTableViewCell


@property (weak, nonatomic) IBOutlet UITextField *inputTF;


@property (weak, nonatomic) IBOutlet UILabel *tipLab;

-(void)setupCellWithModel:(ToolMaterialModel*)model;

@property (nonatomic,strong)ToolMaterialModel* materialModel;
@end

NS_ASSUME_NONNULL_END

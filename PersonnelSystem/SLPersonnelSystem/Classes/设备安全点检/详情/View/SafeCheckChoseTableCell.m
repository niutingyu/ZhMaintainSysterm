//
//  SafeCheckChoseTableCell.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/23.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckChoseTableCell.h"

@implementation SafeCheckChoseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    [self.swithBut addTarget:self action:@selector(swithcMethod:) forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(SafeCheckListModel *)model{
    _model =model;
    if(model.CheckValue.length ==0){
        model.CheckValue =@"异常";
    }else{
        if([model.CheckValue isEqualToString:@"正常"]){
            [self.swithBut setOn:YES];
        }else{
            [ self.swithBut setOn :NO];
        }
    }
    
   
    
}

-(void)setAuditTypeString:(NSString *)auditTypeString{
    if([auditTypeString isEqualToString:@"编辑"]){
        [self.swithBut setEnabled:YES ];
    }else{
        [self.swithBut setEnabled:NO];
    }
}

-(void)swithcMethod:(id)sender{
    UISwitch *controler =(UISwitch*)sender;
    if(controler .isOn){
        _model.CheckValue =@"正常";
    }else{
        _model.CheckValue =@"异常";
    }
    
}

@end

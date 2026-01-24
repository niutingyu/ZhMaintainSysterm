//
//  SafeCheckTextTableCell.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/23.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckTextTableCell.h"

@interface SafeCheckTextTableCell()<UITextFieldDelegate>

@end
@implementation SafeCheckTextTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.txtF.delegate =self;
}

-(void)setModel:(SafeCheckListModel *)model{
    _model =model;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    _model.CheckValue =textField.text;
}
    
-(void)setAuditTypeString:(NSString *)auditTypeString{
    if([auditTypeString isEqualToString:@"编辑"]){
        [self.txtF setEnabled:YES ];
    }else{
        [self.txtF setEnabled:NO];
    }
}

@end

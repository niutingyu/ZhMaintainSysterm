//
//  SafeCheckResultTableCell.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/23.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckResultTableCell.h"

@interface SafeCheckResultTableCell ()<UITextFieldDelegate>

@end
@implementation SafeCheckResultTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.txtF.delegate =self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(SafeCheckModel *)model{
    _model =model;
}



-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(_cellTag==0){
        _model.CheckResult =textField.text;
    }else if (_cellTag ==1){
        _model.ImplementationPlan =textField.text;
    }
}
-(void)setAuditTypeString:(NSString *)auditTypeString{
    if([auditTypeString isEqualToString:@"编辑"]){
        [self.txtF setEnabled:YES ];
    }else{
        [self.txtF setEnabled:NO];
    }
}
@end

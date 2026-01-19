//
//  MTToolTypeTableCell.m
//  ServiceSysterm
//
//  Created by Andy on 2019/5/29.
//  Copyright © 2019 SLPCB. All rights reserved.
//

#import "MTToolTypeTableCell.h"


@interface MTToolTypeTableCell ()<UITextFieldDelegate>{
    ToolMaterialModel *_toolModel;
}

@end

@implementation MTToolTypeTableCell



- (void)awakeFromNib {
    [super awakeFromNib];
    self.inputTF.delegate =self;
    self.inputTF.keyboardType =UIKeyModifierNumericPad;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setupCellWithModel:(ToolMaterialModel*)model{
    self.inputTF.text =model.CustomCount;
    self.tipLab.text =[NSString stringWithFormat:@"%@(%@%@)",model.ToolName,model.ToolCount,model.ToolPCS];
   
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([string intValue]> [self.materialModel.ToolCount intValue]){
        textField.text =@"1";
        return false;
    }else{
        self.materialModel.CustomCount = string;
        return true;
    }
   
}



@end

//
//  MTToolCell.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/16.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "MTToolCell.h"

@interface MTToolCell ()<UITextViewDelegate>

@end
@implementation MTToolCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tfValue.delegate =self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(MTToolModel *)model{
    _model =model;
   
}



-(void)textViewDidEndEditing:(UITextView *)textView{
    self.model.LoanReasion =textView.text;
}

@end

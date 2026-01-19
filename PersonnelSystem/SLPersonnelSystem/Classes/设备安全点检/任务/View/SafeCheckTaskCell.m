//
//  SafeCheckTaskCell.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/7.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckTaskCell.h"

@implementation SafeCheckTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(SafeCheckModel *)model{
    
}
-(void)configCellWithModel:(SafeCheckModel*)model count:(NSString*)countStr{
    self.dateLab.text  =[Units timeWithTime:model.IssueTime beforeFormat:@"yyyy-MM-dd HH:mm:ss" andAfterFormat:@"yy/MM/dd"];
    self.timeLab.text  =[Units timeWithTime:model.IssueTime beforeFormat:@"yyyy-MM-dd HH:mm:ss" andAfterFormat:@"HH:mm"];
    self.titleLab.text  =model.FacilityName?:@"";
    self.contentLab.text = model.Code?:@"";
    self.countLab.text  =countStr;
    self.statusLab.text =model.statusStr;
    self.durationLab.text  =[NSString stringWithFormat:@"距离开单时间:%@",[self delayTime:model.IssueTime andEndTime:nil]];
    
}

//处理超时的时间
- (NSString *)delayTime:(NSString *)time andEndTime:(NSString *)endTime
{
    
    NSDate *date ;
    if (endTime == nil) {
        date =[NSDate date];
    }else{
        date = [Units dataFromString:endTime withFormat:nil];
    }
    NSTimeInterval now = [date timeIntervalSince1970];
    NSTimeInterval before = [[Units dataFromString:time withFormat:nil] timeIntervalSince1970];
    NSTimeInterval cha = now - before;
    long l = cha;
    NSString *hour = [NSString stringWithFormat:@"%ld",l/3600];
    NSString *second = [NSString stringWithFormat:@"%ld",l%3600/60];
    if (l/3600 < 10) {
        hour = [NSString stringWithFormat:@"0%@",hour];
    }
    if (l%3600/60 < 10) {
        second = [NSString stringWithFormat:@"0%@",second];
    }
    
    return [NSString stringWithFormat:@"%@时%@分",hour,second];
}

@end

//
//  SafeTableHeadView.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/9.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeTableHeadView.h"

@interface SafeTableHeadView()
@property (nonatomic,strong)UILabel *titleLab;
@end
@implementation SafeTableHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor blueColor];
        [self setupFrame];
    }
    return self;
}

-(void)setupFrame{
    UILabel * titleLab =[[UILabel alloc]init];
    titleLab.frame  = CGRectMake(8, 10, 260, 25);
    titleLab.textColor  =[UIColor whiteColor];
    self.titleLab  =titleLab;
    [self addSubview:titleLab];
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr  =titleStr;
    self.titleLab.text  =titleStr;
}

@end

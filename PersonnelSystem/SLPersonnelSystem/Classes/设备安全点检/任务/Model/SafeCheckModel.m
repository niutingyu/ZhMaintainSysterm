//
//  SafeCheckModel.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/7.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckModel.h"

@implementation SafeCheckModel

-(void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if (_Status ==-1) {
        _statusStr =@"退回";
    }else if (_Status  ==0){
        _statusStr =@"待接单";
    }else if (_Status  ==1){
        _statusStr =@"点检中";
    }else if (_Status ==2){
        _statusStr =@"已接单";
    }
}
+(NSDictionary*)mj_objectClassInArray{
    return @{@"checkList":[SafeCheckListModel class]};
}

@end

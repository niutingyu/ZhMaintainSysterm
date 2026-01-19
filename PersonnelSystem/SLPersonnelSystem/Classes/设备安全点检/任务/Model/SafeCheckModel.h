//
//  SafeCheckModel.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/7.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseModel.h"
#import "SafeCheckListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SafeCheckModel : BaseModel

@property (nonatomic,copy)NSString *MaintSafetySpotCheckTaskId ;

@property (nonatomic,copy)NSString *FacilityId ;

@property (nonatomic,copy)NSString *FacilityCode ;

@property (nonatomic,copy)NSString *FacilityName ;

@property (nonatomic,copy)NSString *IssueTime ;

@property (nonatomic,copy)NSString *Code ;

@property (nonatomic,assign)int Status ;

@property (nonatomic,copy)NSString *Remark ;

@property (nonatomic,copy)NSString *AcceptTime ;

@property (nonatomic,copy)NSString *FinishTime ;

@property (nonatomic,copy)NSString *ReCheckBy ;

@property (nonatomic,copy)NSString *ReCheckOn ;

@property (nonatomic,copy)NSString *statusStr;

@property (nonatomic,strong)NSArray *checkList;

@property (nonatomic,copy)NSString *CheckResult;

@property (nonatomic,copy)NSString *ImplementationPlan;

@property (nonatomic,strong)NSArray *OperateArray;
@end

NS_ASSUME_NONNULL_END

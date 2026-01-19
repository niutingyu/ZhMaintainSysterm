//
//  MTTaskModel.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/19.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MTTaskModel : BaseModel
@property (nonatomic,copy) NSString *LoanReasion; // 申请原因
@property (nonatomic,assign) NSInteger Status;
@property (nonatomic,copy) NSString *DepName;
@property (nonatomic,copy) NSString *FName;
@property (nonatomic,copy) NSString *CreatedOn;
@property (nonatomic,copy) NSString *Id;

@property (nonatomic,copy) NSString *TaskCode;

@property (nonatomic,copy) NSString *LoanTime;
@property (nonatomic,copy) NSString *RevertTime;

@property (nonatomic,copy) NSString *RevertNote; // 归还备注
@property (nonatomic,copy) NSString *LoanRejectNote; // 借用驳回备注
@property (nonatomic,copy) NSString *RevertRejectNote; // 归还驳回备注
@property (nonatomic,copy) NSString *LoanSureNote; // 借用通过备注
@property (nonatomic,copy) NSString *RevertSureNote; // 归还通过备注
@end

NS_ASSUME_NONNULL_END

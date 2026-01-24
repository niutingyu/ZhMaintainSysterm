//
//  SafeCheckUserLogModel.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/24.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SafeCheckUserLogModel : BaseModel

@property (nonatomic,copy)NSString *FName ;
@property (nonatomic,copy)NSString *PassFlag ;
@property (nonatomic,copy)NSString *SignDpart ;
@property (nonatomic,copy)NSString *SignRemark ;
@property (nonatomic,copy)NSString *SignTime ;
@property (nonatomic,copy)NSString *TaskCode ;
@end

NS_ASSUME_NONNULL_END

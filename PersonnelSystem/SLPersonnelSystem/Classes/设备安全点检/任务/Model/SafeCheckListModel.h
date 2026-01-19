//
//  SafeCheckListModel.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/7.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SafeCheckListModel : BaseModel

@property (nonatomic,copy)NSString *CheckTime ;

@property (nonatomic,copy)NSString *CheckValue ;

@property (nonatomic,copy)NSString *MaintSafetySpotCheckTaskId ;

@property (nonatomic,copy)NSString *IsChoice ;
@property (nonatomic,copy)NSString *CheckName;

@end

NS_ASSUME_NONNULL_END

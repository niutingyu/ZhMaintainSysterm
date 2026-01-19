//
//  ToolMaterialModel.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/17.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolMaterialModel : BaseModel


@property (nonatomic, copy) NSString *ToolName;

@property (nonatomic, copy) NSString *ToolCount;

@property (nonatomic, copy) NSString *ToolPCS;

@property (nonatomic,copy)NSString * CustomCount;

@property (nonatomic,copy)NSString *Id;



@end

NS_ASSUME_NONNULL_END

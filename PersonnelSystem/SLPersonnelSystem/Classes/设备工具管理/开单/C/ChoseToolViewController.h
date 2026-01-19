//
//  ChoseToolViewController.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/17.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "DeviceBaseController.h"
#import "ToolMaterialModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChoseToolViewController : DeviceBaseController


@property (nonatomic,copy) void (^multipleChooseBtnClick)(ToolMaterialModel *materialModel);

@end

NS_ASSUME_NONNULL_END

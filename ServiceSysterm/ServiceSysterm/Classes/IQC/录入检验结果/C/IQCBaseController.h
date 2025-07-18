//
//  IQCBaseController.h
//  ServiceSysterm
//
//  Created by Andy on 2021/6/1.
//  Copyright © 2021 SLPCB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IQCBaseController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *datasource;

@end

NS_ASSUME_NONNULL_END

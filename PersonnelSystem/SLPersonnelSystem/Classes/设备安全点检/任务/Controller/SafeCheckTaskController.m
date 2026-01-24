//
//  SafeCheckTaskController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/6.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckTaskController.h"
#import "SafeCheckTaskCell.h"
#import "SafeCheckDetailController.h"
@interface SafeCheckTaskController ()

@end

@implementation SafeCheckTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"任务";
    [self getTaskList];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SafeCheckTaskCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    KWeakSelf
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getTaskList];
    }];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SafeCheckTaskCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    SafeCheckModel *model =self.datasource[indexPath.item];
    [cell configCellWithModel:model count:[NSString stringWithFormat:@"%ld/%ld",indexPath.item+1,(unsigned long)self.datasource.count]];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 104.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SafeCheckModel *model  =self.datasource[indexPath.item];
    SafeCheckDetailController *controller =[SafeCheckDetailController new];
    controller.facilityId =model.MaintSafetySpotCheckTaskId;
    [self.navigationController pushViewController:controller animated:YES];
}
//获取任务
-(void)getTaskList{
    NSString * url =@"maint/maintainsafetyspotcheckrecord/getMyTask";
    NSMutableDictionary *parms  =[NSMutableDictionary dictionary];
    [parms setObject:USERDEFAULT_object(USERID) forKey:@"userId"];
    KWeakSelf
    [HttpTool POST:[url getWholeUrl] param:parms success:^(id  _Nonnull responseObject) {
        if ([[responseObject objectForKey:@"status"]intValue]==0) {
            NSString *dataStr =[responseObject objectForKey:@"data"];
            NSArray *jsonArr =[Units jsonToArray:dataStr];
            NSMutableArray * modelArr =[SafeCheckModel mj_objectArrayWithKeyValuesArray:jsonArr];
            [weakSelf.datasource removeAllObjects];
            [weakSelf.datasource addObjectsFromArray:modelArr];
            
        }
        [weakSelf.tableView .mj_header endRefreshing];
        [weakSelf.tableView reloadData];
        debugLog(@" == %@",responseObject);
    } error:^(NSString * _Nonnull error) {
        [weakSelf.tableView .mj_header endRefreshing];
    }];
    
}

@end

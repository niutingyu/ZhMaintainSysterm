//
//  SafeCheckUnFinishController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/6.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckUnFinishController.h"
#import "SafeCheckModel.h"
#import "SafeCheckTaskCell.h"
#import "SafeCheckDetailController.h"
@interface SafeCheckUnFinishController ()

@end

@implementation SafeCheckUnFinishController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"未完成";
    [self getWorkoutList];
    self.view.backgroundColor  =[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"SafeCheckTaskCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    KWeakSelf
    self.tableView.mj_header  =[MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf getWorkoutList];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SafeCheckTaskCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
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

-(void)getWorkoutList{
    NSString *url =@"maint/maintainsafetyspotcheckrecord/applyLists";
    NSMutableDictionary *parms  =[NSMutableDictionary dictionary];
    [parms setObject:USERDEFAULT_object(USERID) forKey:@"UserId"];
    [parms setObject:@"2" forKey:@"ListType"];
    [parms setObject:@"" forKey:@"StartTime"];
    [parms setObject:@"" forKey:@"EndTime"];
    KWeakSelf
    [Units showLoadStatusWithString:@"加载中..."];
    [HttpTool POST:[url getWholeUrl] param:parms success:^(id  _Nonnull responseObject) {
        [Units hideView];
        if ([[responseObject objectForKey:@"status"]intValue]==0) {
            
            NSArray *jsonArr  =[Units jsonToArray:responseObject[@"data"]];
            NSMutableArray *modelArr =[SafeCheckModel mj_objectArrayWithKeyValuesArray:jsonArr];
            [weakSelf.datasource removeAllObjects];
            [weakSelf.datasource addObjectsFromArray:modelArr];
            
        }
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } error:^(NSString * _Nonnull error) {
        [Units hideView];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
    
}
@end

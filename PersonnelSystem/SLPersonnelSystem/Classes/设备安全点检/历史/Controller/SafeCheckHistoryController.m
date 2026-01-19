//
//  SafeCheckHistoryController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/6.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckHistoryController.h"
#import "SafeCheckModel.h"
#import "SafeCheckTaskCell.h"
#import "SafeCheckDetailController.h"
#import "DEChosConditonController.h"
@interface SafeCheckHistoryController ()

@property (nonatomic,strong)NSMutableDictionary * mutaleParms;

@end

@implementation SafeCheckHistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"历史";
    [self getHistoryList];
    
    self.view.backgroundColor  =[UIColor whiteColor];
    
    UIButton * btn1  =[UIButton buttonWithType:UIButtonTypeCustom];
    btn1.titleLabel.font  =[UIFont systemFontOfSize:15];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"筛选" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(filter) forControlEvents:UIControlEventTouchUpInside];
        
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"SafeCheckTaskCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:self.tableView];
    
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

-(void)filter{
    DEChosConditonController * controller =[DEChosConditonController new];
    [self.navigationController pushViewController:controller animated:YES];
    KWeakSelf
    controller.passItemBlock = ^(FilterModel * _Nonnull filterModel) {
    };
}

-(void)getHistoryList{
    NSString *url =@"maint/maintainsafetyspotcheckrecord/applyLists";
    NSMutableDictionary *parms  =[NSMutableDictionary dictionary];
    [parms setObject:@"1" forKey:@"FacilityId"];
    [parms setObject:@"1" forKey:@"TaskCode"];
    [parms setObject:@"2022-08-10 00:00:00" forKey:@"StartTime"];
    [parms setObject:@"2022-12-21 00:00:00"  forKey:@"EndTime"];
    [parms setObject:USERDEFAULT_object(USERID) forKey:@"UserId"];
    [parms setObject:@"1" forKey:@"ListType"];

    [parms setObject:@"1" forKey:@"MaintainDistrictId"];
   
   
    
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
        debugLog(@" == %@",responseObject);
        [weakSelf.tableView reloadData];
    } error:^(NSString * _Nonnull error) {
        [Units hideView];
    }];
}

-(NSMutableDictionary*)mutaleParms{
    if (!_mutaleParms) {
        _mutaleParms =[NSMutableDictionary dictionary];
    }
    return _mutaleParms;
}

@end

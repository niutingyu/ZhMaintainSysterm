//
//  MTToolTaskController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/10.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "MTToolTaskController.h"
#import "MTTaskTableCell.h"
#import "MTTaskModel.h"
@interface MTToolTaskController ()

@end

@implementation MTToolTaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self getupData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MTTaskTableCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CYFMeetListViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MTTaskTableCell" owner:nil options:nil]firstObject];
    }
    
    MTTaskModel *model = self.datasource[indexPath.section];
    cell.reasonLab.text = model.LoanReasion;
   // cell.depLab.text = [NSString stringWithFormat:@"申请部门:%@",model.DepName];
    cell.dateLab.text = [Units dataFromString:model.CreatedOn withFormat:@"yy"];
    cell.codeLab.text = [NSString stringWithFormat:@"单号:%@",model.TaskCode];
    
    NSString *StatusStr =@"";
    if (model.Status == 0) {StatusStr = @"借出待确认";}
    if (model.Status == 1) {StatusStr = @"归还待确认";}
    if (model.Status == 5) {StatusStr = @"驳回待修改";}
    cell.statusLab.text = StatusStr;
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    MTToolsTaskModel *model = self.dataArray[indexPath.section];
//    MTTDetailViewController *vc =[MTTDetailViewController new];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.maintainId = model.Id;
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view =[[UIView alloc]init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view =[[UIView alloc]init];
    return view;
}

- (void)getupData {
    NSString *urlStr=@"it/MaintainEvent/findMyTask";
    // 1.只会有我的任务
    // 借用人 借用时间 单状态 借用备注 借用工具几种
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [params setObject:USERDEFAULT_object(USERID) forKey:@"UserId"];
    [params setObject:@"1" forKey:@"CYFModuleType"];

    [Units showLoadStatusWithString:@"加载中!!!"];
    KWeakSelf
    [HttpTool POST:[urlStr getWholeUrl] param:params success:^(id  _Nonnull responseObject) {
        [Units hideView];
        if ([responseObject[@"status"] boolValue] == NO) {
          self.datasource =[MTTaskModel mj_objectArrayWithKeyValuesArray:[Units jsonToArray:responseObject[@"data"]]];
            [weakSelf.tableView reloadData];
        }
    } error:^(NSString * _Nonnull error) {
        [Units hideView];
    }];
    
}
@end

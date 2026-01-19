//
//  SafeCheckDetailController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/7.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckDetailController.h"
#import "SafeCheckModel.h"
#import "SafeCheckTaskCell.h"
#import "SafeCheckListModel.h"
#import "SafeTableHeadView.h"
#import "YBPopupMenu.h"
@interface SafeCheckDetailController ()<YBPopupMenuDelegate>


@property (nonatomic,strong)NSMutableArray * operationArray;

@end

@implementation SafeCheckDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =[UIColor whiteColor];
    self.title =@"详情";
    [self getDetailList];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight =48.0f;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 2;
    }else if (section ==1){
        SafeCheckModel *model  = [self.datasource firstObject ];
        return  model.checkList.count;
    }else{
        return 2;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell ==nil) {
        cell  =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    
    cell.textLabel.font  =[UIFont systemFontOfSize:15];
    SafeCheckModel * model  =self.datasource.firstObject;
    
    if (indexPath.section ==0) {
        NSString * facilityName  =[NSString stringWithFormat:@"设备名称:%@",model.FacilityName?:@""];
        NSString *code  =[NSString stringWithFormat:@"设备编号:%@",model.FacilityCode?:@""];
        NSArray * titles  =@[facilityName,code];
        cell.textLabel.text =titles[indexPath.item];
    }else if (indexPath.section ==1){
        NSArray * list  = model.checkList;
        SafeCheckListModel * listModel  = list[indexPath.item];
        cell.textLabel.text  =listModel.CheckName;
    }else{
        NSArray *titles  =@[[NSString stringWithFormat:@"检查结果:%@",model.CheckResult?:@""],[NSString stringWithFormat:@"实施方案:%@",model.ImplementationPlan?:@""]];
        cell.textLabel.text =titles[indexPath.item];
    }
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SafeTableHeadView * headV =[[SafeTableHeadView alloc]init];
    NSArray *titles =@[@"基础信息",@"点检信息",@"点检结果"];
    headV.titleStr  =titles[section];
    return headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 48.0f;
}

-(void)getDetailList{
    NSString *url =@"maint/maintainsafetyspotcheckrecord/getDetail";
    NSMutableDictionary *parms =[NSMutableDictionary dictionary];
    [parms setObject:self.facilityId forKey:@"maintSafetySpotCheckTaskId"];
    [parms setObject:USERDEFAULT_object(USERID) forKey:@"userId"];
    KWeakSelf
    [Units showLoadStatusWithString:@"加载中..."];
    [HttpTool POST:[url getWholeUrl] param:parms success:^(id  _Nonnull responseObject) {
        [Units hideView];
        if ([[responseObject objectForKey:@"status"]intValue]==0) {
            NSDictionary *dict  =[Units stringToDictionary:responseObject[@"data"]];
            SafeCheckModel *model  = [SafeCheckModel mj_objectWithKeyValues:dict];
            [weakSelf.datasource removeAllObjects];
            [weakSelf.datasource addObject:model];
            //设置操作按钮
            if (model.OperateArray.count >0 && model.OperateArray) {
                [self setupBarItem];
            }else{
                self.navigationItem.rightBarButtonItem =nil;
            }
            
        }
        [weakSelf.tableView reloadData];
    } error:^(NSString * _Nonnull error) {
        [Units hideView];
    }];
    
    
}

-(void)setupBarItem{
    UIButton *rightButton =[UIButton buttonWithType:UIButtonTypeSystem];
    [rightButton setTitle:@"操作" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(onRightButtonItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = right;
}
- (void)onRightButtonItemClick:(UIButton *)sender{
    SafeCheckModel *model  =self.datasource .firstObject;
    if (!self.operationArray) {
        self.operationArray  =[NSMutableArray array];
    }
    [self.operationArray removeAllObjects];
    for (NSDictionary *dict in model.OperateArray) {
        NSString *str  = [dict objectForKey:@"PassFlag"];
        NSString * titleName;
        if ([str isEqualToString:@"1"]) {
            titleName =@"接单";
        }else if ([str isEqualToString:@"2"]){
            titleName =@"抽查通过";
        }else if ([str isEqualToString:@"3"]){
            titleName =@"抽查退回";
        }else{
            titleName =@"点检完成";
        }
        [self.operationArray addObject:titleName];
    }
    [YBPopupMenu showRelyOnView:sender  titles:self.operationArray icons:nil menuWidth:140 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = NO;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.offset = 10;
        popupMenu.type = YBPopupMenuTypeDark;
        popupMenu.backColor = [UIColor whiteColor];
        popupMenu.textColor = [UIColor blackColor];
        popupMenu.maxVisibleCount =10;
        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }];
    
}
-(void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    [ybPopupMenu dismiss];
    SafeCheckModel *model  =[self.datasource firstObject];
    NSString *url =@"maint/maintainsafetyspotcheckrecord/receive";
    NSString *name  =self.operationArray[index];
    NSMutableDictionary *parms  =[NSMutableDictionary dictionary];
    if ([name isEqualToString:@"接单"]) {
        [parms setObject:@"1" forKey:@"type"];
    }else if ([name isEqualToString:@"抽查通过"]){
        [parms setObject:@"2" forKey:@"type"];
    }else if ([name isEqualToString:@"抽查退回"]){
        [parms setObject:@"3" forKey:@"type"];
    }
    UIAlertController *controller  =[UIAlertController alertControllerWithTitle:@"提示" message:@"请填写备注" preferredStyle:UIAlertControllerStyleAlert];
    [controller addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    KWeakSelf
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textf = controller.textFields.firstObject;
        if (textf.text.length ==0) {
            [Units showErrorStatusWithString:@"备注必填!"];
            return;
            
        }
        [parms setObject:textf.text forKey:@"remark"];
        [parms setObject:model.MaintSafetySpotCheckTaskId forKey:@"MaintSafetySpotCheckTaskId"];
        [Units showLoadStatusWithString:@"提交中..."];
        [HttpTool POST:[url getWholeUrl] param:parms success:^(id  _Nonnull responseObject) {
            [Units hideView];
            [Units showStatusWithStutas:responseObject[@"info"]];
            if ([[responseObject objectForKey:@"status"]intValue]==0) {
               
                [weakSelf getDetailList];
            }
        } error:^(NSString * _Nonnull error) {
            [Units hideView];
            [Units showErrorStatusWithString:error];
        }];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:controller animated:YES completion:nil];
    
}

@end

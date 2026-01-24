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
#import "SafeCheckChoseTableCell.h"
#import "SafeCheckTextTableCell.h"
#import "SafeCheckResultTableCell.h"
#import "SafeCheckLogTableCell.h"
@interface SafeCheckDetailController ()<YBPopupMenuDelegate>


@property (nonatomic,strong)NSMutableArray * operationArray;

@property (nonatomic,copy)NSString *isEdit;

@end

@implementation SafeCheckDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =[UIColor whiteColor];
    self.title =@"详情";
    [self getDetailList];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight =48.0f;
    [self.tableView registerNib:[UINib nibWithNibName:@"SafeCheckChoseTableCell" bundle:nil] forCellReuseIdentifier:@"ChoseTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SafeCheckTextTableCell" bundle:nil] forCellReuseIdentifier:@"TextTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SafeCheckResultTableCell" bundle:nil] forCellReuseIdentifier:@"ResultTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SafeCheckLogTableCell" bundle:nil] forCellReuseIdentifier:@"LogTableCell"];
    KWeakSelf
    self.tableView.mj_header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getDetailList];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    SafeCheckModel *model  = [self.datasource firstObject ];
    if (section ==0) {
        if(model.AcceptTime.length ==0){
            return 3;
        }else{
            return 4;
        }
        
    }else if (section ==1){
        
        return  model.checkList.count;
    }else if(section ==2){
        return 2;
    }else{
        SafeCheckModel *model  = [self.datasource firstObject ];
        return model.UserOperateArray.count;
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
        NSString *status =[NSString stringWithFormat:@"单状态:%@",model.statusStr];
        NSArray * titles  ;
        if(model.AcceptTime.length >0){
            NSString *time =[NSString stringWithFormat:@"接单时间:%@(%@)",model.AcceptTime,model.AcceptUserName];
            titles  =@[facilityName,code,status,time];
        }else{
           titles  =@[facilityName,code,status];
        }
       
        
       
        cell.textLabel.text =titles[indexPath.item];
    }else if (indexPath.section ==1){
        NSArray * list  = model.checkList;
       
        SafeCheckListModel * listModel  = list[indexPath.item];
        if([listModel.IsChoice isEqualToString:@"1"]){
            SafeCheckChoseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChoseTableCell"];
            cell.titleLab.text  =listModel.CheckName;
            cell.model =listModel;
            cell.auditTypeString =self.isEdit;
            return cell;
        }else{
            SafeCheckTextTableCell *cell =[tableView dequeueReusableCellWithIdentifier:@"TextTableCell"];
            cell.titleLab.text  =listModel.CheckName;
            cell.txtF.text = listModel.CheckValue?:@"";
            cell.model =listModel;
            cell.auditTypeString =self.isEdit;
            return cell;
        }
        
    }else if(indexPath.section ==2){
        SafeCheckResultTableCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ResultTableCell"];
        NSArray *titles  =@[@"点检结果:",@"实施方案:"];
        cell.cellTag=indexPath.row;
        cell.model =model;
        cell.titleLab.text =titles[indexPath.item];
        NSArray *contents =@[model.CheckResult?:@"",model.ImplementationPlan?:@""];
        cell.txtF.text =contents[indexPath.row];
        cell.auditTypeString =self.isEdit;
        return cell;

    }else{
        SafeCheckLogTableCell *cell =[tableView dequeueReusableCellWithIdentifier:@"LogTableCell"];
        NSArray *array = model.UserOperateArray;
        SafeCheckUserLogModel *model = array[indexPath.row];
        cell.infoLab.text =[NSString stringWithFormat:@"操作信息:%@(%@)",model.PassFlag,model.FName];
        cell.timeLab.text =[NSString stringWithFormat:@"操作时间:%@",model.SignTime];
        cell.remarkLab.text =[NSString stringWithFormat:@"操作备注:%@",model.SignRemark?:@""];
        
        
        return cell;
    }
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SafeTableHeadView * headV =[[SafeTableHeadView alloc]init];
    NSArray *titles =@[@"基础信息",@"点检信息(滑块灰色含义为不合格)",@"点检结果",@"操作日志"];
    headV.titleStr  =titles[section];
    return headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 48.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==3){
        return 98.f;
    }else{
        return 48.0f;
    }
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
        debugLog(@"res %@",responseObject);
        if ([[responseObject objectForKey:@"status"]intValue]==0) {
            NSDictionary *dict  =[Units stringToDictionary:responseObject[@"data"]];
            SafeCheckModel *model  = [SafeCheckModel mj_objectWithKeyValues:dict];
            [weakSelf.datasource removeAllObjects];
            [weakSelf.datasource addObject:model];
            //设置操作按钮
            if (model.OperateArray.count >0 && model.OperateArray) {
                for (NSDictionary *dict in model.OperateArray) {
                    if([[dict objectForKey:@"PassFlag"] isEqualToString:@"4"] ){
                        self.isEdit =@"编辑";
                    }
                }
                [self setupBarItem];
            }else{
                self.navigationItem.rightBarButtonItem =nil;
            }
            
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    } error:^(NSString * _Nonnull error) {
        
        [Units hideView];
        [weakSelf.tableView.mj_header endRefreshing];
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
    }else if ([name isEqualToString:@"复核"]){
        [parms setObject:@"6" forKey:@"type"];
    }else if ([name isEqualToString:@"点检完成"]){
        [self.view endEditing:YES];
        KWeakSelf
        UIAlertController *controller  =[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要提交吗,请确认点检结果(滑动开关灰色为不合格)?" preferredStyle:UIAlertControllerStyleAlert ];
        [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SafeCheckModel * model  =self.datasource.firstObject;
            NSArray * list  = model.checkList;
            for (SafeCheckListModel *model in list) {
                if(model.CheckValue.length ==0){
                    [Units showErrorStatusWithString:@"请点检完在提交!!!"];
                    return;
                }
            }
            if(model.CheckResult.length ==0){
                [Units showErrorStatusWithString:@"请填写点检结果!!!"];
                return;
            }
            
            NSString *url =@"maint/maintainsafetyspotcheckrecord/saveRecord";
            NSMutableDictionary *parms =[NSMutableDictionary dictionary];
            [parms setObject:model.CheckResult forKey:@"checkResult"];
            [parms setObject:model.ImplementationPlan?model.ImplementationPlan:@"" forKey:@"implementationPlan"];
            
            for (SafeCheckListModel *model in list) {
                model.MaintSafetySpotCheckTaskId =self.facilityId;
            }
            
            NSArray *dictArray =[SafeCheckListModel mj_keyValuesArrayWithObjectArray:list];

            NSString *json = [dictArray mj_JSONString];
  
            [parms setObject:json forKey:@"modelList"];
            [HttpTool POST:[url getWholeUrl] param:parms success:^(id  _Nonnull responseObject) {
                debugLog(@"1111%@",responseObject);
                [Units showStatusWithStutas:responseObject[@"info"]];
                if ([responseObject[@"status"]integerValue]==0) {
                    [weakSelf.tableView.mj_header beginRefreshing];
                }

            } error:^(NSString * _Nonnull error) {
                [Units hideView];
            }];
           
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:controller animated:YES completion:nil];
        return;
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

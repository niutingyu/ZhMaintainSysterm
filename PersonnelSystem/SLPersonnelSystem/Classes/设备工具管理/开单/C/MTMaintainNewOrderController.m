//
//  MTMaintainNewOrderController.m
//  ServiceSysterm
//
//  Created by Andy on 2019/5/29.
//  Copyright © 2019 SLPCB. All rights reserved.
//

#import "MTMaintainNewOrderController.h"
#import "MTToolCell.h"
#import "MTToolTypeTableCell.h"
#import "MTFootAddView.h"
#import "ChoseToolViewController.h"
#import "BaseNavViewController.h"

@interface MTMaintainNewOrderController ()<UITextViewDelegate>
{
    NSInteger _addSection;
    NSMutableArray * _sectionArray;
    
}

@property (nonatomic,copy)NSString *reasonString;
@end

@implementation MTMaintainNewOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"开单";
    _sectionArray = [NSMutableArray array];
    [_sectionArray addObject:@"维修工具"];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBA(242, 242, 242, 1);
    self.tableView.rowHeight = 50.0f;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MTToolTypeTableCell" bundle:nil] forCellReuseIdentifier:@"typeReusedId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MTToolCell" bundle:nil] forCellReuseIdentifier:@"orderReusedId"];
    
    UIBarButtonItem *sureButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(onOKClick)];
    self.navigationItem.rightBarButtonItem = sureButton;
  
  
    
    
   
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.datasource.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120.0f;
    }else{
        return 48.0f;
    }
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 2.0f;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section ==0) {
        return nil;
    }else{
        UIView * footView =[UIView new];
        footView.bounds = CGRectMake(0, 0, kScreenWidth, 40);
        MTFootAddView * addView = [[NSBundle mainBundle]loadNibNamed:@"MTFootAddView" owner:self options:nil].firstObject;
        [footView addSubview:addView];
        KWeakSelf
        addView.addMaterialBlock = ^{

            ChoseToolViewController *controller =[[ChoseToolViewController alloc]init];
            BaseNavViewController *nav = [[BaseNavViewController alloc]initWithRootViewController:controller];
           
            [self presentViewController:nav animated:YES completion:nil];
            [controller setMultipleChooseBtnClick:^(ToolMaterialModel * _Nonnull materialModel) {
               
                for (ToolMaterialModel *m in weakSelf.datasource) {
                    if([m.ToolName isEqualToString:materialModel.ToolName]){
                        [Units showErrorStatusWithString:@"选择的物料已在列表中"];
                        return;
                    }
                }
                materialModel.CustomCount =@"1";
                [weakSelf.datasource addObject:materialModel];
                
                [weakSelf.tableView reloadData];

            }];
            
        };
        return footView;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }else{
      return 48.0f;
    }
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        MTToolCell * cell = [tableView dequeueReusableCellWithIdentifier:@"orderReusedId"];
        
        
        
        cell.lalLab.text =[NSString stringWithFormat:@"申请人:%@",USERDEFAULT_object(CodeName)];
        self.reasonString =cell.tfValue.text;
        return cell;
    }else{
        MTToolTypeTableCell * cell =[tableView dequeueReusableCellWithIdentifier:@"typeReusedId"];
        ToolMaterialModel *model = self.datasource[indexPath.row];
        [cell setupCellWithModel:model];
        cell.materialModel =model;
        return cell;
    }
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        return YES;
    }return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        [self.datasource removeObjectAtIndex:indexPath.row];
        if(self.datasource.count ==0){
            [self.tableView reloadData];
        }else{
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }
       
    }
}

-(void)onOKClick{
    [self.view endEditing:YES];
    if(self.datasource.count ==0){
        [Units showErrorStatusWithString:@"借用工具不能为空!"];
        return;
    }
    
    
    if(self.reasonString.length ==0){
        [Units showErrorStatusWithString:@"借用原因不能为空!"];
        return;
    }
    
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    NSMutableDictionary *dict =[NSMutableDictionary dictionary];
    
    [dict setObject:USERDEFAULT_object(USERID) forKey:@"LoanBy"]; //借用人
    [dict setObject:self.reasonString forKey:@"LoanReasion"]; // 借用原因
    [dict setObject:@"0" forKey:@"Status"]; // 单状态 --> 待借
    NSMutableArray *toolsArray =[NSMutableArray array];
    for (ToolMaterialModel *materialModel in self.datasource) {
        NSMutableDictionary *toolsDict =[NSMutableDictionary dictionary];
        [toolsDict setObject:materialModel.Id forKey:@"ToolsId"];//
        if(materialModel.ToolCount==NULL||materialModel.ToolCount ==nil){
            materialModel.ToolCount =@"1";
        }
        [toolsDict setObject:materialModel.ToolCount forKey:@"ToolsCount"]; // 工具数
        [toolsArray addObject:toolsDict];
    }
    [params setObject:[Units dictionaryToJson:dict] forKey:@"model"];
    [params setObject:[Units arrayToJson:toolsArray] forKey:@"toolsArray"];
    NSString * url =@"it/MaintainEvent/createSave";
    [Units showLoadStatusWithString:@"加载中!!!"];
    [HttpTool POST:[url getWholeUrl] param:params success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"status"] boolValue] == NO) {
            [Units showStatusWithStutas:responseObject[@"info"]];
            [self.datasource removeAllObjects];
            self.reasonString =@"";
            
        }else {
            [Units showErrorStatusWithString:responseObject[@"info"]];
        }
    } error:^(NSString * _Nonnull error) {
        [Units hideView];
    }];
}

@end

//
//  SafeCheckMenuController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/16.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "SafeCheckMenuController.h"

#import "UIImage+ChangeColor.h"
#import "SafeCheckTaskController.h"
#import "SafeCheckHistoryController.h"
#import "SafeCheckUnFinishController.h"
@interface SafeCheckMenuController ()

@end

@implementation SafeCheckMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"设备安全点检";
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    self.tableView.rowHeight = 50.0f;
    NSArray *titles =@[@"任务",@"未完成",@"历史"];
    [self.datasource addObjectsFromArray:titles];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    NSArray * images = @[@"chaxun",@"zonghekaidan",@"gougao-h"];
    UIImage * realImage = [UIImage imageNamed:images[indexPath.row]];
    cell.imageView.image = [realImage imageChangeColor:RGBA(0, 106, 255, 1)];
    
    
   
    cell.textLabel.text = self.datasource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * tipStrig = self.datasource[indexPath.row];
    UIViewController * controller;
    if ([tipStrig isEqualToString:@"任务"]) {
        controller =[[SafeCheckTaskController alloc]init];
        
    }else if ([tipStrig isEqualToString:@"未完成"]){
        controller =[[SafeCheckUnFinishController alloc]init];
    }else if ([tipStrig isEqualToString:@"历史"]){
        controller =[[SafeCheckHistoryController alloc]init];
    }
    
    [self.navigationController pushViewController:controller animated:YES];
    
}


@end

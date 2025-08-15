//
//  AlertView.m
//  ServiceSysterm
//
//  Created by Andy on 2019/8/3.
//  Copyright © 2019 SLPCB. All rights reserved.
//

#import "AlertView.h"

#import "AssetConst.h"
#import "DESearchView.h"
#import "ToolBar.h"


@interface AlertView()<UITableViewDelegate,UITableViewDataSource>{
    NSString *_condition;
}

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSArray * datasource;
@property (nonatomic,strong)ToolBar * tool;

@property (nonatomic,strong)NSMutableArray *filterMutableArray;

@property (nonatomic,strong)NSArray * filterArray;

@end
@implementation AlertView


+(void)showAlertWithDatasource:(NSArray*)datasource maintainId:(selectedMaintainId)maintainId{
    AlertView * alertView = [[AlertView alloc]initWithDatasource:datasource maintainId:maintainId];
    [[UIApplication sharedApplication].delegate.window addSubview:alertView];
}

-(instancetype)initWithDatasource:(NSArray*)datasource maintainId:(selectedMaintainId)maintainId{
    if (self = [super init]) {
        [self setupUI];
        self.datasource = datasource;
        self.filterArray = datasource;
        _maintainIdBlock =maintainId;
    }
    return self;
}

-(void)setupUI{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeText:) name:UITextFieldTextDidChangeNotification object:nil];
    
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3/1.0];
    //bgView最大高度
    CGFloat maxHeight = DEFAULT_MAX_HEIGHT;
    
    
    //backgroundView
    
    UIView *bgView = [[UIView alloc]init];
    bgView.center = self.center;
    bgView.bounds = CGRectMake(0, 0, self.frame.size.width - Ratio(40), maxHeight+Ratio(18));
    [self addSubview:bgView];
    
    
    //添加更新提示
    UIView *updateView = [[UIView alloc]init];
    updateView.frame = CGRectMake(Ratio(20), Ratio(18), bgView.frame.size.width -Ratio(40), maxHeight);
    updateView.backgroundColor = [UIColor whiteColor];
    updateView.layer.masksToBounds = YES;
    updateView.layer.cornerRadius = 4.0f;
    [bgView addSubview:updateView];
    
    //取消
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    
    cancelButton.center = CGPointMake(CGRectGetMaxX(updateView.frame)-Ratio(10), CGRectGetMinY(updateView.frame)+Ratio(10));
    cancelButton.bounds = CGRectMake(0, 0, Ratio(36), 36);
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cancelButton];
    //标题
    UILabel *titleLab = [UILabel new];
    titleLab.frame = CGRectMake(0, 10, updateView.frame.size.width, 18);
    titleLab.text = @"请选择故障类型";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:17];
    [updateView addSubview:titleLab];
    
    DESearchView * searchView = [[NSBundle mainBundle]loadNibNamed:@"DESearchView" owner:self options:nil].firstObject;
    searchView.frame = CGRectMake(0, 30, updateView.frame.size.width, 48);
    
    searchView.searchContentTextField.inputAccessoryView =self.tool;
    
    [updateView addSubview:searchView];
    
    KWeakSelf
    searchView.searchBlock = ^{
       [weakSelf.filterMutableArray removeAllObjects];
       
        
        if (self->_condition.length == 0) {
            weakSelf.filterArray = weakSelf.datasource;
            [weakSelf.tableView reloadData];
            return ;
        }
        [weakSelf endEditing:YES];
        for (NSDictionary * model in weakSelf.datasource) {
            NSString * name =model[@"MaintainFaultName"];
            
      
           
            NSRange range = [name rangeOfString:self->_condition options:NSCaseInsensitiveSearch];
            if (range.location !=NSNotFound) {
               
                [weakSelf.filterMutableArray addObject:model];
                
            }
        }
        weakSelf.filterArray =[weakSelf.filterMutableArray copy];
        [weakSelf.tableView reloadData];
       
    };
    [self showWithAlert:bgView];
    
    //tableview
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(searchView.frame)+6, updateView.frame.size.width, updateView.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 50;
        [updateView addSubview:_tableView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    cell.textLabel.text = self.filterArray[indexPath.row][@"MaintainFaultName"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * maintainId = self.filterArray[indexPath.row][@"MaintainFaultId"];//id
    NSString * name = self.filterArray[indexPath.row][@"MaintainFaultName"];
    if (self.maintainIdBlock) {
        self.maintainIdBlock(maintainId, name);
    }
    [self dismissAlert];
    
}
- (void)showWithAlert:(UIView*)alert{
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = SELAnimationTimeInterval;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    //  [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [alert.layer addAnimation:animation forKey:nil];
}


/** 添加Alert出场动画 */
- (void)dismissAlert{
    
    [UIView animateWithDuration:SELAnimationTimeInterval animations:^{
        self.transform = (CGAffineTransformMakeScale(1.5, 1.5));
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    } ];
    
}

-(void)changeText:(NSNotification*)notification{
    UITextField * textField = [notification object];
    _condition = textField.text;
    
}

-(void)cancel{
    [self dismissAlert];
}

- (ToolBar *)tool{
    if (!_tool) {
        _tool = [ToolBar toolBar];
        
        __weak typeof(self) weakself = self;
        _tool.finishBlock = ^(){
            [weakself endEditing:YES];
        };
    }
    return _tool;
}

-(NSMutableArray*)filterMutableArray{
    if (!_filterMutableArray) {
        _filterMutableArray  =[NSMutableArray array];
    }return _filterMutableArray;
}



@end

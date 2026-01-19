//
//  ChoseToolViewController.m
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/17.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import "ChoseToolViewController.h"

#import "DESearchView.h"
@interface ChoseToolViewController ()<UITextFieldDelegate>{
    NSString *_condition;
}

@property (nonatomic,strong)NSMutableArray *filterMutableArray;

@end

@implementation ChoseToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    DESearchView * searchView = [[NSBundle mainBundle]loadNibNamed:@"DESearchView" owner:self options:nil].firstObject;
    searchView.searchContentTextField.inputAccessoryView =self.tool;
    searchView.searchContentTextField.delegate =self;
    [self.view addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(50);
        make.bottom.mas_offset(0);
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeText:) name:UITextFieldTextDidChangeNotification object:nil];
    KWeakSelf
    //查询
    searchView.searchBlock = ^{
       [weakSelf.filterMutableArray removeAllObjects];
       
        
        if (self->_condition.length == 0) {
            [weakSelf.filterMutableArray addObjectsFromArray:weakSelf.datasource];
            [weakSelf.tableView reloadData];
            return;
        }
        [weakSelf.view endEditing:YES];
        for (ToolMaterialModel * model in weakSelf.datasource) {
            NSString * name =model.ToolName;

            NSRange range = [name rangeOfString:self->_condition options:NSCaseInsensitiveSearch];
            if (range.location !=NSNotFound) {
            
                [weakSelf.filterMutableArray addObject:model];
            }
        }
        [weakSelf.tableView reloadData];
       
    };
   
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
   
}

-(void)changeText:(NSNotification*)notification{
    UITextField * textField = [notification object];
    _condition = textField.text;
    if(_condition.length>0){
        [self.filterMutableArray removeAllObjects];
        for (ToolMaterialModel * model in self.datasource) {
            NSString * name =model.ToolName;

            NSRange range = [name rangeOfString:self->_condition options:NSCaseInsensitiveSearch];
            if (range.location !=NSNotFound) {
            
                [self.filterMutableArray addObject:model];
            }
        }
    }else{
        [self.filterMutableArray removeAllObjects];
        [self.filterMutableArray addObjectsFromArray:self.datasource];
    }

    [self.tableView reloadData];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filterMutableArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    ToolMaterialModel *model = self.filterMutableArray[indexPath.row];
    
    cell.textLabel.text =[NSString stringWithFormat:@"%@(%@%@)",model.ToolName,model.ToolCount,model.ToolPCS];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ToolMaterialModel *model =self.filterMutableArray[indexPath.row];
    
    KWeakSelf
    [self dismissViewControllerAnimated:YES completion:^{
        if(weakSelf.multipleChooseBtnClick){
            weakSelf.multipleChooseBtnClick(model);
        }
    }];
   
}

-(void)getData{
    [self.datasource removeAllObjects];
    [self.filterMutableArray removeAllObjects];
    NSString *url =@"it/MaintainTools/findAllTools";
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    [Units showLoadStatusWithString:@"加载中..."];
    KWeakSelf
    [HttpTool POST:[url getWholeUrl] param:params success:^(id  _Nonnull responseObject) {
        [Units hideView];
        if ([[responseObject objectForKey:@"status"]intValue]==0) {
            NSString *dataStr =[responseObject objectForKey:@"data"];
            NSArray *jsonArr =[Units jsonToArray:dataStr];
            NSMutableArray * modelArr =[ToolMaterialModel mj_objectArrayWithKeyValuesArray:jsonArr];
            [weakSelf.datasource removeAllObjects];
            [weakSelf.datasource addObjectsFromArray:modelArr];
            [weakSelf.filterMutableArray addObjectsFromArray:modelArr];
            [weakSelf.tableView reloadData];
        }
    } error:^(NSString * _Nonnull error) {
        
    }];
}

-(NSMutableArray*)filterMutableArray{
    if (!_filterMutableArray) {
        _filterMutableArray  =[NSMutableArray array];
    
    }return _filterMutableArray;
}

@end

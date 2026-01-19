//
//  MultipleChooseView.h
//  SLPersonnelSystem
//
//  Created by Andy on 2026/1/16.
//  Copyright © 2026 SLPCB. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultipleChooseView : UIView
@property (nonatomic,strong) NSArray *mainArray;
@property (nonatomic,strong) NSMutableArray *selectedArray;

@property (nonatomic,strong) NSString *testType;
@property (nonatomic,strong) NSString *keyWord;

- (void)show;
- (void)TabViewreloadData;

@property (nonatomic,copy) void (^multipleChooseBtnClick)(NSMutableArray *array,NSArray *nowDataArray);
@property (nonatomic,strong) NSString *isSureClickCancel;
@end

NS_ASSUME_NONNULL_END

//
//  CXViewController2.m
//  CXKit_Example
//
//  Created by hntnet on 2021/12/17.
//  Copyright © 2021 hntnet. All rights reserved.
//

#import "CXViewController2.h"
#import "CXViewHeader.h"
@interface CXViewController2 ()<CXPhotoPickerDelegate>


@property (nonatomic ,strong)   CXPhotoPicker *picker;
@end

@implementation CXViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = CXWhiteColor;
    
    CXPhotoPickerModel *param = [[CXPhotoPickerModel alloc]init];
    param.maxNum = 3;
    param.columnNum  = 3;
    
    CXPhotoPicker *picker = [[CXPhotoPicker alloc]initWithFrame:CGRectMake(0, 0, CXScreenWidth, 300)];
    self.picker = picker;
    picker.backgroundColor = CXRedColor;
    picker.delegate = self;
    picker.model = param;
    
    
    [self.view addSubview:picker];
}


-(void)pickerView:(CXPhotoPicker *)pickerView andHeight:(CGFloat)height{
    self.picker.frame =CGRectMake(0, 100, CXScreenWidth, height);
    
  
}




@end

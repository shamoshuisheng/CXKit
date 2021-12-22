//
//  CXViewController.m
//  CXKit
//
//  Created by hntnet on 12/15/2021.
//  Copyright (c) 2021 hntnet. All rights reserved.
//

#import "CXViewController.h"
#import "CXKitHeader.h"
#import "CXTableViewCell.h"
#import "CXViewController2.h"
@interface CXViewController ()<CXTableViewDelegate>

@property (nonatomic ,strong) CXTableView *tableView;
@property (nonatomic ,strong) CXTableViewModel *param;

@end

@implementation CXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = CXWhiteColor;
    NSArray *arr = [self loadData];
    self.param =
    CXTableParam()
    .cellNameArraySet(@[@"CXTableViewCell"])
    .tableCellCallBlockSet(^UITableViewCell *(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
            CXTableViewCell *cell = (CXTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CXTableViewCell"];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([cell class]) owner:self options:nil].firstObject;
            }
        cell.titleLabel.text = arr[indexPath.section][indexPath.row][@"name"];
        cell.selectionStyle = NO;
        return cell;
        
    })
    .tableCellHeightBlockSet(^CGFloat(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        return 50;
    })
    .allowScrollSet(YES)
    .dataSourceSet(arr.mutableCopy)
    .bouncesSet(NO)
    ;
    
    self.tableView.param = self.param;
    [self.view addSubview:self.tableView];
    
    
}

-(CXTableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[CXTableView alloc]initWithFrame:CGRectMake(0, CXNavBarHeight, CXScreenWidth, CXScreenHeight-88)];
    }
    _tableView.delegate = self;
    return _tableView;
}

-(void)cxTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:
        {
//            [CXManager showPhotoSheet];
            CXViewController2 *vc = [[CXViewController2 alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 1:
        {
            [CXManager showPhotoSheet];
        }
            break;
        default:
            break;
    }
    
    
    
    
}
-(NSArray *)loadData{
    
    return @[@[@{@"name":@"选择图片",@"cid":@"0"},@{@"name":@"名字2",@"cid":@"1"}]];
    
    
    
}

@end

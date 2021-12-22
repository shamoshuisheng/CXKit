
 初始化方法1.
 self.param = [[CXCollectionViewModel alloc]init];
    
 self.param.cellName = NSStringFromClass([CXProductCollectionCell class]);
 self.param.cellCallBlock = ^UICollectionViewCell *(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView, id  _Nonnull model) {
        CXProductCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXProductCollectionCell" forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([cell class]) owner:self options:nil].firstObject;
            }
            return cell;
    };
    
//    self.param.headerCallBlock = ^UICollectionReusableView *(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView, NSString * _Nonnull kind) {
//        UICollectionReusableView *headerView;
//        if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
//            CXProductCollectionHeader *header = (CXProductCollectionHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CXProductCollectionHeader" forIndexPath:indexPath];
//              headerView = header;
//         }
//        return headerView;
//    };
//    self.param.headerHeightBlock = ^CGFloat(NSInteger section, UICollectionView * _Nonnull collectionView) {
//        return 50;
//    };
//    self.param.headerNameArray = @[@"CXProductCollectionHeader"].mutableCopy;
    

 self.param.allowRefresh = NO;
    self.param.cellHeightBlock = ^CGFloat(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView) {
        return 250;
    };

//    self.param.allowRefresh = YES;
//    self.param.headerWithRefreshingBlock = ^(CXCollectionView * _Nonnull collectionView) {
//        NSLog(@"刷新");
//        [collectionView stopRefreshing];
//    };
    self.param.num = 4;
    self.param.allowScroll = YES;
    self.param.dataSource = a.mutableCopy;
    self.param.interval = 15;

    
    
    self.param.collectionViewStyle = CollectionViewStyleHorizontal;
    self.param.isAverage = YES;
    
    self.param.topLineSpace = 0.01;
    self.param.lineSpace = 0.01;
    
    
    
    
    


 初始化方法2.

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *a = [self loadData];
    self.param=
    CXCollectionParam()
    .cellNameArraySet(@[NSStringFromClass([CXProductCollectionCell class])])
    .collectionCellCallBlockSet(^UICollectionViewCell *(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView, id  _Nonnull model){
                CXProductCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXProductCollectionCell" forIndexPath:indexPath];
                    if (cell == nil) {
                        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([cell class]) owner:self options:nil].firstObject;
                    }
                    return cell;
    })
    .collectionCellHeightBlockSet(^CGFloat(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView) {
        if (indexPath.row % 3 == 0) {
            return 200;
        }
        
                return 150;
            })
    .collectionHeaderCallBlockSet(^UICollectionReusableView *(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView, NSString * _Nonnull kind) {
                UICollectionReusableView *headerView;
                if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
                    CXProductCollectionHeader *header = (CXProductCollectionHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CXProductCollectionHeader" forIndexPath:indexPath];
                      headerView = header;
                 }
                return headerView;
            })
        .collectionHeaderHeightBlockSet(^CGFloat(NSInteger section, UICollectionView * _Nonnull collectionView) {
                    return 50;
                })
    .headerNameArraySet(@[@"CXProductCollectionHeader"].mutableCopy)
    .allowRefreshSet(YES)
    .collectionHeaderRefreshingBlockSet(^(CXCollectionView * _Nonnull collectionView) {
                NSLog(@"刷新");
                [collectionView stopRefreshing];
            })
    .collectionFooterRefreshingBlockSet(^(CXCollectionView * _Nonnull collectionView) {
        NSLog(@"加载");
        
        
        
        [collectionView stopRefreshing];
    })
    .emptyTitleNameSet(@"没有更多数据")
    .showEmptySet(YES)
    .allowScrollSet(YES)
    .dataSourceSet(a.mutableCopy)
    .collectionViewStyleSet(CollectionViewStyleVertical)
    .numSet(3)
    .isStickyHeaderSet(YES)
    .isAverageSet(YES)
    ;
 self.collectionView.param = self.param;
   
 [self.view addSubview:self.collectionView];
 
    
}


-(CXCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[CXCollectionView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height)];
        _collectionView.delegate = self;
        
    }
    
    return _collectionView;
}

//-(void)baseCollectionView:(UICollectionView *)collectionView andHeight:(CGFloat)height{
//    self.collectionView.frame = CGRectMake(0, 80, self.view.frame.size.width, height);
//}




-(NSArray *)loadData{
    
    return @[@[@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"}]];
    
    
    
}

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


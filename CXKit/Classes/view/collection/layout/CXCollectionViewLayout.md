#  CXCollectionViewLayout


            CXCollectionViewLayout *layout = [[CXCollectionViewLayout alloc] init];
            layout.delegate = self;
            layout.fixTop = 0;
            layout.isStickyHeader = YES;
            layout.isTopForHeader = YES;




#pragma mark ===CXCollectionViewLayout代理方法===
//item高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(CXCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    HNTCategoryProductModel *productModel = self.dataSource[indexPath.row];
    CGFloat height =hItemHeight;
    if (productModel.ProductActives.count > 0) {
        height += 30;
    }
return height;
}
//header高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(CXCollectionViewLayout *)collectionViewLayout
heightForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    return 40.;
}
//item宽度
- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView
                   layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
    widthForItemInSection:( NSInteger )section
{
        return wItemWidth;
}

//固定位置与顶部的距离
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
              topInSection:(NSInteger )section
{
        return 0;
   
}

//最后一个元素，和底部的距离
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
           bottomInSection:( NSInteger)section
{
    return 50;
}

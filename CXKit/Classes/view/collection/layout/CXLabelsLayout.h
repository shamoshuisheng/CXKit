//
//  BYHLabelsLayout.h
//  UICollectionVIewDemo
//
//  Created by 疯叶 on 2019/8/14.
//  Copyright © 2019 疯叶. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CXLabelsLayoutDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface CXLabelsLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id<CXLabelsLayoutDelegate> delegate;

@end

@protocol CXLabelsLayoutDelegate <NSObject>

@required

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(CXLabelsLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 *  行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CXLabelsLayout *)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
/**
 *  列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CXLabelsLayout *)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
/**
 *  section边距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(CXLabelsLayout *)layout insetForSectionAtIndex:(NSInteger)section;
/**
 *  头部高度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CXLabelsLayout *)layout referenceHeightForHeaderInSection:(NSInteger)section;
/**
 *  尾部高度
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CXLabelsLayout *)layout referenceHeightForFooterInSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

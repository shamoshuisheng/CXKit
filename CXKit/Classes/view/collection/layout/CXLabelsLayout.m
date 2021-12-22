//
//  BYHLabelsLayout.m
//  UICollectionVIewDemo
//
//  Created by 疯叶 on 2019/8/14.
//  Copyright © 2019 疯叶. All rights reserved.
//


#import "CXLabelsLayout.h"

/** 每一列之间的间距 */
static const CGFloat BYHMinimumLineSpacing = 10;
/** 每一行之间的间距 */
static const CGFloat BYHMinimumInterSpacing = 10;
/** 边缘间距 */
static const UIEdgeInsets XHLDefaultEdgeInsets = {10, 10, 10, 10};
/** 头部高度 */
static const CGFloat BYHHeaderHeight = 0;
/** 尾部高度 */
static const CGFloat BYHFooterHeight = 0;

@interface CXLabelsLayout ()

/** 存放所有cell的布局属性 */
@property (nonatomic, strong) NSMutableArray *itemAttrsArray;
/** 存放所有Header的布局属性 */
@property (nonatomic, strong) NSMutableArray *headerAttrsArr;
/** 存放所有Footer的布局属性 */
@property (nonatomic, strong) NSMutableArray *footerAttrsArr;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;

/** 内容的宽度 */
@property (nonatomic, assign) CGFloat itemMaxX;

/** item的最大高度 */
@property (nonatomic, assign) CGFloat itemMaxHeight;

/** 上次布局的section*/
@property (nonatomic, assign) NSInteger nextSection;

@end

@implementation CXLabelsLayout

#pragma mark - 代理数据处理
- (CGFloat)minimumInterWithSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return BYHMinimumInterSpacing;
    }
}

- (CGFloat)minimumLineWithSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    } else {
        return BYHMinimumLineSpacing;
    }
}


- (UIEdgeInsets)edgeInsetsWithSection:(NSInteger )section {
    if (section < 0) {
        return UIEdgeInsetsZero;
    }
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    } else {
        return XHLDefaultEdgeInsets;
    }
}

- (CGFloat)headerHeightWithSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceHeightForHeaderInSection:)]) {
        return [self.delegate collectionView:self.collectionView layout:self referenceHeightForHeaderInSection:section];
    }
    return BYHHeaderHeight;
}

- (CGFloat)footerHeightWithSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceHeightForFooterInSection:)]) {
        return [self.delegate collectionView:self.collectionView layout:self referenceHeightForFooterInSection:section];
    }
    return BYHFooterHeight;
}

/**
 * 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemAttrsArray = [NSMutableArray array];
    self.headerAttrsArr = [NSMutableArray array];
    self.footerAttrsArr = [NSMutableArray array];
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    
    // 清除之前所有的布局属性
    [self.itemAttrsArray removeAllObjects];
    [self.headerAttrsArr removeAllObjects];
    [self.footerAttrsArr removeAllObjects];
    NSInteger sectionNum = [self.collectionView numberOfSections];
    for (NSInteger section = 0; section < sectionNum; section++) {
        
        UIEdgeInsets sectionInset = [self edgeInsetsWithSection:section];
        CGFloat minimumzLine = [self minimumLineWithSection:section];
        CGFloat minimumzInter = [self minimumInterWithSection:section];
        
        self.itemMaxX = sectionInset.left - minimumzLine;
        
        UICollectionViewLayoutAttributes *headerAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        CGFloat headerHeight = [self headerHeightWithSection:section];
        headerAttrs.frame = CGRectMake(0, self.itemMaxHeight, collectionViewW, headerHeight);
        [self.headerAttrsArr addObject:headerAttrs];
        
        self.itemMaxHeight = self.itemMaxHeight + headerHeight + sectionInset.top;
        
        NSInteger itemNum = [self.collectionView numberOfItemsInSection:section];
        NSMutableArray *sectionItemArr = [NSMutableArray array];
        for (NSInteger item = 0; item < itemNum; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            UICollectionViewLayoutAttributes *itemAttrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            if (itemSize.width >= (collectionViewW - sectionInset.left - sectionInset.right)) {
                if (item != 0) {
                    self.itemMaxHeight = self.itemMaxHeight + minimumzInter;
                }
                self.itemMaxX = sectionInset.left;
                itemAttrs.frame = CGRectMake(self.itemMaxX, self.itemMaxHeight, itemSize.width, itemSize.height);
                self.itemMaxHeight = self.itemMaxHeight + itemSize.height + minimumzInter;
            }else {
                if (collectionViewW - self.itemMaxX - sectionInset.right - minimumzLine >= itemSize.width) {
                    self.itemMaxX += minimumzLine;
                }else {
                    self.itemMaxX = sectionInset.left;
                    self.itemMaxHeight = self.itemMaxHeight + minimumzInter + itemSize.height;
                }
                itemAttrs.frame = CGRectMake(self.itemMaxX, self.itemMaxHeight, itemSize.width, itemSize.height);
                self.itemMaxX += itemSize.width;
            }
            if (item == itemNum - 1) {
                self.itemMaxHeight = self.itemMaxHeight + itemSize.height + sectionInset.bottom;
            }
            [sectionItemArr addObject:itemAttrs];
        }
        [self.itemAttrsArray addObject:sectionItemArr];
        
        UICollectionViewLayoutAttributes *footerAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        CGFloat footerHeight = [self footerHeightWithSection:section];
        [self.footerAttrsArr addObject:footerAttrs];
        footerAttrs.frame = CGRectMake(0, self.itemMaxHeight, collectionViewW, footerHeight);
        self.itemMaxHeight = self.itemMaxHeight + footerHeight;
        self.contentHeight = self.itemMaxHeight;
    }
}

/**
 * 决定cell的排布
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    return self.itemAttrsArray;
    
    NSMutableArray<UICollectionViewLayoutAttributes *> *result = [NSMutableArray array];
    [_itemAttrsArray enumerateObjectsUsingBlock:^(NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributeOfSection, NSUInteger idx, BOOL *stop) {
        [layoutAttributeOfSection enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
            if (CGRectIntersectsRect(rect, attribute.frame)) {
                [result addObject:attribute];
            }
        }];
    }];
    [_headerAttrsArr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
        if (attribute.frame.size.height && CGRectIntersectsRect(rect, attribute.frame)) {
            [result addObject:attribute];
        }
    }];
    [_footerAttrsArr enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
        if (attribute.frame.size.height && CGRectIntersectsRect(rect, attribute.frame)) {
            [result addObject:attribute];
        }
    }];
    
    return result;
}

/**
 * 返回indexPath位置cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.itemAttrsArray[indexPath.section][indexPath.item];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        NSLog(@"Header: section-%zd, item-%zd", indexPath.section, indexPath.item);
        return self.headerAttrsArr[indexPath.item];
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        NSLog(@"Footer: section-%zd, item-%zd", indexPath.section, indexPath.item);
        return self.footerAttrsArr[indexPath.item];
    }
    return nil;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), self.contentHeight);
}

@end

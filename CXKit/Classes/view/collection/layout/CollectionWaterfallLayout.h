//
//  CollectionWaterfallLayout.h
//  TidusWWDemo
//
//  Created by Tidus on 17/1/12.
//  Copyright © 2017年 Tidus. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const layoutheader;

@protocol CollectionWaterfallLayoutProtocol;
@interface CollectionWaterfallLayout : UICollectionViewLayout

@property (nonatomic, weak) id<CollectionWaterfallLayoutProtocol> delegate;
@property (nonatomic, assign) NSUInteger columns;
@property (nonatomic, assign) CGFloat columnSpacing;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, assign) UIEdgeInsets insets;

@property (nonatomic ,assign) BOOL sectionHeadersBounds;


@end



@protocol CollectionWaterfallLayoutProtocol <NSObject>

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)collectionViewLayout:(CollectionWaterfallLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath;

@end

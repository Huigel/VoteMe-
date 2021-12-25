//
//  CIWaterFallLayout.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import <UIKit/UIKit.h>
#import "VMViewSizeAndColor.h"

NS_ASSUME_NONNULL_BEGIN


@class VMWaterFallLayout;

@protocol CIWaterFallLayoutDataSource<NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(VMWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;
 
@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(VMWaterFallLayout *)waterFallLayout;
 
/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(VMWaterFallLayout *)waterFallLayout;
 
/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(VMWaterFallLayout *)waterFallLayout;
 
/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetsInWaterFallLayout:(VMWaterFallLayout *)waterFallLayout;

@end

@interface VMWaterFallLayout : UICollectionViewLayout

@property (nonatomic, weak) id<CIWaterFallLayoutDataSource> delegate;

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArr;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;
/** 内容的高度 */
@property (nonatomic, assign) CGFloat contentHeight;


@end

NS_ASSUME_NONNULL_END

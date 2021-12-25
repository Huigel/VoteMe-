//
//  CICardListCollectionCell.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/24.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>
#import "VMViewSizeAndColor.h"
#import "UIColor+Hex.h"
#import "VMCardOptionView.h"
#import "VMCardListCellModel.h"


NS_ASSUME_NONNULL_BEGIN


@interface VMCardListCollectionCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UILabel *createrLabel;

@property(nonatomic, strong) NSMutableArray<VMCardOptionView *> *optionArray;


@property(nonatomic, strong) UILabel *countLabel;

@property(nonatomic, strong) UIButton *masButton;

@property(nonatomic, strong) VMCardListCellModel *cellModel;


-(void)configureCell:(int)cardID;

@end

NS_ASSUME_NONNULL_END

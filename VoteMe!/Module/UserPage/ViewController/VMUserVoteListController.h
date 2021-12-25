//
//  VMUserCardListController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMBaseViewController.h"
#import "VMUserTopBarView.h"
#import "VMWaterFallLayout.h"
#import "VMCardListCollectionCell.h"
#import "VMCellConfigure.h"
#import <MJRefresh.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMUserVoteListController : VMBaseViewController

@property(nonatomic, strong) UIScrollView *backgroundScrollView;

@property(nonatomic, strong) UIView *containerView;

@property(nonatomic, strong) UICollectionView *favoriteCollectionView; 

@property(nonatomic, strong) UICollectionView *createCollectionView;

@property(nonatomic, strong) UICollectionView *joinCollectionView;

@property(nonatomic, strong) VMWaterFallLayout *favoriteWaterFallLayout;

@property(nonatomic, strong) VMWaterFallLayout *createollectionWaterFallLayout;

@property(nonatomic, strong) VMWaterFallLayout *joinWaterFallLayout;

@property(nonatomic, strong) NSMutableArray<VMCardListCellModel *> *favoriteModelArray;

@property(nonatomic, strong) NSMutableArray<VMCardListCellModel *> *createModelArray;

@property(nonatomic, strong) NSMutableArray<VMCardListCellModel *> *joinModelArray;

@property(nonatomic, strong) VMUserTopBarView *topBarView;

@property(nonatomic, assign) VMUserTopBarState state;

-(instancetype)initWithState:(VMUserTopBarState)Nowstate;

@end

NS_ASSUME_NONNULL_END

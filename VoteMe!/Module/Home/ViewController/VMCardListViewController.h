//
//  CardListViewController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/21.
//

#import "VMBaseViewController.h"
#import <MJRefresh.h>
#import "VMCardListCollectionCell.h"
#import "VMWaterFallLayout.h"
#import "VMCardListCellModel.h"
#import "VMVoteDetailHostModel.h"
#import "VMPostNewVoteController.h"
#import "VMVoteDetailViewController.h"
#import "VMOrderSelectBarView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMCardListViewController : VMBaseViewController


@property(nonatomic, strong) UICollectionView *ListCollectionView;

@property(nonatomic, strong) NSMutableArray<VMCardListCellModel *> *CardModelArray;

@property(nonatomic, strong) UIButton *postNewVoteButtom;

@property(nonatomic, strong) VMOrderSelectBarView *orderSelectBarView;

@property(nonatomic, strong) VMWaterFallLayout *waterFallLayout;

@end

NS_ASSUME_NONNULL_END

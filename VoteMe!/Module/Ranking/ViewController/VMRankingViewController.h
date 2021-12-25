//
//  VMRankViewController.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMBaseViewController.h"
#import "VMRankPageUserCardView.h"
#import "VMRankListBoardView.h"
#import "VMRankTipsViewController.h"
#import "VMRankBoardCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMRankingViewController : VMBaseViewController

@property(nonatomic, strong) VMRankPageUserCardView *userCard;

@property(nonatomic, strong) VMRankListBoardView *listBoard;

@property(nonatomic, strong) UIButton *tipsButton;

@property(nonatomic, strong) NSMutableArray<VMRankBoardCellModel *> *rankBoardCellModelArray;

@end

NS_ASSUME_NONNULL_END

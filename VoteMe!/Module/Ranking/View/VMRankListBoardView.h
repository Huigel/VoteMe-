//
//  VMRankingListBoardView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMBaseView.h"
#import "VMRankBoardCellView.h"
#import "VMRankBoardCellModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface VMRankListBoardView : VMBaseView

@property(nonatomic, strong) UIScrollView *rankingScrollView;

@property(nonatomic, strong) NSMutableArray<VMRankBoardCellView *> *cellArray;


-(instancetype)init;

-(void)configureCell:(NSMutableArray<VMRankBoardCellModel *> *)modelArray;

@end

NS_ASSUME_NONNULL_END

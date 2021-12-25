//
//  VMRankingBoardCellView.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMRankBoardCellView : VMBaseView

@property(nonatomic, strong) UILabel *rankAndNameLabel;

@property(nonatomic, strong) UIImageView *medalImageView;

@property(nonatomic, strong) UILabel *scoreLabel;

//@property(nonatomic, strong) NSMutableParagraphStyle *labelStyle;

-(instancetype)initWithName:(NSString *)userName rank:(NSInteger)userRank score:(NSInteger)userScore;

@end

NS_ASSUME_NONNULL_END

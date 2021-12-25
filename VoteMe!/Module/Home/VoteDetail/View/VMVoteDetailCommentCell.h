//
//  VMVoteDetailCommentCell.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMVoteDetailCommentCell : VMBaseTableViewCell

@property(nonatomic, strong) UIView *cardBackgroundView;

@property(nonatomic, strong) UILabel *createrNameLabel;

@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UIImageView *contentImageView;

@property(nonatomic, strong) UIView *remarkBackgroundView;

@property(nonatomic, strong) UIButton *moreButton;


-(instancetype)init;

@end

NS_ASSUME_NONNULL_END

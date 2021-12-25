//
//  VMCommentCell.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/6.
//

#import "VMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface VMCommentCell : VMBaseTableViewCell

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UIView *separaterLine;



@end 

NS_ASSUME_NONNULL_END

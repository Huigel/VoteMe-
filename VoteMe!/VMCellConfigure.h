//
//  VMCellConfigure.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import <Foundation/Foundation.h>
#import "VMViewControllerManager.h"
#import "VMCardListCollectionCell.h"
#import "VMCardListCellModel.h"
#import "VMVoteDetailHostCell.h"
#import "VMVoteDetailCommentCell.h"
#import "VMVoteDetailHostModel.h"
#import "VMVoteDetailCommentModel.h"
#import "VMCommentHostCell.h"
#import "VMCommentCell.h"
#import "VMNotificationCell.h"
#import "VMNotificationModel.h"
#import <SDWebImage.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMCellConfigure : NSObject

+(void)configureVoteListCell:(VMCardListCollectionCell *)cell withModel:(VMCardListCellModel *)model;


#pragma mark - 投票详情页部分

+(void)configDetailHostCell:(VMVoteDetailHostCell *)cell
                    withModel:(VMVoteDetailHostModel *)model couldVote:(BOOL)flag;


+(void)configDetailCommentCell:(VMVoteDetailCommentCell *)cell
                    withModel:(VMVoteDetailCommentModel *)model;


+(void)configCommentDetailHostCell:(VMCommentHostCell *)cell
                    withModel:(VMVoteDetailCommentModel *)model;

+(void)configCommentDetailfollowCell:(VMCommentCell *)cell
                    withModel:(VMVoteDetailCommentModel *)model;


#pragma mark - 通知部分

+(void)configureNotificationCell:(VMNotificationCell *)cell model:(VMNotificationModel *)model;


/**
 * 从时间戳中提取时间
 */
+(NSString *)timeExtractBBEnd:(NSString *)timeStamp;

@end

NS_ASSUME_NONNULL_END

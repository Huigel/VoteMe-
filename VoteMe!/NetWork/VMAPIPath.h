//
//  CIAPIPath.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*
 * 基础API
 */
static NSString *const VMBaseURL                = @"https://voteme.pivotstudio.cn";

#pragma mark - 登录注册部分
/*
 * 登录API
 */
static NSString *const VMLoginURL                = @"api/user/login";

static NSString *const VMRegistURL               = @"api/user/register";

static NSString *const VMVerificationCodeURL     = @"api/user/sendcode";

static NSString *const VMUserInfoURL             = @"api/user/profile";

static NSString *const VMResetPasswordCodeURL    = @"api/user/password/code";

static NSString *const VMResetPasswordURL        = @"api/user/password/reset";

/*
 * 首页部分API
 */
#pragma mark - 首页部分

static NSString *const VMHomeGetVoteListURL             = @"api/vote";

static NSString *const VMHomePostNewVoteURL             = @"api/vote";

#pragma mark - 投票详情页部分

static NSString *const VMGetCommentOfVoteURL           = @"api/remark/getvote";

static NSString *const VMGetCommentOfRemarkURL         = @"api/remark/getremark";

static NSString *const VMPostCommentURL                = @"api/remark/add";

static NSString *const VMVoteURL                       = @"api/vote/involve";

static NSString *const VMCollectionAddURL              = @"api/collection/add";

static NSString *const VMCollectionCheckURL            = @"api/collection/check";

static NSString *const VMCollectionDeleteURL           = @"api/collection/delete";

static NSString *const VMPictureUploadTokenURL         = @"api/vote/upload";

#pragma mark - 排行榜部分

static NSString *const VMGetRankURL                    = @"api/score/rank";

static NSString *const VMGetMyRankURL                  = @"api/score/myrank";

#pragma mark - 用户部分

static NSString *const VMFavoriteVoteListURL           = @"api/collection/my";

static NSString *const VMCreateVoteListURL             = @"api/collection/start";

static NSString *const VMJoinVoteListURL               = @"api/collection/involve";

#pragma mark - 图片上传

static NSString *const VMUploadPictureURL            = @"https://upload.qiniup.com/";

#pragma mark - 通知

static NSString *const VMNotificationURL             = @"api/notice/get";

@interface VMAPIPath : NSObject

@end

NS_ASSUME_NONNULL_END

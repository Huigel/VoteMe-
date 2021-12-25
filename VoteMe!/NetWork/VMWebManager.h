//
//  CIWebManager.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "AFHTTPSessionManager.h"
#import "VMAPIPath.h"
#import "VMHandleWebResponse.h"
#import "VMUserDefaultManager.h"
#import "VMViewControllerManager.h"
#import <Toast.h>

NS_ASSUME_NONNULL_BEGIN

@interface VMWebManager : AFHTTPSessionManager

@property(nonatomic, weak) id<VMHandleWebResponse> delegate;

+(VMWebManager *)shareInstance;

-(void)resetAuth;


#pragma mark - 登录注册部分

-(void)registerWithUserEmail:(NSString *)email PassWord:(NSString *)password VerificationCode:(NSString *)code userName:(NSString *)userName;

-(void)loginWithUserEmail:(NSString *)email PassWord:(NSString *)password;

-(void)sendVerificationCodeWithEmail:(NSString *)email;

-(void)sendResetPasswordCodeWithEmail:(NSString *)email;

-(void)resetPasswordWithEmail:(NSString *)email newPassword:(NSString *)newPassword code:(NSString *)code;


#pragma mark - 首页部分

-(void)getVoteListWithOffset:(NSInteger)offset Limit:(NSInteger)limit Status:(NSInteger)status OrderBy:(NSString *)orderBy flag:(VMResponseFlag)flag;

-(void)getSingleVoteWithVoteID:(NSInteger)voteID;

-(void)postNewVoteWithData:(NSData *)data;

#pragma mark - 投票详情页

-(void)getCommentWithVoteID:(NSInteger)voteID Offset:(NSInteger)offset Limit:(NSInteger)limit OrderBy:(NSString *)orderBy flag:(VMResponseFlag)flag;

-(void)getCommentWithCommentID:(NSInteger)commentID Offset:(NSInteger)offset Limit:(NSInteger)limit OrderBy:(NSString *)orderBy flag:(VMResponseFlag)flag;

-(void)voteWithVoteID:(NSInteger)voteID optionID:(NSString *)optionID;

-(void)postCommentFor:(bool)forVote WithID:(NSInteger)whithId Content:(NSString *)content Imgurl:(NSString *)imgurl;

-(void)favoriteAddWithVoteID:(NSInteger)voteID;

-(void)favoriteCheckWithVoteID:(NSInteger)voteID;

-(void)favoriteDeleteWithVoteID:(NSInteger)voteID;

-(void)deleteVoteWithVoteID:(NSInteger)voteID;

-(void)getPictureUploadToken;

#pragma mark - 排行榜部分

-(void)getRankListWithOffset:(NSInteger)offset Limit:(NSInteger)limit;

-(void)getMyRank;

#pragma mark - 用户部分

-(void)getNowUserInfo;

-(void)getVoteListWithOffset:(NSInteger)offset Limit:(NSInteger)limit OrderBy:(NSString *)orderBy cardListMode:(VMCardListModeFlag)modeFlag flag:(VMResponseFlag)flag;

#pragma mark - 通知部分
-(void)getNotificationWithAfter:(NSInteger)after;

@end

NS_ASSUME_NONNULL_END

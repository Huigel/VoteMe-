//
//  CIHandleWebResponse.h
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, VMResponseFlag){
    VMRefresh,
    VMLoadMore,
    VMFailed
};

typedef NS_ENUM(NSInteger, VMCardListModeFlag){
    VMFavorite,
    VMCreate,
    VMJoin
};

NS_ASSUME_NONNULL_BEGIN

@protocol VMHandleWebResponse <NSObject>

@optional

#pragma mark - 登录注册部分
-(void)handleLoginWithResponse:(_Nullable id)response success:(BOOL)success;
 
-(void)handleRegistWithResponse:(_Nullable id)response success:(BOOL)success;

-(void)handleNowUserInfoWithResponse:(_Nullable id)response success:(BOOL)success;

//-(void)handleResetPasswordVerificationCodeWithResponse:(_Nullable id)response success:(BOOL)success;
-(void)handleRegistNotificationSucceess:(BOOL)success;

-(void)handleResetPasswordNotificationSucceess:(BOOL)success;

-(void)handleResetPasswordWithResponse:(_Nullable id)response success:(BOOL)success;

#pragma mark - 首页部分
-(void)handleVoteListWithResponse:(_Nullable id)response flag:(VMResponseFlag)flag;

-(void)handlePostNewVoteWithResponse:(_Nullable id)response flag:(VMResponseFlag)flag;

#pragma mark - 投票详情页部分

-(void)handleSingleVoteDetailWithResponse:(_Nullable id)response flag:(VMResponseFlag)flag;

-(void)handleCommentListForVoteWithResponse:(_Nullable id)response flag:(VMResponseFlag)flag;

-(void)handleVoteWithResponse:(_Nullable id)response success:(BOOL)success;

-(void)handlePostCommentWithResponse:(_Nullable id)response success:(BOOL)success;

-(void)handleFavotiteAddWithResponse:(_Nullable id)response success:(BOOL)success;

-(void)handleFavotiteCheckWithResponse:(_Nullable id)response success:(BOOL)success;

-(void)handleFavotiteDeleteWithResponse:(_Nullable id)response success:(BOOL)success;

-(void)handleVoteDeleteWithResponse:(_Nullable id)response success:(BOOL)success;


-(void)handlePictureTokenWith:(_Nullable id)response success:(BOOL)success;

#pragma mark - 排行榜部分

-(void)handleRankListWithResponse:(_Nullable id)response success:(BOOL)success;

-(void)handleMyRankWithResponse:(_Nullable id)response success:(BOOL)success;

#pragma mark - 用户部分

-(void)handleVoteListWithResponse:(_Nullable id)response mode:(VMCardListModeFlag)cardListModeFlag flag:(VMResponseFlag)flag;

#pragma mark - 通知部分

-(void)handleNotificationWithResponse:(_Nullable id)response success:(BOOL)success;

@end

NS_ASSUME_NONNULL_END

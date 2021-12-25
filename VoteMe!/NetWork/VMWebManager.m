//
//  CIWebManager.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMWebManager.h"

@implementation VMWebManager

+(VMWebManager *)shareInstance{
    static VMWebManager *shareInstance;
    static dispatch_once_t flag;
    dispatch_once(&flag, ^{
        shareInstance = [[VMWebManager alloc] init];
        if([[VMUserDefaultManager sharedInstance] valueForKey:@"token"]){
            [shareInstance.requestSerializer setValue:[[VMUserDefaultManager sharedInstance] valueForKey:@"token"] forHTTPHeaderField:@"auth"];
//            NSString *test = [[VMUserDefaultManager sharedInstance] valueForKey:@"token"];
//            NSInteger i = 1;
        }
        shareInstance.requestSerializer = [AFJSONRequestSerializer serializer];
        [shareInstance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return shareInstance;
}

-(void)resetAuth{
    NSString *token = [[VMUserDefaultManager sharedInstance] valueForKey:@"token"];
    [self.requestSerializer setValue:token forHTTPHeaderField:@"auth"];
    
}

#pragma mark - 登录注册部分

-(void)registerWithUserEmail:(NSString *)email PassWord:(NSString *)password VerificationCode:(NSString *)code userName:(NSString *)userName{
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMRegistURL];
    
    NSString *dataString = [NSString stringWithFormat:@"{\"name\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"code\":\"%@\"}", userName, email, password, code];

    
    
    NSData *postData = [dataString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [self POST:url parameters:nil body:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleRegistWithResponse:success:)]){
            [self.delegate handleRegistWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleRegistWithResponse:success:)]){
            [self.delegate handleRegistWithResponse:nil success:false];
        }
    }];
}


-(void)loginWithUserEmail:(NSString *)email PassWord:(NSString *)password{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMLoginURL];

    NSString *dataString = [NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\"}",email,password];

    
    
    NSData *postData = [dataString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [self POST:url parameters:nil body:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleLoginWithResponse:success:)]){
            [self.delegate handleLoginWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleLoginWithResponse:success:)]){
            [self.delegate handleLoginWithResponse:nil success:false];
        }
    }];
    
}

-(void)sendVerificationCodeWithEmail:(NSString *)email{
    NSString *url = [NSString stringWithFormat:@"%@/%@?email=%@",VMBaseURL,VMVerificationCodeURL,email];
    
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([self.delegate respondsToSelector:@selector(handleRegistNotificationSucceess:)]){
            [self.delegate handleRegistNotificationSucceess:true];
        }
        //[[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"发送成功" duration:1 position:CSToastPositionCenter];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if([self.delegate respondsToSelector:@selector(handleRegistNotificationSucceess:)]){
            [self.delegate handleRegistNotificationSucceess:false];
        }
        //[[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"发送失败" duration:1 position:CSToastPositionCenter];
        
    }];
}

-(void)sendResetPasswordCodeWithEmail:(NSString *)email{
    NSString *url = [NSString stringWithFormat:@"%@/%@?email=%@",VMBaseURL,VMResetPasswordCodeURL,email];
    
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"发送成功" duration:1 position:CSToastPositionCenter];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"发送失败" duration:1 position:CSToastPositionCenter];
        
    }];
}

-(void)resetPasswordWithEmail:(NSString *)email newPassword:(NSString *)newPassword code:(NSString *)code{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMResetPasswordURL];
    
    NSString *postStr = [NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\",\"code\":\"%@\"}", email, newPassword, code];
    
    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [self POST:url parameters:nil body:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleResetPasswordWithResponse:success:)]){
            [self.delegate handleResetPasswordWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleResetPasswordWithResponse:success:)]){
            [self.delegate handleResetPasswordWithResponse:nil success:false];
        }
    }];
    
}

#pragma mark - 首页部分

-(void)getVoteListWithOffset:(NSInteger)offset Limit:(NSInteger)limit Status:(NSInteger)status OrderBy:(NSString *)orderBy flag:(VMResponseFlag)flag{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMHomeGetVoteListURL];
    
    [self GET:url parameters:@{
            @"offset": [NSNumber numberWithInteger:offset],// 跳过多少条记录【缺省则从头开始】
            @"limit": [NSNumber numberWithInteger:limit],// 返回记录条数【缺省则返回全部】
            @"status": [NSNumber numberWithInteger:status],// 0-未截止， 1/2-已截止，不做区分
            @"orderby": orderBy
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if([self.delegate respondsToSelector:@selector(handleVoteListWithResponse:flag:)]){
            [self.delegate handleVoteListWithResponse:responseObject flag:flag];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleVoteListWithResponse:flag:)]){
            [self.delegate handleVoteListWithResponse:nil flag:VMFailed];
        }
    }];
    
    
    
//    [self.requestSerializer setValue:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsInVzZXJfaWQiOiI0In0.e30.Y93qRiJ0vRkK8Cf45xDXsI6voaIIdZHmJ8qJv1YxQf4" forHTTPHeaderField:@"auth"];
//
//    NSURL *url = [NSURL URLWithString:urlstr];
//
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    [request setValue:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsInVzZXJfaWQiOiI0In0.e30.Y93qRiJ0vRkK8Cf45xDXsI6voaIIdZHmJ8qJv1YxQf4" forHTTPHeaderField:@"auth"];
//
//    NSString *postData = @"{\"offset\": 0,\"limit\": 10,\"status\": 0,\"orderBy\": \"created_at\"}";
//
//    NSData *sendData = [postData dataUsingEncoding:kCFStringEncodingUTF8 allowLossyConversion:YES];
//    [request setHTTPBody:sendData];
//
//    //创建session对象
//    NSURLSession *session = [NSURLSession sharedSession];
//
//    //创建一个请求任务
//    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"POST%@",result);
//    }];
//
//    [task resume];
}

-(void)postNewVoteWithData:(NSData *)data{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMHomePostNewVoteURL];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *testStr = [[NSString alloc] initWithData:data encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
    [self POST:url parameters:nil body:data progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handlePostNewVoteWithResponse:flag:)]){
            [self.delegate handlePostNewVoteWithResponse:responseObject flag:VMRefresh];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handlePostNewVoteWithResponse:flag:)]){
            [self.delegate handlePostNewVoteWithResponse:nil flag:VMFailed];
        }
    }];
    
}

-(void)getSingleVoteWithVoteID:(NSInteger)voteID{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%ld", VMBaseURL, VMHomeGetVoteListURL, (long)voteID];
    
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleSingleVoteDetailWithResponse:flag:)]){
            [self.delegate handleSingleVoteDetailWithResponse:responseObject flag:VMRefresh];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleSingleVoteDetailWithResponse:flag:)]){
            [self.delegate handleSingleVoteDetailWithResponse:nil flag:VMFailed];
        }
    }];
}



#pragma mark - 投票详情页

-(void)getCommentWithVoteID:(NSInteger)voteID Offset:(NSInteger)offset Limit:(NSInteger)limit OrderBy:(NSString *)orderBy flag:(VMResponseFlag)flag{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMGetCommentOfVoteURL];
    
    [self GET:url parameters:@{
        @"vote_id":[NSString stringWithFormat:@"%ld",(long)voteID],
        @"offset":[NSString stringWithFormat:@"%ld",(long)offset],
        @"limit":[NSString stringWithFormat:@"%ld",(long)limit],
        @"limit_pre":@"3",
        @"orderby":orderBy
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleCommentListForVoteWithResponse:flag:)]){
            [self.delegate handleCommentListForVoteWithResponse:responseObject flag:flag];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleCommentListForVoteWithResponse:flag:)]){
            [self.delegate handleCommentListForVoteWithResponse:nil flag:VMFailed];
        }
    }];
    
    
    
//    NSString *postStr = [NSString stringWithFormat:@"{\"vote_id\":%ld,\"offset\": %ld,\"limit\": %ld,\"orderby\":\"%@\"}", (long)voteID, (long)offset, (long)limit, orderBy];
//
//    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//
//    [self POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)voteID] dataUsingEncoding:NSUTF8StringEncoding] name:@"vote_id"];
//        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)offset] dataUsingEncoding:NSUTF8StringEncoding] name:@"offset"];
//        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)limit] dataUsingEncoding:NSUTF8StringEncoding] name:@"limit"];
//        [formData appendPartWithFormData:[orderBy dataUsingEncoding:NSUTF8StringEncoding] name:@"orderby"];
//
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if([self.delegate respondsToSelector:@selector(handleCommentListForVoteWithResponse:flag:)]){
//            [self.delegate handleCommentListForVoteWithResponse:responseObject flag:flag];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if([self.delegate respondsToSelector:@selector(handleCommentListForVoteWithResponse:flag:)]){
//            [self.delegate handleCommentListForVoteWithResponse:nil flag:VMFailed];
//        }
//    }];
    
}

-(void)getCommentWithCommentID:(NSInteger)commentID Offset:(NSInteger)offset Limit:(NSInteger)limit OrderBy:(NSString *)orderBy flag:(VMResponseFlag)flag{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMGetCommentOfRemarkURL];
    
    [self GET:url parameters:@{
        @"remark_id":[NSString stringWithFormat:@"%ld",(long)commentID],
        @"offset":[NSString stringWithFormat:@"%ld",(long)offset],
        @"limit":[NSString stringWithFormat:@"%ld",(long)limit],
        @"orderby":orderBy
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleCommentListForVoteWithResponse:flag:)]){
            [self.delegate handleCommentListForVoteWithResponse:responseObject flag:flag];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleCommentListForVoteWithResponse:flag:)]){
            [self.delegate handleCommentListForVoteWithResponse:nil flag:VMFailed];
        }
    }];
    
//    NSString *postStr = [NSString stringWithFormat:@"{\"remark_id\":%ld,\"offset\": %ld,\"limit\": %ld,\"orderby\":\"%@\"}", (long)commentID, (long)offset, (long)limit, orderBy];
//
//    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//
//    [self POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)commentID] dataUsingEncoding:NSUTF8StringEncoding] name:@"remark_id"];
//        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)offset] dataUsingEncoding:NSUTF8StringEncoding] name:@"offset"];
//        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)limit] dataUsingEncoding:NSUTF8StringEncoding] name:@"limit"];
//        [formData appendPartWithFormData:[orderBy dataUsingEncoding:NSUTF8StringEncoding] name:@"orderby"];
//
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if([self.delegate respondsToSelector:@selector(handleCommentListForVoteWithResponse:flag:)]){
//            [self.delegate handleCommentListForVoteWithResponse:responseObject flag:flag];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if([self.delegate respondsToSelector:@selector(handleCommentListForVoteWithResponse:flag:)]){
//            [self.delegate handleCommentListForVoteWithResponse:nil flag:VMFailed];
//        }
//    }];
    
}


-(void)voteWithVoteID:(NSInteger)voteID optionID:(NSString *)optionID{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMVoteURL];
    
    [self GET:url parameters:@{
        @"vote_id":[NSString stringWithFormat:@"%ld",voteID],
        @"option_id":optionID
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleVoteWithResponse:success:)]){
            [self.delegate handleVoteWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleVoteWithResponse:success:)]){
            [self.delegate handleVoteWithResponse:nil success:false];
        }
    }];
}



-(void)postCommentFor:(bool)forVote WithID:(NSInteger)whithId Content:(NSString *)content Imgurl:(NSString *)imgurl{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMPostCommentURL];
//
//    NSString *postStr = [NSString stringWithFormat:@"{\"%@\":%ld,\"content\":\"%@\",\"imgurl\": \"%@\"}",(forVote ? @"vote_id" : @"remark_id") , (long)whithId, content, imgurl];
//
//    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//
    [self POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",(long)whithId] dataUsingEncoding:NSUTF8StringEncoding] name:[NSString stringWithFormat:@"%@",(forVote ? @"vote_id" : @"remark_id")]];
        [formData appendPartWithFormData:[content dataUsingEncoding:NSUTF8StringEncoding] name:@"content"];
        [formData appendPartWithFormData:[imgurl dataUsingEncoding:NSUTF8StringEncoding] name:@"imgurl"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handlePostCommentWithResponse:success:)]){
            [self.delegate handlePostCommentWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handlePostCommentWithResponse:success:)]){
            [self.delegate handlePostCommentWithResponse:nil success:false];
        }
    }];

//    [self POST:url parameters:nil body:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if([self.delegate respondsToSelector:@selector(handlePostCommentWithResponse:success:)]){
//            [self.delegate handlePostCommentWithResponse:responseObject success:true];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if([self.delegate respondsToSelector:@selector(handlePostCommentWithResponse:success:)]){
//            [self.delegate handlePostCommentWithResponse:nil success:false];
//        }
//    }];
}

-(void)favoriteAddWithVoteID:(NSInteger)voteID{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?vote_id=%ld",VMBaseURL,VMCollectionAddURL,voteID];
    
    [self POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleFavotiteAddWithResponse:success:)]){
            [self.delegate handleFavotiteAddWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleFavotiteAddWithResponse:success:)]){
            [self.delegate handleFavotiteAddWithResponse:nil success:false];
        }
    }];
}

-(void)favoriteCheckWithVoteID:(NSInteger)voteID{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?vote_id=%ld",VMBaseURL,VMCollectionCheckURL,voteID];
    [self POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleFavotiteCheckWithResponse:success:)]){
            [self.delegate handleFavotiteCheckWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleFavotiteCheckWithResponse:success:)]){
            [self.delegate handleFavotiteCheckWithResponse:nil success:false];
        }
    }];
}

-(void)favoriteDeleteWithVoteID:(NSInteger)voteID{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?vote_id=%ld",VMBaseURL,VMCollectionDeleteURL,voteID];
    [self POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleFavotiteDeleteWithResponse:success:)]){
            [self.delegate handleFavotiteDeleteWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleFavotiteDeleteWithResponse:success:)]){
            [self.delegate handleFavotiteDeleteWithResponse:nil success:false];
        }
    }];
}

-(void)deleteVoteWithVoteID:(NSInteger)voteID{
    
    NSString *url = [NSString stringWithFormat:@"%@/api/vote?id=%ld",VMBaseURL,voteID];
    
    [self DELETE:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleVoteDeleteWithResponse:success:)]){
            [self.delegate handleVoteDeleteWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleVoteDeleteWithResponse:success:)]){
            [self.delegate handleVoteDeleteWithResponse:nil success:false];
        }
    }];
    
}

-(void)getPictureUploadToken{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMPictureUploadTokenURL];
    
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handlePictureTokenWith:success:)]){
                [self.delegate handlePictureTokenWith:responseObject success:true];
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handlePictureTokenWith:success:)]){
                [self.delegate handlePictureTokenWith:nil success:false];
            }
    }];
    
}

#pragma mark - 排行榜部分

-(void)getRankListWithOffset:(NSInteger)offset Limit:(NSInteger)limit{
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMGetRankURL];
    
//    NSString *postStr = [NSString stringWithFormat:@"{\"offset\": %ld, \"limit\":  %ld}", (long)offset, (long)limit];
//
//    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
//
//    [self POST:url parameters:nil body:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if([self.delegate respondsToSelector:@selector(handleRankListWithResponse:success:)]){
//            [self.delegate handleRankListWithResponse:responseObject success:true];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if([self.delegate respondsToSelector:@selector(handleRankListWithResponse:success:)]){
//            [self.delegate handleRankListWithResponse:nil success:false];
//        }
//    }];
    
    [self GET:url parameters:@{
        @"offset": [NSString stringWithFormat:@"%ld", (long)offset],
        @"limit" : [NSString stringWithFormat:@"%ld", (long)limit]
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleRankListWithResponse:success:)]){
            [self.delegate handleRankListWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleRankListWithResponse:success:)]){
            [self.delegate handleRankListWithResponse:nil success:false];
        }
    }];
}

-(void)getMyRank{
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMGetMyRankURL];
    
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleMyRankWithResponse:success:)]){
            [self.delegate handleMyRankWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleMyRankWithResponse:success:)]){
            [self.delegate handleMyRankWithResponse:nil success:false];
        }
    }];
}


#pragma mark - 用户部分

-(void)getVoteListWithOffset:(NSInteger)offset Limit:(NSInteger)limit OrderBy:(NSString *)orderBy cardListMode:(VMCardListModeFlag)modeFlag flag:(VMResponseFlag)flag{
    
    NSString *secondAPI;
    if(modeFlag == VMFavorite){
        secondAPI = VMFavoriteVoteListURL;
    }else if (modeFlag == VMCreate){
        secondAPI = VMCreateVoteListURL;
    }else{
        secondAPI = VMJoinVoteListURL;
    }
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,secondAPI];
    
//    NSString *postStr = [NSString stringWithFormat:@"{\"offset\": %ld,\"limit\":  %ld,\"orderby\":\"%@\"}", (long)offset, (long)limit, orderBy];
//
//    NSData *postData = [postStr dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    [self GET:url parameters:@{
        @"offset" : [NSString stringWithFormat:@"%ld", (long)offset],
        @"limit" : [NSString stringWithFormat:@"%ld", (long)limit],
        @"orderby" : orderBy
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleVoteListWithResponse:mode:flag:)]){
            [self.delegate handleVoteListWithResponse:responseObject mode:modeFlag flag:flag];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleVoteListWithResponse:mode:flag:)]){
            [self.delegate handleVoteListWithResponse:nil mode:modeFlag flag:VMFailed];
        }
    }];
    
//    [self POST:url parameters:nil body:postData progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if([self.delegate respondsToSelector:@selector(handleVoteListWithResponse:mode:flag:)]){
//            [self.delegate handleVoteListWithResponse:responseObject mode:modeFlag flag:flag];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if([self.delegate respondsToSelector:@selector(handleVoteListWithResponse:mode:flag:)]){
//            [self.delegate handleVoteListWithResponse:nil mode:modeFlag flag:VMFailed];
//        }
//    }];
    
}




-(void)getNowUserInfo{
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMUserInfoURL];
    
    [self GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[VMUserDefaultManager sharedInstance] setValue:[[responseObject valueForKey:@"Info"] valueForKey:@"name"] forKey:@"name"];
        [[VMUserDefaultManager sharedInstance] setValue:[[responseObject valueForKey:@"Info"] valueForKey:@"email"] forKey:@"email"];
        
        if([self.delegate respondsToSelector:@selector(handleNowUserInfoWithResponse:success:)]){
            [self.delegate handleNowUserInfoWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleNowUserInfoWithResponse:success:)]){
            [self.delegate handleNowUserInfoWithResponse:nil success:false];
        }
    }];
}



-(void)getNotificationWithAfter:(NSInteger)after{
    NSString *url = [NSString stringWithFormat:@"%@/%@",VMBaseURL,VMNotificationURL];
    
    [self GET:url parameters:@{
        @"after":[NSString stringWithFormat:@"%ld", after]
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([self.delegate respondsToSelector:@selector(handleNotificationWithResponse:success:)]){
            [self.delegate handleNotificationWithResponse:responseObject success:true];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if([self.delegate respondsToSelector:@selector(handleNotificationWithResponse:success:)]){
            [self.delegate handleNotificationWithResponse:nil success:false];
        }
    }];
    
}




- (NSURLSessionDataTask *)POST:(NSString *)URLString
                   parameters:(id)parameters
                         body:(NSData *)body
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(void (^)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure
{

    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:@"POST"
                                                        URLString:URLString
                                                       parameters:parameters
                                                             body:(NSData *)body
                                                   uploadProgress:nil
                                                 downloadProgress:downloadProgress
                                                          success:success
                                                          failure:failure];

    [dataTask resume];

    return dataTask;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                            body:(NSData *)body
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    
    [request setHTTPBody:body];
    
    if (serializationError) {
        if (failure) {
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
        }

        return nil;
    }

    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];

    return dataTask;
}




- (NSString *)string2JSONString:(NSString *)string {
    NSMutableString *s = [NSMutableString stringWithString:string];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

@end

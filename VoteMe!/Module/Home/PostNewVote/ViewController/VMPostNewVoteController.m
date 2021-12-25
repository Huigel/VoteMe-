//
//  VMPostNewVoteController.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/29.
//

#import "VMPostNewVoteController.h"
#import "VMMainViewController.h"

@interface VMPostNewVoteController ()

@end

@implementation VMPostNewVoteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView.title.text = @"发布投票";
    self.navigationBarView.title.font = [UIFont systemFontOfSize:(16 * WIDTH_SCALE)];
    self.navigationBarView.backBtn.hidden = false;
    
    self.view.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    
    [self configureHierachy];
}

-(void)configureHierachy{
    
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBarView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    [self.contentScrollView addSubview:self.postCardView];
    [self.postCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentScrollView);
        make.top.bottom.equalTo(self.contentScrollView);
        make.width.mas_equalTo(326 * WIDTH_SCALE);
    }];
    
    [self.postCardView.postButton addTarget:self action:@selector(postNewVote) forControlEvents:UIControlEventTouchUpInside];
    
    PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
    config.selectionLimit = 1;
    config.filter = [PHPickerFilter imagesFilter];

    PHPickerViewController *pickerViewController = [[PHPickerViewController alloc] initWithConfiguration:config];
    pickerViewController.delegate = self;
    
    [self.postCardView.addDetailPictureButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        //[self presentViewController:pickerViewController animated:YES completion:nil];
        
        if(self.havePicture){
            [self checkPicture];
        }else{//没有图片，添加图片
            [[[VMViewControllerManager sharedInstance] getNowViewController] presentViewController:pickerViewController animated:YES completion:nil];
        }

    }] forControlEvents:UIControlEventTouchUpInside];
    
    
    /// 多列选择器
    NSArray *stringArray = @[@[@"0天", @"1天", @"2天", @"3天", @"4天"], @[@"1小时", @"2小时", @"3小时", @"4小时", @"5小时", @"6小时", @"7小时", @"8小时", @"9小时", @"10小时", @"11小时", @"12小时", @"13小时", @"14小时", @"15小时", @"16小时", @"17小时", @"18小时", @"19小时", @"20小时", @"21小时", @"22小时", @"23小时"]];
    BRStringPickerView *stringPickerView = [[BRStringPickerView alloc]init];
    stringPickerView.pickerMode = BRStringPickerComponentMulti;
    stringPickerView.title = @"选择截止时间";
    stringPickerView.dataSourceArr = stringArray;
    stringPickerView.selectIndexs = @[@2, @1];
    stringPickerView.resultModelArrayBlock = ^(NSArray<BRResultModel *> *resultModelArr) {
        
        [self.postCardView.deadlineButton setTitle:[NSString stringWithFormat:@"%@%@", resultModelArr[0].value, resultModelArr[1].value] forState:(UIControlStateNormal)];
        
        NSString *deadlineString = [self getDeadlineWithday:resultModelArr[0].index hour:resultModelArr[1].index + 1];
        
        self.model.end_time = deadlineString;
    };

    // 设置选择器中间选中行的样式
    BRPickerStyle *customStyle = [[BRPickerStyle alloc]init];
    customStyle.selectRowTextFont = [UIFont boldSystemFontOfSize:20.0f];
    customStyle.selectRowTextColor = [UIColor blueColor];
    stringPickerView.pickerStyle = customStyle;
    
    
    [self.postCardView.deadlineButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        [stringPickerView show];

    }] forControlEvents:UIControlEventTouchUpInside];


}


-(void)back{
    
    VMPopView *popView = [[VMPopView alloc] initWithType:VMPopType0 title:@"放弃发布" content:@"退出编辑并放弃发布此投票" leftText:@"手滑了" rightText:@"放弃"];

    [popView.rightButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        
        [self.navigationController popViewControllerAnimated:TRUE];
        
    }]forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:popView];
    [popView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view bringSubviewToFront:popView];
}


-(void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results{
   [picker dismissViewControllerAnimated:YES completion:nil];
    
   for (PHPickerResult *result in results)
   {
      // Get UIImage
      [result.itemProvider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error)
      {
         if ([object isKindOfClass:[UIImage class]])
         {
            dispatch_async(dispatch_get_main_queue(), ^{
               NSLog(@"Selected image: %@", (UIImage*)object);
                
                self.voteDetailImage = object;
                
                self.havePicture = true;
                self.postCardView.detailNoPictureImageView.hidden = true;
                self.postCardView.detailHavePictureImageView.hidden = false;

            });
         }
      }];
   }
}

-(NSString *)getDeadlineWithday:(NSInteger)dayNumber hour:(NSInteger)hourNumber{
    
    NSDate *deadlineDate = [NSDate dateWithTimeIntervalSinceNow:(dayNumber * 24 * 60 * 60 + hourNumber * 60 * 60)];
    
    NSDateFormatter *dateStringFormatter = [[NSDateFormatter alloc] init];
    [dateStringFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSString *str = [dateStringFormatter stringFromDate:deadlineDate];
    
    return str;
}

-(void)checkPicture{
    
    [VMPictureDetailView shareInstance].delegate = self;
    [[VMPictureDetailView shareInstance] setPictureDetailType:VMPictureDetailUploadType];
    [VMPictureDetailView shareInstance].pictureImageView.image = self.voteDetailImage;
    
    [self.view addSubview:[VMPictureDetailView shareInstance]];
    
    [[VMPictureDetailView shareInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
//    VMPictureDetailView *view = [[VMPictureDetailView alloc] init];
//    [self.view addSubview:view];
    
    //NSInteger i = 1;
}

-(void)unselectPicture{
    
    self.havePicture = false;
    self.postCardView.detailHavePictureImageView.hidden = true;
    self.postCardView.detailNoPictureImageView.hidden = false;
    
    [[VMPictureDetailView shareInstance] removeFromSuperview];
    
}

#pragma mark - post
-(void)postNewVote{
    
    [self setUserEnable:false];
    
    [VMWebManager shareInstance].delegate = self;
    [[VMWebManager shareInstance] getPictureUploadToken];
    
//    NSData *postData = [self configurePostDate];
//
//    [VMWebManager shareInstance].delegate = self;
//    [[VMWebManager shareInstance] postNewVoteWithData:postData];
    
}

-(void)setUserEnable:(BOOL)flag{
    if(flag){
        self.postCardView.userInteractionEnabled = true;
        [self.uploadingView removeFromSuperview];
    }else{
        self.postCardView.userInteractionEnabled = false;
        
        [self.view addSubview:self.uploadingView];
        [self.uploadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

-(NSData *)configurePostDate{
 
    
    self.model.title = self.postCardView.titleTextView.text;
    self.model.content = self.postCardView.contentTextView.text;
    
    if(self.havePicture){
        for(NSInteger i = 0; i < self.uploadTaskArray.count; i++){
            if(self.uploadTaskArray[i].index == -1){
                self.model.img_link = self.uploadTaskArray[i].imageUrl;
            }
        }
    }else{
        self.model.img_link = @"";
    }
    
    for(NSInteger i = 0; i < self.postCardView.optionArray.count; i++){
        
        VMNewVoteOptionModel *optionModel = [[VMNewVoteOptionModel alloc] init];
        optionModel.name = self.postCardView.optionArray[i].optionContentTextView.text;
        
        if(self.self.postCardView.optionArray[i].havePicture){
            for(NSInteger j = 0; j < self.uploadTaskArray.count; j++){
                if(self.uploadTaskArray[j].index == i){
                    optionModel.img_link = self.uploadTaskArray[j].imageUrl;
                }
            }
        }else{
            optionModel.img_link = @"";
        }
        
        [self.model.options addObject:optionModel];
    }
    

    NSString *str = [NSString stringWithFormat:@"{\"title\": \"%@\", \"content\": \"%@\", \"img\":\"%@\",\"end_time\": \"%@\",\"options\":[ ",self.model.title, self.model.content, self.model.img_link, self.model.end_time];
    
    for(NSInteger i = 0; i < self.model.options.count; i++){
        if(i != 0){
            str = [NSString stringWithFormat:@"%@ , ", str];
        }
        
        str = [NSString stringWithFormat:@"%@{ \"name\":\"%@\", \"img_link\":\"%@\" }", str, self.model.options[i].name, self.model.options[i].img_link];
    }
    
    str = [NSString stringWithFormat:@"%@]}", str];
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //NSData *postData = [str dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000) allowLossyConversion:YES];
    //NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:str] invertedSet];
    //NSString *encodedUrl = [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
    NSData *postData = [str dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
//    NSString *testStr = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
//
//    NSString *unencodeUrl = [testStr stringByRemovingPercentEncoding];
    
    
    return postData;
}

-(void)configureUploadTaskArray{
    
    if(self.havePicture){
        VMPictureUploadTask *task = [[VMPictureUploadTask alloc] init];
        task.uploadState = VMPictureTaskDoing;
        task.index = -1;
        task.image = self.voteDetailImage;
        [self.uploadTaskArray addObject:task];
    }
    
    for(NSInteger i = 0; i < self.postCardView.optionArray.count; i++){
        if(self.postCardView.optionArray[i].havePicture){
            VMPictureUploadTask *task = [[VMPictureUploadTask alloc] init];
            task.uploadState = VMPictureTaskDoing;
            task.index = i;
            task.image = self.postCardView.optionArray[i].optionImage;
            [self.uploadTaskArray addObject:task];
        }
    }
    
    if(self.uploadTaskArray.count != 0){//有图片
        [self uploadPictureArray];
    }else{//没有图片
        NSData *postData = [self configurePostDate];
    
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] postNewVoteWithData:postData];
    }

}

-(void)uploadPictureArray{
    [VMPictureUploadManager shareInstance].delegate = self;
    for(NSInteger i = 0; i < self.uploadTaskArray.count; i++){
        if(self.uploadTaskArray[i].uploadState != VMPictureTaskSuccessed){
            [[VMPictureUploadManager shareInstance] uploadPictureWithImage:self.uploadTaskArray[i].image Index:self.uploadTaskArray[i].index];
        }
    }
}

#pragma mark - 网络请求回调
-(void)handlePostNewVoteWithResponse:(_Nullable id)response flag:(VMResponseFlag)flag{
    
    if(flag != VMFailed && response){
        [[VMMainViewController sharedInstance].view makeToast:@"发布成功" duration:1 position:CSToastPositionCenter];
        [self.navigationController popViewControllerAnimated:TRUE];
    }else{
        [self.view makeToast:@"发送失败" duration:1 position:CSToastPositionCenter];
    }
    
}

-(void)handlePictureTokenWith:(id)response success:(BOOL)success{
    if(success){
        if([response objectForKey:@"token"]){
            
            NSString *token = [response valueForKey:@"token"];
            
            [VMPictureUploadManager shareInstance].delegate = self;
            [[VMPictureUploadManager shareInstance] resetPictureToken:token];
            [self configureUploadTaskArray];
            
            //[[VMPictureUploadManager shareInstance] uploadSinglePictureWithImage:self.commentView.image];
            
        }else{
            
        }
    }else{
        
    }
}

-(void)handlePictureUploadWith:(id)response index:(NSInteger)index success:(BOOL)success{
    if(success){
        if([response objectForKey:@"key"]){
            NSString *imageUrl = [NSString stringWithFormat:@"r43nngl92.hd-bkt.clouddn.com/%@",[response valueForKey:@"key"]];
            
            for(NSInteger i = 0; i < self.uploadTaskArray.count; i++){
                if(index == self.uploadTaskArray[i].index){
                    self.uploadTaskArray[i].uploadState = VMPictureTaskSuccessed;
                    self.uploadTaskArray[i].imageUrl = imageUrl;
                }
            }
        }else{
            for(NSInteger i = 0; i < self.uploadTaskArray.count; i++){
                if(index == self.uploadTaskArray[i].index){
                    self.uploadTaskArray[i].uploadState = VMPictureTaskFailure;
                }
            }
        }
    }else{
        for(NSInteger i = 0; i < self.uploadTaskArray.count; i++){
            if(index == self.uploadTaskArray[i].index){
                self.uploadTaskArray[i].uploadState = VMPictureTaskFailure;
            }
        }
    }
    
    bool completeFlag = true;
    for(NSInteger i = 0; i < self.uploadTaskArray.count; i++){
        if(self.uploadTaskArray[i].uploadState == VMPictureTaskDoing){
            return;
        }else if(self.uploadTaskArray[i].uploadState == VMPictureTaskFailure){
            completeFlag = false;
        }
    }
    //所有请求已结束
    if(completeFlag){//所有图片发送成功
        [self post];
    }else{//有图片发送失败
        [self uploadPictureArray];
    }
}

-(void)post{
        NSData *postData = [self configurePostDate];
    
        [VMWebManager shareInstance].delegate = self;
        [[VMWebManager shareInstance] postNewVoteWithData:postData];
}

#pragma mark - lazy load

-(UIScrollView *)contentScrollView{
    if(!_contentScrollView){
        _contentScrollView = [[UIScrollView alloc] init];
    }
    return _contentScrollView;
}

-(VMPostVoteCardView *)postCardView{
    if(!_postCardView){
        _postCardView = [[VMPostVoteCardView alloc] init];
    }
    return _postCardView;
}

-(UIButton *)imageViewBackgroundButton{
    if(!_imageViewBackgroundButton){
        _imageViewBackgroundButton = [[UIButton alloc] init];
        
    }
    return _imageViewBackgroundButton;
}

-(UIImage *)voteDetailImage{
    if(!_voteDetailImage){
        _voteDetailImage = [[UIImage alloc] init];
        
    }
    return _voteDetailImage;
}

-(VMNewVoteModel *)model{
    if(!_model){
        _model = [[VMNewVoteModel alloc] init];
        _model.img_link = @"";
    }
    return _model;
}

-(NSMutableArray<VMPictureUploadTask *> *)uploadTaskArray{
    if(!_uploadTaskArray){
        _uploadTaskArray = [[NSMutableArray<VMPictureUploadTask *> alloc] init];
    }
    return _uploadTaskArray;
}

-(VMLoadingView *)uploadingView{
    if(!_uploadingView){
        _uploadingView = [[VMLoadingView alloc] init];
    }
    return _uploadingView;
}

@end

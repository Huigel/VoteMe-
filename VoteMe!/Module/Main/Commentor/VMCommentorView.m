//
//  VMCommentorView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMCommentorView.h"

@implementation VMCommentorView

-(instancetype)initWithMode:(VMCommentorMode)mode replyTo:(NSInteger)replyTo{
    self = [super init];
    
    self.replyTo = replyTo;
    self.replyToName = @"";
    self.nowMode = mode;
    [self configureHierachyWithMode:mode];
    
    return self;
}

-(void)configureHierachyWithMode:(VMCommentorMode)mode{
    
//    UIView *buttonBarView = [[UIView alloc] init];
//    buttonBarView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
//
//    UIView *cardBackgroundView = [[UIView alloc] init];
//    cardBackgroundView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    //cardBackgroundView.layer.cornerRadius =
//    [self addSubview:cardBackgroundView];
//    [cardBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    
    [self addSubview:self.inputTextView];
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20 * WIDTH_SCALE);
        make.top.equalTo(self).with.offset(16 * HEIGHT_SCALE);
        make.bottom.equalTo(self).with.offset(-10 * HEIGHT_SCALE);
        make.height.mas_equalTo(25 * HEIGHT_SCALE);
        make.width.mas_equalTo(mode == VMCommentModeForVote ? (280 * WIDTH_SCALE) : (300 * WIDTH_SCALE));
    }];
    
    if(mode == VMCommentModeForVote){
        [self addSubview:self.addPictureButton];
        [self.addPictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputTextView.mas_right).with.offset(8 * WIDTH_SCALE);
            make.top.equalTo(self).with.offset(23 * HEIGHT_SCALE);
            make.height.mas_equalTo(20 * HEIGHT_SCALE);
            make.width.mas_equalTo(15 * WIDTH_SCALE);
        }];
        
        [self.addPictureButton addSubview:self.havePictureImageView];
        [self.havePictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.addPictureButton);
        }];
        self.havePictureImageView.hidden = true;
        
        [self.addPictureButton addSubview:self.noPictureImageView];
        [self.noPictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.addPictureButton);
            make.height.mas_equalTo(12 * HEIGHT_SCALE);
        }];
        self.noPictureImageView.hidden = false;
        
        PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
        config.selectionLimit = 1;
        config.filter = [PHPickerFilter imagesFilter];

        PHPickerViewController *pickerViewController = [[PHPickerViewController alloc] initWithConfiguration:config];
        pickerViewController.delegate = self;
        
        [self.addPictureButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            if(self.havePicture){
                [self checkPicture];
            }else{//没有图片，添加图片
                [[[VMViewControllerManager sharedInstance] getNowViewController] presentViewController:pickerViewController animated:YES completion:nil];
            }
            

        }] forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(19 * HEIGHT_SCALE);
        make.right.equalTo(self).with.offset(-15 * WIDTH_SCALE);
        make.width.mas_equalTo(30 * WIDTH_SCALE);
        make.height.mas_equalTo(20 * HEIGHT_SCALE);
    }];
    
}

-(void)resetInputTextField{
    
    self.inputTextView.text = @"";
    
    [self.inputTextView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25 * HEIGHT_SCALE);
    }];
    
    self.havePicture = false;
    self.havePictureImageView.hidden = true;
    self.noPictureImageView.hidden = false;
}

#pragma mark - TextView Delegate
-(void)textViewDidChange:(UITextView *)textView{
    CGFloat minHeight = 25.0 * HEIGHT_SCALE;
    
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if(size.height < minHeight){
        size.height = minHeight;
    }
    if([textView isEqual:self.inputTextView]){
        [self.inputTextView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(20 * WIDTH_SCALE);
            make.top.equalTo(self).with.offset(16 * HEIGHT_SCALE);
            make.bottom.equalTo(self).with.offset(-10 * HEIGHT_SCALE);
            make.height.mas_equalTo(size.height);
            make.width.mas_equalTo(self.nowMode == VMCommentModeForVote ? (280 * WIDTH_SCALE) : (300 * WIDTH_SCALE));
        }];
    }
}

#pragma mark - 添加or删除选项图片
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
                
                self.image = object;
                self.havePicture = true;
                self.noPictureImageView.hidden = true;
                self.havePictureImageView.hidden = false;
            });
         }
      }];
   }
}

-(void)checkPicture{
 
    [VMPictureDetailView shareInstance].delegate = self;
    [[VMPictureDetailView shareInstance] setPictureDetailType:VMPictureDetailUploadType];
    [VMPictureDetailView shareInstance].pictureImageView.image = self.image;
    
    [[[VMViewControllerManager sharedInstance] getNowViewController].view addSubview:[VMPictureDetailView shareInstance]];
    
    [[VMPictureDetailView shareInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([[VMViewControllerManager sharedInstance] getNowViewController].view);
    }];
        
}

-(void)unselectPicture{
    
    self.havePicture = false;
    self.havePictureImageView.hidden = true;
    self.noPictureImageView.hidden = false;
    
    [[VMPictureDetailView shareInstance] removeFromSuperview];
    
}


-(void)postComment{
    if([self.inputTextView.text isEqualToString:@""]){
        [[[VMViewControllerManager sharedInstance] getNowViewController].view makeToast:@"回复内容不能为空" duration:1 position:CSToastPositionCenter];
    }else{
        
        [[[VMViewControllerManager sharedInstance] getNowViewController].view addSubview:self.uploadingView];
        [self.uploadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo([[VMViewControllerManager sharedInstance] getNowViewController].view);
        }];
        
        NSString *imgurl = @"";
        self.sendButton.userInteractionEnabled = NO;
        if(self.havePicture){
            [[VMWebManager shareInstance] getPictureUploadToken];
        }else{
            if([self.replyToName isEqualToString:@""]){
                [[VMWebManager shareInstance] postCommentFor:(self.nowMode == VMCommentModeForVote ? true : false) WithID:self.replyTo Content:self.inputTextView.text Imgurl:imgurl];
            }else{
                NSString *postContent = [NSString stringWithFormat:@"回复%@ : %@", self.replyToName, self.inputTextView.text];
                [[VMWebManager shareInstance] postCommentFor:false WithID:self.replyTo Content:postContent Imgurl:imgurl];
            }
        }
    }
}

#pragma mark - lazy load
-(UITextView *)inputTextView{
    if(!_inputTextView){
        _inputTextView = [[UITextView alloc] init];
        _inputTextView.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
        _inputTextView.layer.cornerRadius = 8 * WIDTH_SCALE;
        
        _inputTextView.font = [UIFont systemFontOfSize:9 * HEIGHT_SCALE];
        if(self.nowMode == VMCommentModeForVote){
            _inputTextView.placeholder = [NSString stringWithFormat:@"我要留言！"];
        }else if (self.nowMode == VMCommentModeForComment){
            _inputTextView.placeholder = [NSString stringWithFormat:@"我要回复！"];
        }
        _inputTextView.placeholderColor = [UIColor colorWithHexString:@"#A7B0B5"];
        
        _inputTextView.scrollEnabled = NO;    // 不允许滚动
        _inputTextView.delegate = self;
    }
    return _inputTextView;
}

-(UIButton *)addPictureButton{
    if(!_addPictureButton){
        _addPictureButton = [[UIButton alloc] init];
        
    }
    return _addPictureButton;
}

-(UIImageView *)havePictureImageView{
    if(!_havePictureImageView){
        _havePictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OptionHavePicture"]];
    }
    return _havePictureImageView;
}

-(UIImageView *)noPictureImageView{
    if(!_noPictureImageView){
        _noPictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OptionNoPicture"]];
    }
    return _noPictureImageView;
}

-(UIButton *)sendButton{
    if(!_sendButton){
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_sendButton setTitle:@"发送"  forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
        
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:8 * WIDTH_SCALE];
        _sendButton.backgroundColor = [UIColor colorWithHexString:@"#F8FCFF"];
        _sendButton.layer.cornerRadius = 8 * WIDTH_SCALE;
        
        [UIView configureShadow:_sendButton];
        
        [_sendButton addTarget:self action:@selector(postComment) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

-(VMLoadingView *)uploadingView{
    if(!_uploadingView){
        _uploadingView = [[VMLoadingView alloc] init];
    }
    return _uploadingView;
}

@end

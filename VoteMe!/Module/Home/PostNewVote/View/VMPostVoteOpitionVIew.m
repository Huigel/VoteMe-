//
//  VMPostVoteOpitionVIew.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/30.
//

#import "VMPostVoteOpitionVIew.h"

@implementation VMPostVoteOpitionVIew

-(instancetype)init{
    self = [super init];
    
    [self configureHierachy];
    
    return self;
}

-(void)configureHierachy{
    PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
    config.selectionLimit = 1;
    config.filter = [PHPickerFilter imagesFilter];

    PHPickerViewController *pickerViewController = [[PHPickerViewController alloc] initWithConfiguration:config];
    pickerViewController.delegate = self;
    pickerViewController.title = @"呱呱";
    
    [self.addPictureButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        if(self.havePicture){
            [self checkPicture];
        }else{//没有图片，添加图片
            [[[VMViewControllerManager sharedInstance] getNowViewController] presentViewController:pickerViewController animated:YES completion:nil];
        }
        

    }] forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.optionContentTextView];
    [self.optionContentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.width.mas_equalTo(250 * WIDTH_SCALE);
        make.height.mas_equalTo(26 * HEIGHT_SCALE);
        make.top.bottom.left.equalTo(self);
    }];
    
    [self addSubview:self.addPictureButton];
    [self.addPictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12 * WIDTH_SCALE);
        make.height.mas_equalTo(20 * HEIGHT_SCALE);
        make.top.equalTo(self);
        make.left.equalTo(self.optionContentTextView.mas_right).with.offset(6 * WIDTH_SCALE);
    }];
    
    [self.addPictureButton addSubview:self.optionHavePictureImageView];
    [self.optionHavePictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addPictureButton).with.offset(6 * HEIGHT_SCALE);
        make.left.right.bottom.equalTo(self.addPictureButton);
    }];
    self.optionHavePictureImageView.hidden = true;
    
    [self.addPictureButton addSubview:self.optionNoPictureImageView];
    [self.optionNoPictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addPictureButton).with.offset(6 * HEIGHT_SCALE);
        make.left.right.equalTo(self.addPictureButton);
        make.bottom.equalTo(self.addPictureButton).with.offset(-4 * HEIGHT_SCALE);
    }];
    
    [self addSubview:self.deleteOpitionButton];
    [self.deleteOpitionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(18 * WIDTH_SCALE);
        make.height.mas_equalTo(18 * HEIGHT_SCALE);
        make.top.equalTo(self).with.offset(1 * HEIGHT_SCALE);
        make.left.equalTo(self.addPictureButton.mas_right).with.offset(3 * WIDTH_SCALE);
        make.right.equalTo(self).with.offset(-8 * WIDTH_SCALE);
    }];
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
                
                self.optionImage = object;
                self.havePicture = true;
                self.optionNoPictureImageView.hidden = true;
                self.optionHavePictureImageView.hidden = false;
            });
         }
      }];
   }
}

-(void)checkPicture{
 
    [VMPictureDetailView shareInstance].delegate = self;
    [[VMPictureDetailView shareInstance] setPictureDetailType:VMPictureDetailUploadType];
    [VMPictureDetailView shareInstance].pictureImageView.image = self.optionImage;
    
    [[[VMViewControllerManager sharedInstance] getNowViewController].view addSubview:[VMPictureDetailView shareInstance]];
    
    [[VMPictureDetailView shareInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([[VMViewControllerManager sharedInstance] getNowViewController].view);
    }];
        
}

-(void)unselectPicture{
    
    self.havePicture = false;
    self.optionHavePictureImageView.hidden = true;
    self.optionNoPictureImageView.hidden = false;
    
    [[VMPictureDetailView shareInstance] removeFromSuperview];
    
}


#pragma mark - lazy load
-(UITextView *)optionContentTextView{
    if(!_optionContentTextView){
        _optionContentTextView = [[UITextView alloc] init];
        _optionContentTextView.backgroundColor = [UIColor colorWithHexString:@"#FDEFEF"];
        _optionContentTextView.layer.cornerRadius = 5 * WIDTH_SCALE;
        _optionContentTextView.scrollEnabled = NO;
//        _optionContentTextView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 9 * WIDTH_SCALE, _optionContentTextView.frame.size.height)];
//        _optionContentTextView.leftViewMode = UITextFieldViewModeAlways;
    }
    return _optionContentTextView;
}

-(UIButton *)addPictureButton{
    if(!_addPictureButton){
        _addPictureButton = [[UIButton alloc] init];
        
    }
    return _addPictureButton;
}

-(UIImageView *)optionHavePictureImageView{
    if(!_optionHavePictureImageView){
        _optionHavePictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OptionHavePicture"]];
    }
    return _optionHavePictureImageView;
}

-(UIImageView *)optionNoPictureImageView{
    if(!_optionNoPictureImageView){
        _optionNoPictureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OptionNoPicture"]];
    }
    return _optionNoPictureImageView;
}

-(UIButton *)deleteOpitionButton{
    if(!_deleteOpitionButton){
        _deleteOpitionButton = [[UIButton alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DeleteOption"]];
        [_deleteOpitionButton addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_deleteOpitionButton);
        }];
    }
    return _deleteOpitionButton;
}

-(UIImage *)optionImage{
    if(!_optionImage){
        _optionImage = [[UIImage alloc] init];
    }
    return _optionImage;
}

@end

//
//  VMBigPictureScrollView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/3.
//

#import "VMPictureDetailView.h"

@implementation VMPictureDetailView

+(VMPictureDetailView *)shareInstance{
    static VMPictureDetailView *shareInstance;
    static dispatch_once_t flag;
    dispatch_once(&flag, ^{
        shareInstance = [[VMPictureDetailView alloc] init];
    });
    return shareInstance;
}


-(instancetype)init{
    self = [super init];
    self.backgroundColor = [UIColor colorWithHexString:@"#ACB8C2" alpha:0.5];
    //self.backgroundColor = [UIColor whiteColor];
    self.type = VMPictureDetailDownloadType;
     
    [self addSubview:self.pictureImageView];
    [self.pictureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self addSubview:self.maskButton];
    [self.maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.maskButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        
        [self removeFromSuperview];
        
    }] forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.deletePictureButton];
    [self.deletePictureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-40 * HEIGHT_SCALE);
        make.right.equalTo(self).with.offset(-20 * WIDTH_SCALE);
        make.height.mas_equalTo(40 * HEIGHT_SCALE);
        make.width.mas_equalTo(100 * WIDTH_SCALE);
    }];
    self.deletePictureButton.hidden = true;
    
    [self.deletePictureButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        
        [self.delegate unselectPicture];
        
    }] forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)setPictureDetailType:(VMPictureDetailType)type{
    if(type == self.type){
        return;
    }else{
        if(type == VMPictureDetailUploadType){
            self.deletePictureButton.hidden = false;
        }else if (type == VMPictureDetailDownloadType){
            self.deletePictureButton.hidden = true;
        }
    }
}

-(void)configureImageSize{
    CGFloat imageWidth = CGImageGetWidth(self.pictureImageView.image.CGImage);
    CGFloat imageHeight = CGImageGetHeight(self.pictureImageView.image.CGImage);
    CGFloat rate = imageWidth/imageHeight;
    
    
    CGFloat limitWidth = self.frame.size.width;
    CGFloat limitHeight = self.frame.size.height;
    CGFloat limitRate = limitWidth/limitHeight;
    
    CGFloat realWidth, realHeight;
    if(rate >= limitRate){
        realWidth = limitWidth;
        realHeight = limitWidth/rate;
    }else{
        realHeight = limitHeight;
        realWidth = rate * limitHeight;
    }
    
    [self.pictureImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.mas_equalTo(realWidth);
        make.height.mas_equalTo(realHeight);
    }];
    
}

-(void)showPictureDetail{
    if(!self.pictureImageView.image){
        self.pictureImageView.image = [UIImage imageNamed:@"TempPicture"];
    }
    
    [self configureImageSize];
    
    [[[VMViewControllerManager sharedInstance] getNowViewController].view addSubview:self];
    
    [[VMPictureDetailView shareInstance] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([[VMViewControllerManager sharedInstance] getNowViewController].view);
    }];
}

#pragma mark - lazy load

-(UIImageView *)pictureImageView{
    if(!_pictureImageView){
        _pictureImageView = [[UIImageView alloc] init];
    }
    
    return _pictureImageView;
}

-(UIButton *)deletePictureButton{
    if(!_deletePictureButton){
        _deletePictureButton = [[UIButton alloc] init];
        _deletePictureButton.backgroundColor = [UIColor whiteColor];
        _deletePictureButton.layer.cornerRadius = 20 * WIDTH_SCALE;
        [UIView configureShadow:_deletePictureButton];
        
        UILabel *deleteLabel = [[UILabel alloc] init];
        deleteLabel.text = @"删除";
        deleteLabel.font = [UIFont systemFontOfSize:15 * HEIGHT_SCALE];
        deleteLabel.textColor = [UIColor blackColor];
        [_deletePictureButton addSubview:deleteLabel];
        [deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(_deletePictureButton);
        }];
    }
    
    return _deletePictureButton;
}

-(UIButton *)maskButton{
    if(!_maskButton){
        _maskButton = [[UIButton alloc] init];
    }
    
    return _maskButton;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  VMNotificationBubbleView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/4.
//

#import "VMNotificationBubbleView.h"
#import "VMNotificationListController.h"

@implementation VMNotificationBubbleView

-(instancetype)init{
    self = [super init];
    
    self.haveNewNotification = false;
    [self configureHierachy];
    
    return self;
}


-(void)configureHierachy{
    
    [self addSubview:self.baseBackgroundView];
    [self.baseBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.width.mas_equalTo(36 * WIDTH_SCALE);
        make.height.mas_equalTo(36 * WIDTH_SCALE);
    }];
    
    [self.baseBackgroundView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.height.mas_equalTo(14 * WIDTH_SCALE);
    }];
    
    [self addSubview:self.yellowBallView];
    [self.yellowBallView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(7 * WIDTH_SCALE);
        make.top.equalTo(self).with.offset(1.8 * HEIGHT_SCALE);
        make.right.equalTo(self);
    }];
    self.yellowBallView.hidden = true;
    
    [self addSubview:self.maskButton];
    [self.maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark - lazy load
-(UIView *)baseBackgroundView{
    if(!_baseBackgroundView){
        _baseBackgroundView = [[UIView alloc] init];
        _baseBackgroundView.layer.cornerRadius = 18 * WIDTH_SCALE;
        _baseBackgroundView.backgroundColor = [UIColor whiteColor];
        
        [UIView configureShadow:_baseBackgroundView];
    }
    return _baseBackgroundView;
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NotificationIcon"]];
    }
    return _imageView;
}

-(UIView *)yellowBallView{
    if(!_yellowBallView){
        _yellowBallView = [[UIView alloc] init];
        _yellowBallView.layer.cornerRadius = 3.5 * WIDTH_SCALE;
    }
    return _yellowBallView;
}

-(UIButton *)maskButton{
    if(!_maskButton){
        _maskButton = [[UIButton alloc] init];

    }
    return _maskButton;
}

@end

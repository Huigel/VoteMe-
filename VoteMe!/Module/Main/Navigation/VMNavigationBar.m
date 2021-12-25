//
//  CINavigationBar.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/25.
//

#import "VMNavigationBar.h"

@implementation VMNavigationBar

-(instancetype)init{
    self = [super init];
    self.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    
    _title = UILabel.new;
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(52 * HEIGHT_SCALE);
    }];
    _title.textColor = UIColor.blackColor;
    _title.font = [UIFont systemFontOfSize:18 * HEIGHT_SCALE];
    _title.textAlignment = NSTextAlignmentCenter;
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setImage:[UIImage imageNamed:@"NavigationBackButton"] forState:UIControlStateNormal];
    [self addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self).with.offset(-13 * HEIGHT_SCALE);
        make.centerY.equalTo(self.title);
        make.left.equalTo(self).with.offset(15 * WIDTH_SCALE);
        make.width.mas_offset(10 * WIDTH_SCALE * 3);
        make.height.mas_equalTo(18 * HEIGHT_SCALE * 2);
    }];
    
    self.backBtn.hidden = true;
    
    _notificationView = [[VMNotificationBubbleView alloc] init];
    [self addSubview:_notificationView];
    [_notificationView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self).with.offset(-13 * HEIGHT_SCALE);
        make.centerY.equalTo(self.title);
        make.right.equalTo(self).with.offset(-28 * WIDTH_SCALE);
//        make.width.mas_offset(10 * WIDTH_SCALE * 3);
//        make.height.mas_equalTo(18 * HEIGHT_SCALE * 2);
    }];
    self.notificationView.hidden = true;
    
    _moreButton = [[UIButton alloc] init];
    
    UIImageView *moreImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationMoreIcom"]];
    [_moreButton addSubview:moreImageView];
    [moreImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(_moreButton);
        make.width.mas_equalTo(16 * WIDTH_SCALE);
        make.height.mas_equalTo(4 * WIDTH_SCALE);
    }];
    
    [self addSubview:_moreButton];
    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30 * WIDTH_SCALE);
        make.height.mas_equalTo(30 * HEIGHT_SCALE);
        make.right.equalTo(self).with.offset(-5 * WIDTH_SCALE);
        make.centerY.equalTo(_backBtn);
    }];
    self.moreButton.hidden = true;
    
    return self;
}


-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"the point's x is %f, y is %f",point.x, point.y);
    return [super pointInside:point withEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

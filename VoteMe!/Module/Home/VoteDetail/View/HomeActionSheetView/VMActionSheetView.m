//
//  VMActionSheetView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/12/13.
//

#import "VMActionSheetView.h"
#import "VMNotificationListController.h"

@implementation VMActionSheetView

-(instancetype)init{
    self = [super init];
    
    return self;
}

-(void)configureHierachy{
    
    [self addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.maskView addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.maskView);
        make.height.mas_equalTo(155 * HEIGHT_SCALE);
    }];
    
    UIButton *backButton = [[UIButton alloc] init];
    [self.maskView addSubview:backButton];
    [backButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        [self removeFromSuperview];
    }]forControlEvents:UIControlEventTouchUpInside];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.maskView);
        make.bottom.equalTo(self.containerView.mas_top);
    }];
    
    [self.containerView addSubview:self.notificationButton];
    [self.notificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.containerView);
        make.top.equalTo(self.containerView).with.offset(20 * HEIGHT_SCALE);
        make.height.mas_equalTo(40 * HEIGHT_SCALE);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#C4C4C4"];
    
    [self.containerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).with.offset(25 * WIDTH_SCALE);
        make.right.equalTo(self.containerView).with.offset(-25 * WIDTH_SCALE);
        make.top.equalTo(self.notificationButton.mas_bottom).with.offset(15 * HEIGHT_SCALE);
        make.height.mas_equalTo(0.5 * HEIGHT_SCALE);
    }];
    
    CGFloat itemWidth = 30 * WIDTH_SCALE, itemDistence = 25 * WIDTH_SCALE;
    for(NSInteger i = 0; i < self.itemArray.count; i++){
        [self.containerView addSubview:self.itemArray[i]];
        [self.itemArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.containerView).with.offset(-30 * HEIGHT_SCALE);
            make.left.equalTo(self.containerView).with.offset((28 + i *(itemWidth + itemDistence)) * WIDTH_SCALE);
        }];
    }
    
}


#pragma mark - lazy load

-(UIView *)maskView{
    if(!_maskView){
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.5];
    }
    return _maskView;
}

-(UIView *)containerView{
    if(!_containerView){
        _containerView = [[UIView alloc] init];
        
        UIView *topHalfView = [[UIView alloc] init];
        topHalfView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        topHalfView.layer.cornerRadius = 20 * HEIGHT_SCALE;
        [_containerView addSubview:topHalfView];
        [topHalfView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(_containerView);
            make.height.mas_equalTo(40 * HEIGHT_SCALE);
        }];
        
        UIView *bottomHalfView = [[UIView alloc] init];
        bottomHalfView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [_containerView addSubview:bottomHalfView];
        [bottomHalfView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(_containerView);
            make.top.equalTo(_containerView).with.offset(20 * HEIGHT_SCALE);
        }];
    }
    return _containerView;
}

-(UIButton *)notificationButton{
    if(!_notificationButton){
        _notificationButton = [[UIButton alloc] init];
        
        VMNotificationBubbleView *notificationBubble = [[VMNotificationBubbleView alloc] init];
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        contentLabel.text = @"通知";
        contentLabel.font = [UIFont systemFontOfSize:12 * WIDTH_SCALE];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LeftArrow"]];
        
        [_notificationButton addSubview:notificationBubble];
        [notificationBubble mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_notificationButton);
            make.left.equalTo(_notificationButton).with.offset(20 * WIDTH_SCALE);
        }];
        
        [_notificationButton addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_notificationButton);
            make.left.equalTo(notificationBubble.mas_right).with.offset(15 * WIDTH_SCALE);
        }];
        
        [_notificationButton addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_notificationButton);
            make.right.equalTo(_notificationButton).with.offset(-26 * WIDTH_SCALE);
            make.height.mas_equalTo(12 * HEIGHT_SCALE);
            make.width.mas_equalTo(7 * WIDTH_SCALE);
        }];
        
        [_notificationButton addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
            
            VMNotificationListController *vc = [[VMNotificationListController alloc] init];
            [[[VMViewControllerManager sharedInstance] getNowViewController].navigationController pushViewController:vc animated:true];

        }] forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _notificationButton;
}

-(VMActionSheetItemButton *)favoriteButton{
    if(!_favoriteButton){
        _favoriteButton = [[VMActionSheetItemButton alloc] initWithImage:[UIImage imageNamed:@"UnstarItem"] Text:@"收藏"];
    }
    return _favoriteButton;
}
-(VMActionSheetItemButton *)deleteButton{
    if(!_deleteButton){
        _deleteButton = [[VMActionSheetItemButton alloc] initWithImage:[UIImage imageNamed:@"DeleteItem"] Text:@"删除"];
    }
    return _deleteButton;
}
-(VMActionSheetItemButton *)feedbackButton{
    if(!_feedbackButton){
        _feedbackButton = [[VMActionSheetItemButton alloc] initWithImage:[UIImage imageNamed:@"FeedbackItem"] Text:@"反馈"];
    }
    return _feedbackButton;
}
-(VMActionSheetItemButton *)reportButton{
    if(!_reportButton){
        _reportButton = [[VMActionSheetItemButton alloc] initWithImage:[UIImage imageNamed:@"ReportItem"] Text:@"举报"];
    }
    return _reportButton;
}

-(NSMutableArray<VMActionSheetItemButton *> *)itemArray{
    if(!_itemArray){
        _itemArray = [[NSMutableArray<VMActionSheetItemButton *> alloc] init];
    }
    return _itemArray;
}

@end

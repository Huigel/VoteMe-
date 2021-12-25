//
//  VMRankingListBoardView.m
//  VoteMe!
//
//  Created by 李浩宇 on 2021/11/28.
//

#import "VMRankListBoardView.h"

@implementation VMRankListBoardView

-(instancetype)init{
    self = [super init];
    
    self.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0 * WIDTH_SCALE, 2 * HEIGHT_SCALE);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowRadius = 3 * WIDTH_SCALE;
    self.layer.cornerRadius = 10 * WIDTH_SCALE;
    
    [self configureHierachy];
    
    return self;
}


-(void)configureHierachy{
    
    [self addSubview:self.rankingScrollView];
    [self.rankingScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(12 * HEIGHT_SCALE);
        make.width.mas_equalTo(287 * WIDTH_SCALE);
        make.bottom.equalTo(self).with.offset(-38 * HEIGHT_SCALE);
        make.centerX.equalTo(self);
    }];
    

    

}

-(void)configureCell:(NSMutableArray<VMRankBoardCellModel *> *)modelArray{
    for(NSInteger i = 0; i < self.cellArray.count; i++){
        [self.cellArray[i] removeFromSuperview];
    }
    [self.cellArray removeAllObjects];
    
    
    NSInteger flagCount;
    if(modelArray.count % 8 == 0){
        flagCount = modelArray.count - 8;
    }else{
        flagCount = modelArray.count - (modelArray.count % 8);
    }
    
    for(NSInteger i = 0 ; i < modelArray.count; i++){
        
        [self.cellArray addObject:[[VMRankBoardCellView alloc] initWithName:modelArray[i].name rank:i+1 score:modelArray[i].score]];
        
        [self.rankingScrollView addSubview:self.cellArray[i]];
        if(self.cellArray.count == 1){
            [self.cellArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.rankingScrollView);
                make.top.equalTo(self.rankingScrollView);
            }];
        }else if (self.cellArray.count <= 8){
            [self.cellArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.rankingScrollView);
                make.top.equalTo(self.cellArray[i - 1].mas_bottom);
            }];
        }else if(self.cellArray.count > flagCount){
            [self.cellArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellArray[i -8].mas_right);
                make.top.equalTo(self.cellArray[i -8]);
                make.right.equalTo(self.rankingScrollView);
            }];
        }else{
            [self.cellArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.cellArray[i -8].mas_right);
                make.top.equalTo(self.cellArray[i -8]);
            }];
        }
    }
    
//    VMRankBoardCellView *cell1 = [[VMRankBoardCellView alloc] initWithName:@"张三" rank:1 score:100];
//
//    VMRankBoardCellView *cell2 = [[VMRankBoardCellView alloc] initWithName:@"李四" rank:5 score:100];
//    [self.rankingScrollView addSubview:cell1];
//    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.rankingScrollView);
//        make.top.equalTo(self.rankingScrollView);
//    }];
//
//    [self.rankingScrollView addSubview:cell2];
//    [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(cell1.mas_right);
//        make.top.equalTo(self.rankingScrollView);
//        make.right.equalTo(self.rankingScrollView);
//    }];
}


#pragma mark - lazy load

-(UIScrollView *)rankingScrollView{
    if(!_rankingScrollView){
        _rankingScrollView = [[UIScrollView alloc] init];
        //_rankingScrollView.backgroundColor = [UIColor colorWithHexString:@"#FBFCFE"];
        _rankingScrollView.pagingEnabled = true;
        _rankingScrollView.showsHorizontalScrollIndicator = false;
        _rankingScrollView.showsVerticalScrollIndicator = false;
        _rankingScrollView.backgroundColor = [UIColor colorWithHexString:kVMBackgroundColor];
    }
    return _rankingScrollView;
}

-(NSMutableArray<VMRankBoardCellView *> *)cellArray{
    if(!_cellArray){
        _cellArray = [[NSMutableArray<VMRankBoardCellView *> alloc] init];
    }
    return _cellArray;
}

@end

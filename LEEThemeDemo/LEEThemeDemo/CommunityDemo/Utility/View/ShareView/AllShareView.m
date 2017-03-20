
/*!
 *  @header AllShareView.m
 *          MierMilitaryNews
 *
 *  @brief  全部分享视图
 *
 *  @author 李响
 *  @copyright    Copyright © 2016年 miercn. All rights reserved.
 *  @version    16/4/19.
 */

#import "AllShareView.h"

#import "ShareButton.h"

#import "SDAutoLayout.h"

#import "LEEActionSheet.h"

#import "SetManager.h"

#import "FontSizeView.h"

@interface AllShareView ()

@property (nonatomic , strong ) UIView *backGroundView; //背景视图

@property (nonatomic , strong ) UIScrollView *shareScrollView; //分享滑动视图

@property (nonatomic , strong ) UIScrollView *moreScrollView; //更多滑动视图

@property (nonatomic , strong ) UIView *lineView; //分隔线视图

@property (nonatomic , strong ) NSArray *shareInfoArray; //分享信息数组

@property (nonatomic , strong ) NSArray *moreInfoArray; //更多信息数组

@property (nonatomic , strong ) NSMutableArray *shareButtonArray; //分享按钮数组

@property (nonatomic , strong ) NSMutableArray *moreButtonArray; //更多按钮数组

@property (nonatomic , strong ) UIButton *finishButton; //完成按钮

@end

@implementation AllShareView
{
    BOOL isShowMore; //是否显示更多
    
    BOOL isShowReport; //是否显示举报
}

- (void)dealloc{
    
    _backGroundView = nil;
    
    _shareScrollView = nil;
    
    _shareInfoArray = nil;
    
    _shareButtonArray = nil;
    
    _lineView = nil;
    
    _moreScrollView = nil;
    
    _moreInfoArray = nil;
    
    _moreButtonArray = nil;
    
    _finishButton = nil;
}

#pragma mark - 初始化


- (instancetype)initWithFrame:(CGRect)frame ShowMore:(BOOL)showMore{
    
    return [self initWithFrame:frame ShowMore:showMore ShowReport:NO];
}

- (instancetype)initWithFrame:(CGRect)frame ShowMore:(BOOL)showMore ShowReport:(BOOL)showReport{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        isShowMore = showMore;
        
        isShowReport = showReport;
        
        //初始化数据
        
        [self initData];
        
        //初始化子视图
        
        [self initSubview];
        
        //设置自动布局
        
        [self configAutoLayout];
        
    }
    return self;
}

#pragma mark - 初始化数据

- (void)initData{
    
    _shareButtonArray = [NSMutableArray array];
    
    _moreButtonArray = [NSMutableArray array];
    
    NSMutableArray *tempShareInfoArray = [NSMutableArray array];
    
//    if ([[MierConfigManager shareManager] isWechatInstall]) {
    
        [tempShareInfoArray addObject:@{@"title" : @"朋友圈" , @"image" : @"infor_popshare_friends_nor" , @"highlightedImage" : @"infor_popshare_friends_pre" , @"type" : @(ShareTypeToWechatTimeline)}];
        
        [tempShareInfoArray addObject:@{@"title" : @"微信" , @"image" : @"infor_popshare_weixin_nor" , @"highlightedImage" : @"infor_popshare_weixin_pre" , @"type" : @(ShareTypeToWechat)}];
        
//    }
    
//    if ([[MierConfigManager shareManager] isQQInstall]) {
    
        [tempShareInfoArray addObject:@{@"title" : @"QQ好友" , @"image" : @"infor_popshare_qq_nor" , @"highlightedImage" : @"infor_popshare_qq_pre" , @"type" : @(ShareTypeToQQFriend)}];
        
        [tempShareInfoArray addObject:@{@"title" : @"新浪微博" , @"image" : @"infor_popshare_sina_nor" , @"highlightedImage" : @"infor_popshare_sina_pre" , @"type" : @(ShareTypeToSina)}];
        
        [tempShareInfoArray addObject:@{@"title" : @"QQ空间" , @"image" : @"infor_popshare_kunjian_nor" , @"highlightedImage" : @"infor_popshare_kunjian_pre" , @"type" : @(ShareTypeToQZone)}];
        
//    } else {
    
        [tempShareInfoArray addObject:@{@"title" : @"新浪微博" , @"image" : @"infor_popshare_sina_nor" , @"highlightedImage" : @"infor_popshare_sina_pre" , @"type" : @(ShareTypeToSina)}];
//    }
    
    _shareInfoArray = tempShareInfoArray;
    
    NSMutableArray *tempMoreInfoArray = [NSMutableArray array];
   
    [tempMoreInfoArray addObject:[[LEETheme currentThemeTag] isEqualToString:DAY] ?
    @{@"title" :  @"夜间模式" , @"image" : @"infor_popshare_light_nor" , @"highlightedImage" : @"infor_popshare_light_pre" , @"type" : @(MoreTypeToTheme)} :
    @{@"title" :  @"日间模式" , @"image" : @"infor_popshare_day_nor" , @"highlightedImage" : @"infor_popshare_day_pre" , @"type" : @(MoreTypeToTheme)}];
    
    if (isShowReport) {
        
        [tempMoreInfoArray addObject:@{@"title" : @"举报" , @"image" : @"infor_popshare_report_nor" , @"highlightedImage" : @"infor_popshare_report_pre" , @"type" : @(MoreTypeToReport)}];
    }
    
    [tempMoreInfoArray addObject:@{@"title" : @"字体设置" , @"image" : @"infor_popshare_wordsize_nor" , @"highlightedImage" : @"infor_popshare_wordsize_pre" , @"type" : @(MoreTypeToFontSize)}];
    
    [tempMoreInfoArray addObject:@{@"title" : @"复制链接" , @"image" : @"infor_popshare_copylink_nor" , @"highlightedImage" : @"infor_popshare_copylink_pre" , @"type" : @(MoreTypeToCopyLink)}];
    
    
    _moreInfoArray = tempMoreInfoArray;
}

#pragma mark - 初始化子视图

- (void)initSubview{
    
    //初始化背景视图
    
    _backGroundView = [[UIView alloc] init];
    
    _backGroundView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    
    [self addSubview:_backGroundView];
    
    //初始化分享滑动视图
    
    _shareScrollView = [[UIScrollView alloc] init];
    
    _shareScrollView.backgroundColor = [UIColor clearColor];
    
    _shareScrollView.bounces = YES;
    
    _shareScrollView.showsVerticalScrollIndicator = NO;
    
    _shareScrollView.showsHorizontalScrollIndicator = NO;
    
    [_backGroundView addSubview:_shareScrollView];
    
    //循环初始化分享按钮
    
    for (NSDictionary *info in _shareInfoArray) {
        
        //初始化按钮
        
        ShareButton *button = [ShareButton buttonWithType:UIButtonTypeCustom];
        
        [button configTitle:info[@"title"] Image:[UIImage imageNamed:info[@"image"]]];
        
        [button setImage:[UIImage imageNamed:info[@"highlightedImage"]] forState:UIControlStateHighlighted];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_shareScrollView addSubview:button];
        
        [_shareButtonArray addObject:button];

    }
    
    //初始化完成按钮
    
    _finishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_finishButton setTitle:@"取消" forState:UIControlStateNormal];
    
    [_finishButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_finishButton setBackgroundColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0f]];
    
    [_finishButton addTarget:self action:@selector(finishButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_finishButton.layer setBorderColor:[[UIColor grayColor] colorWithAlphaComponent:0.2f].CGColor];
    
    [_finishButton.layer setBorderWidth:0.5f];
    
    [_backGroundView addSubview:_finishButton];
    
    //判断是否显示更多
    
    if (isShowMore) {
        
        //初始化分隔线视图
        
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2f];
        
        [_backGroundView addSubview:_lineView];
        
        //初始化分享滑动视图
        
        _moreScrollView = [[UIScrollView alloc] init];
        
        _moreScrollView.backgroundColor = [UIColor clearColor];
        
        _moreScrollView.bounces = YES;
        
        _moreScrollView.showsVerticalScrollIndicator = NO;
        
        _moreScrollView.showsHorizontalScrollIndicator = NO;
        
        [_backGroundView addSubview:_moreScrollView];
        
        //循环初始化更多按钮
        
        for (NSDictionary *info in _moreInfoArray) {
            
            //初始化按钮
            
            ShareButton *button = [ShareButton buttonWithType:UIButtonTypeCustom];
            
            [button configTitle:info[@"title"] Image:[UIImage imageNamed:info[@"image"]]];
            
            [button setImage:[UIImage imageNamed:info[@"highlightedImage"]] forState:UIControlStateHighlighted];
            
            [button.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(moreButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [_moreScrollView addSubview:button];
            
            [_moreButtonArray addObject:button];
        }
        
    }
    
}


#pragma mark - 设置自动布局

- (void)configAutoLayout{
    
    CGFloat height = 185;
    
    CGFloat buttonMargin = 20;
    
    //设置背景视图
    
    _backGroundView.sd_layout
    .topEqualToView(self)
    .leftEqualToView(self)
    .rightEqualToView(self);
    
    //设置分享滑动视图
    
    _shareScrollView.sd_layout
    .topSpaceToView(_backGroundView , 20)
    .leftEqualToView(_backGroundView)
    .rightEqualToView(_backGroundView)
    .heightIs(100);
    
    //循环设置分享按钮
    
    for (UIButton *button in _shareButtonArray) {
        
        if (_shareButtonArray.firstObject == button) {
        
            button.sd_layout
            .topEqualToView(_shareScrollView)
            .leftSpaceToView(_shareScrollView , 20)
            .widthIs(60.0f)
            .bottomEqualToView(_shareScrollView);
            
        } else {
            
            button.sd_layout
            .topEqualToView(_shareScrollView)
            .leftSpaceToView(_shareButtonArray[[_shareButtonArray indexOfObject:button] - 1] , buttonMargin)
            .widthIs(60.0f)
            .bottomEqualToView(_shareScrollView);
            
        }
        
    }
    
    [_shareScrollView setupAutoContentSizeWithRightView:_shareButtonArray.lastObject rightMargin:20];
    
    
    if (isShowMore) {
        
        //设置分隔线视图
        
        _lineView.sd_layout
        .topSpaceToView(_shareScrollView , 10)
        .leftSpaceToView(_backGroundView , 30)
        .rightSpaceToView(_backGroundView , 30)
        .heightIs(0.5f);
        
        //设置更多滑动视图
        
        _moreScrollView.sd_layout
        .topSpaceToView(_lineView , 10)
        .leftEqualToView(_backGroundView)
        .rightEqualToView(_backGroundView)
        .heightIs(100);
        
        //循环设置更多按钮
        
        for (UIButton *button in _moreButtonArray) {
            
            if (_moreButtonArray.firstObject == button) {
                
                button.sd_layout
                .topEqualToView(_moreScrollView)
                .leftSpaceToView(_moreScrollView , 20)
                .widthIs(60.0f)
                .bottomEqualToView(_moreScrollView);
                
            } else {
                
                button.sd_layout
                .topEqualToView(_moreScrollView)
                .leftSpaceToView(_moreButtonArray[[_moreButtonArray indexOfObject:button] - 1] , buttonMargin)
                .widthIs(60.0f)
                .bottomEqualToView(_moreScrollView);
                
            }
            
        }
        
        [_moreScrollView setupAutoContentSizeWithRightView:_moreButtonArray.lastObject rightMargin:20];
        
        _finishButton.sd_layout
        .topSpaceToView(_moreScrollView , 20)
        .leftEqualToView(_backGroundView)
        .rightEqualToView(_backGroundView)
        .heightIs(45.0f);
        
        height = 305;
        
    } else {
        
        _finishButton.sd_layout
        .topSpaceToView(_shareScrollView , 20)
        .leftEqualToView(_backGroundView)
        .rightEqualToView(_backGroundView)
        .heightIs(45.0f);
        
    }
    
    [_backGroundView setupAutoHeightWithBottomView:_finishButton bottomMargin:0.0f];
    
    self.height = height;
}

#pragma mark - 分享按钮点击事件

- (void)shareButtonAction:(UIButton *)sender{
    
    __weak typeof(self) weakSelf = self;
    
    //关闭LEEActionSheet
    
    [LEEActionSheet closeCustomActionSheetWithCompletionBlock:^{
        
        if (!weakSelf) return;
       
        NSInteger index = [weakSelf.shareButtonArray indexOfObject:sender];
        
        ShareType type = (ShareType)[weakSelf.shareInfoArray[index][@"type"] integerValue];
        
        if (weakSelf.OpenShareBlock) {
            
            weakSelf.OpenShareBlock(type);
        }

    }];
    
}

#pragma mark - 更多按钮点击事件

- (void)moreButtonAction:(UIButton *)sender{
    
    __weak typeof(self) weakSelf = self;
    
    //关闭LEEActionSheet
    
    [LEEActionSheet closeCustomActionSheetWithCompletionBlock:^{
        
        if (!weakSelf) return;
        
        NSInteger index = [weakSelf.moreButtonArray indexOfObject:sender];
        
        MoreType type = (MoreType)[weakSelf.moreInfoArray[index][@"type"] integerValue];
        
        if (weakSelf.OpenMoreBlock) {
            
            weakSelf.OpenMoreBlock(type);
        }
        
        if (type == MoreTypeToFontSize) {
            
            FontSizeView *fontSizeView = [[FontSizeView alloc] init];
            
            [fontSizeView show];
        }
        
    }];
    
}

#pragma mark - 完成按钮点击事件

- (void)finishButtonAction:(UIButton *)sender{
    
    [LEEActionSheet closeCustomActionSheet];
}

#pragma mark - 显示

- (void)show{
    
    [LEEActionSheet actionSheet].custom.config
    .LeeCustomView(self)
    .LeeCustomActionSheetMaxWidth(CGRectGetWidth([[UIScreen mainScreen] bounds]))
    .LeeCustomActionSheetBottomMargin(0.0f)
    .LeeCustomTopSubViewMargin(0.0f)
    .LeeCustomBottomSubViewMargin(0.0f)
    .LeeCustomCornerRadius(0.0f)
    .LeeCustomActionSheetTouchClose()
    .LeeAddQueue(NO)
    .LeeShow();

}

@end
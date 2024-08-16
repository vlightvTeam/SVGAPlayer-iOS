//
//  SecondViewController.m
//  SVGAPlayer
//
//  Created by jqy on 2024/7/3.
//  Copyright © 2024 UED Center. All rights reserved.
//

#import "SecondViewController.h"
#import "SVGARequestCacheTool.h"
#import "SVGA.h"
#import "SVGAPlayer+LoadData.h"
@interface SecondViewController ()
@property (strong, nonatomic) SVGAPlayer *bPlayer;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _bPlayer = [[SVGAPlayer alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    [self.view addSubview:_bPlayer];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.bPlayer setVideoItemWithURLString:@"https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/EmptyState.svga?raw=true"];
    });
    __weak SecondViewController *wekbPlayer = self;
    [self dataTaskWithcompletionBlock:^(SVGAVideoEntity * item) {
        wekbPlayer.bPlayer.videoItem = item;
        [wekbPlayer.bPlayer startAnimation];
        [wekbPlayer test];
    } failureBlock:^(NSError * error) {
       
    }];
}

- (void)dataTaskWithcompletionBlock:(void (^)(SVGAVideoEntity * _Nullable))completionBlock failureBlock:(void (^)(NSError * _Nullable))failureBlock  {
    BOOL isContains = [SVGARequestCacheTool.sharedInstance containsAddHandlerWithKey:@"kkkkkkkk" completionBlock:completionBlock failureBlock:failureBlock];
    if (isContains) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        SVGAParser *parser = SVGAParser.new;
        [parser parseWithURL:[NSURL URLWithString:@"https://cdn.jsdelivr.net/gh/svga/SVGA-Samples@master/EmptyState.svga?raw=true"] completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
            [SVGARequestCacheTool.sharedInstance handleCompletionWithKey:@"kkkkkkkk" item:videoItem];
        } failureBlock:^(NSError * _Nullable error) {
            
        }];
    });
}

- (void)test {
    NSLog(@"llllllllllll333333333%@",self.bPlayer);
}

- (void)dealloc {
    NSLog(@"shhshshhshshshshhs");
}

@end

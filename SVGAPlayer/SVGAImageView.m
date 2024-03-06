//
//  SVGAImageView.m
//  SVGAPlayer
//
//  Created by 崔明辉 on 2017/10/17.
//  Copyright © 2017年 UED Center. All rights reserved.
//

#import "SVGAImageView.h"
#import "SVGAParser.h"
#import "SVGAPlayer+LoadData.h"
@interface SVGAImageView()
@property(nonatomic, strong)SVGAParser *sharedParser;
@end

@implementation SVGAImageView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _sharedParser = [SVGAParser new];
        _sharedParser.enabledMemoryCache = YES;
        _autoPlay = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _sharedParser = [SVGAParser new];
        _sharedParser.enabledMemoryCache = YES;
        _autoPlay = YES;
    }
    return self;
}

- (void)setEnabledMemoryCache:(BOOL)enabledMemoryCache {
    _sharedParser.enabledMemoryCache = enabledMemoryCache;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    if ([imageName hasPrefix:@"http://"] || [imageName hasPrefix:@"https://"]) {
        [self setVideoItemWithURLString:imageName];
    } else {
        [self setVideoItemWithName:imageName];
    }
}

- (void)setVideoItemWithName:(NSString *)name {
    __weak typeof(self) weakSelf = self;
    [self loadVideoItemWithName:name completionBlock:^(SVGAVideoEntity * _Nullable videoItem, NSError * _Nullable error) {
        [weakSelf setVideoItem:videoItem];
        if (videoItem && weakSelf.autoPlay) {
            [weakSelf startAnimation];
        }
    }];
}

- (void)loadVideoItemWithName:(NSString *)name
              completionBlock:(void (^)(SVGAVideoEntity * _Nullable, NSError * _Nullable))completionBlock{
    [_sharedParser parseWithNamed:name inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        completionBlock(videoItem, nil);
    } failureBlock:^(NSError * _Nonnull error) {
        completionBlock(nil, error);
    }];
}

- (void)setVideoItemWithURLString:(NSString *)urlString {
    [self setVideoItemWithURL:[NSURL URLWithString:urlString]];
}

- (void)loadVideoItemWithURLString:(NSString *)urlString
                   completionBlock:(void (^)(SVGAVideoEntity * _Nullable, NSError * _Nullable))completionBlock{
    [self loadVideoItemWithURL:[NSURL URLWithString:urlString] completionBlock:completionBlock];
}

- (void)setVideoItemWithURL:(NSURL *)url {
    __weak typeof(self) weakSelf = self;
    [self loadVideoItemWithURL:url completionBlock:^(SVGAVideoEntity * _Nullable videoItem, NSError * _Nullable error) {
        [weakSelf setVideoItem:videoItem];
        if (videoItem && weakSelf.autoPlay) {
            [weakSelf startAnimation];
        }
    }];
}

- (void)loadVideoItemWithURL:(NSURL *)url
             completionBlock:(void (^)(SVGAVideoEntity * _Nullable, NSError * _Nullable))completionBlock {
    [_sharedParser parseCacheWithURL:url completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
        completionBlock(videoItem, nil);
    } failureBlock:^(NSError * _Nullable error) {
        completionBlock(nil, error);
    }];
}

@end

//
//  SVGAPlayer+LoadData.m
//  SVGAPlayer
//
//  Created by jqy on 2024/3/4.
//  Copyright © 2024 UED Center. All rights reserved.
//

#import "SVGAPlayer+LoadData.h"
#import "SVGA.h"
@implementation SVGAPlayer (LoadData)

- (void)setVideoItemWithName:(nonnull NSString *)name {
    __weak typeof(self) weakSelf = self;
    [self loadVideoItemWithName:name completionBlock:^(SVGAVideoEntity * _Nullable videoItem, NSError * _Nullable error) {
        if (videoItem != nil) {
            [weakSelf setVideoItem:videoItem];
            [weakSelf startAnimation];
        }
    }];
}

- (void)loadVideoItemWithName:(NSString *)name
              completionBlock:(void (^)(SVGAVideoEntity * _Nullable, NSError * _Nullable))completionBlock {
    SVGAParser *parser = [[SVGAParser alloc] init];
    parser.enabledMemoryCache = YES;
    [parser parseWithNamed:name inBundle:nil completionBlock:^(SVGAVideoEntity * _Nonnull videoItem) {
        completionBlock(videoItem, nil);
    } failureBlock:^(NSError * _Nonnull error) {
        completionBlock(nil, error);
    }];
}

- (void)setVideoItemWithURLString:(nonnull NSString *)urlString {
    [self setVideoItemWithURL:[NSURL URLWithString:urlString]];
}

- (void)loadVideoItemWithURLString:(NSString *)urlString
                   completionBlock:(void (^)(SVGAVideoEntity * _Nullable, NSError * _Nullable))completionBlock {
    [self loadVideoItemWithURL:[NSURL URLWithString:urlString] completionBlock:completionBlock];
}

- (void)setVideoItemWithURL:(NSURL *)url {
    __weak typeof(self) weakSelf = self;
    [self loadVideoItemWithURL:url completionBlock:^(SVGAVideoEntity * _Nullable videoItem, NSError * _Nullable error) {
        if (videoItem != nil) {
            [weakSelf setVideoItem:videoItem];
            [weakSelf startAnimation];
        }
    }];
}

- (void)loadVideoItemWithURL:(NSURL *)url
             completionBlock:(void (^)(SVGAVideoEntity * _Nullable, NSError * _Nullable))completionBlock {
    SVGAParser *parser = [[SVGAParser alloc] init];
    parser.enabledMemoryCache = YES;
    [parser parseCacheWithURL:url completionBlock:^(SVGAVideoEntity * _Nullable videoItem) {
        completionBlock(videoItem, nil);
    } failureBlock:^(NSError * _Nullable error) {
        completionBlock(nil, error);
    }];
}


@end

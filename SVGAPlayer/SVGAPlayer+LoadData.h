//
//  SVGAPlayer+LoadData.h
//  SVGAPlayer
//
//  Created by jqy on 2024/3/4.
//  Copyright © 2024 UED Center. All rights reserved.
//

#import "SVGAPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVGAPlayer (LoadData)

/// 加载本地资源
- (void)setVideoItemWithName:(NSString *)name;

/// 加载本地资源 - 回调
- (void)loadVideoItemWithName:(NSString *)name
              completionBlock:(void (^)(SVGAVideoEntity *_Nullable videoItem, NSError *_Nullable error))completionBlock;

/// 加载资源链接
- (void)setVideoItemWithURL:(NSURL *)url;

/// 加载资源链接 - 回调
- (void)loadVideoItemWithURL:(NSURL *)url
             completionBlock:(void (^)(SVGAVideoEntity *_Nullable videoItem, NSError *_Nullable error))completionBlock;

/// 加载资源链接（字符串）
- (void)setVideoItemWithURLString:(NSString *)urlString;

/// 加载资源链接（字符串） - 回调
- (void)loadVideoItemWithURLString:(NSString *)urlString
                   completionBlock:(void (^)(SVGAVideoEntity *_Nullable videoItem, NSError *_Nullable error))completionBlock;

@end

NS_ASSUME_NONNULL_END

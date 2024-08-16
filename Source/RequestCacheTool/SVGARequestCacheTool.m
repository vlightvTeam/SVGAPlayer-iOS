//
//  SVGARequestCacheTool.m
//  SVGAPlayer
//
//  Created by jqy on 2024/7/2.
//  Copyright © 2024 UED Center. All rights reserved.
//

#import "SVGARequestCacheTool.h"
#import "SVGASyncMutableDictionary.h"
#include <CoreGraphics/CGBase.h>

@interface SVGARequestCacheTool ()
@property (nonatomic, strong) SVGASyncMutableDictionary <NSString *, NSMutableArray *>*cacheDictionary;
@end

@implementation SVGARequestCacheTool

static SVGARequestCacheTool *_shardManager = nil;

+(instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shardManager = [[SVGARequestCacheTool alloc] init];
        _shardManager.cacheDictionary = [[SVGASyncMutableDictionary alloc] init];
    });
    return _shardManager;
}


- (BOOL)containsAddHandlerWithKey:(NSString *)key
                  completionBlock:(nonnull void (^)(SVGAVideoEntity * _Nullable))completionBlock
                     failureBlock:(nonnull void (^)(NSError * _Nullable))failureBlock {
    BOOL isContains = NO;
    NSMutableArray *array = [_cacheDictionary objectForKey:key];
    if (array == nil) {
        array = NSMutableArray.array;
    }
    if (array.count > 0) {
        isContains = YES;
    }
    SVGARequestBlockHandler *handler = SVGARequestBlockHandler.new;
    handler.completionBlock = completionBlock;
    handler.failureBlock = failureBlock;
    [array addObject:handler];
    [_cacheDictionary setObject:array forKey:key];
    return isContains;
}

- (void)removeHandlersWithKey:(NSString *)key {
    [_cacheDictionary removeObjectForKey:key];
}

- (void)handleFailureWithKey:(NSString *)key error:(NSError *_Nullable)error {
    NSArray *array = [_cacheDictionary objectForKey:key];
    for (SVGARequestBlockHandler *handler in array) {
        if (handler.failureBlock) {
            handler.failureBlock(error);
        }
    }
    [self removeHandlersWithKey:key];
}

- (void)handleCompletionWithKey:(NSString *)key item:(SVGAVideoEntity *_Nullable)videoItem {
    NSArray *array = [_cacheDictionary objectForKey:key];
    for (SVGARequestBlockHandler *handler in array) {
        if (handler.completionBlock) {
            handler.completionBlock(videoItem);
        }
    }
    [self removeHandlersWithKey:key];
}

@end


@implementation SVGARequestBlockHandler
@end

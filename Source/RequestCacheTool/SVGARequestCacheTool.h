//
//  SVGARequestCacheTool.h
//  SVGAPlayer
//
//  Created by jqy on 2024/7/2.
//  Copyright © 2024 UED Center. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SVGAVideoEntity;

NS_ASSUME_NONNULL_BEGIN

@interface SVGARequestCacheTool : NSObject
+(instancetype)sharedInstance;

- (BOOL)containsAddHandlerWithKey:(NSString *)key
                  completionBlock:(void (^)(SVGAVideoEntity * _Nullable videoItem))completionBlock
                     failureBlock:(void (^)(NSError * _Nullable error))failureBlock;

- (void)handleCompletionWithKey:(NSString *)key item:(SVGAVideoEntity *_Nullable)videoItem;

- (void)handleFailureWithKey:(NSString *)key error:(NSError *_Nullable)error;

- (void)removeHandlersWithKey:(NSString *)key;

@end

@interface SVGARequestBlockHandler : NSObject
@property(nonatomic, copy) void ( ^completionBlock)(SVGAVideoEntity * _Nullable videoItem);
@property(nonatomic, copy) void ( ^failureBlock)(NSError * _Nullable error);
@end

NS_ASSUME_NONNULL_END

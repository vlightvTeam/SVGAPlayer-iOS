//
//  SVGASyncMutableDictionary.m
//  GoChat
//
//  Created by zegomjf on 2021/11/8.
//  Copyright © 2021 zego. All rights reserved.
//

#import "SVGASyncMutableDictionary.h"
@interface SVGASyncMutableDictionary ()
@property(nonatomic, strong) NSMutableDictionary *dictionary;
@property(nonatomic, strong) dispatch_queue_t dispatchQueue;
@end
@implementation SVGASyncMutableDictionary

- (instancetype)init {
    if (self = [super init]) {
        _dictionary = [NSMutableDictionary new];
        _dispatchQueue = dispatch_queue_create("com.SVGARequestSyncMutableDictionary.SycmutableDictionary", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (NSArray * _Nonnull)allKeys{
    __block NSArray *allKeys = [NSArray array];
    dispatch_sync(_dispatchQueue, ^{
        allKeys = [_dictionary allKeys];
    });
    return allKeys;
}

- (NSArray *)allValues{
  __block NSArray *allValues = [NSArray array];
  dispatch_sync(_dispatchQueue, ^{
    allValues = [_dictionary allValues];
  });
  return allValues;
}

- (BOOL)containsObjectForKey:(id)key {
    if (!key) return NO;
    return _dictionary[key] != nil;
}

- (nullable id)objectForKey:(_Nonnull id)aKey{
    __block id returnObject = nil;
    if(!aKey) return returnObject;
    dispatch_sync(_dispatchQueue, ^{
        returnObject = _dictionary[aKey];
    });
    return returnObject;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key {
    if(!key) return;
    dispatch_barrier_async(_dispatchQueue, ^{
        [_dictionary setValue:value forKey:key];
    });
}

- (nullable id)valueForKey:(_Nonnull id)aKey{
    __block id returnObject = nil;
    dispatch_sync(_dispatchQueue, ^{
        returnObject = [_dictionary valueForKey:aKey];
    });
    return returnObject;
}

- (void)setObject:(nullable id)anObject forKey:(_Nonnull id <NSCopying>)aKey{
    dispatch_barrier_async(_dispatchQueue, ^{
        if (anObject == nil) return;
        if (aKey == nil) return;
        self.dictionary[aKey] = anObject;
    });
}

- (void)removeObjectForKey:(_Nonnull id)aKey{
    if(!aKey) return;
    dispatch_sync(_dispatchQueue, ^{
        [_dictionary removeObjectForKey:aKey];
    });
}

- (void)removeAllObjects {
    dispatch_sync(_dispatchQueue, ^{
        [_dictionary removeAllObjects];
    });
}

- (NSMutableDictionary *)getDictionary {
    __block NSMutableDictionary *temp;
    dispatch_sync(_dispatchQueue, ^{
        temp = _dictionary;
    });
    return temp;
}


-(NSString *)description{
    return [NSString stringWithFormat:@"%@",self.dictionary];
}

@end

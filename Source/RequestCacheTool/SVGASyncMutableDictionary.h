//
//  SVGASyncMutableDictionary.h
//  GoChat
//
//  Created by zegomjf on 2021/11/8.
//  Copyright © 2021 zego. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SVGASyncMutableDictionary<__covariant KeyType, __covariant ObjectType> : NSObject
- (nullable ObjectType)objectForKey:(_Nonnull KeyType)aKey;

- (nullable ObjectType)valueForKey:(_Nonnull KeyType)aKey;

- (NSArray<KeyType> * _Nonnull)allKeys;

- (NSArray<ObjectType> * _Nonnull)allValues;

- (void)setObject:(nullable ObjectType)anObject forKey:(_Nonnull KeyType <NSCopying>)aKey;

- (void)removeObjectForKey:(_Nonnull KeyType)aKey;

- (void)removeAllObjects;

- (NSMutableDictionary *_Nonnull)getDictionary;

- (BOOL)containsObjectForKey:(KeyType)key ;
@end

NS_ASSUME_NONNULL_END

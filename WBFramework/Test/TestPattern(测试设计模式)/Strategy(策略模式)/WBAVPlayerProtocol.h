//
//  WBAVPlayerProtocol.h
//  WBFramework
//
//  Created by apple on 2018/9/25.
//  Copyright © 2018年 wayneking. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WBAVPlayerProtocol <NSObject>
- (NSString *)a_play;
- (NSString *)a_pause;
- (NSString *)a_stop;
@end

NS_ASSUME_NONNULL_END

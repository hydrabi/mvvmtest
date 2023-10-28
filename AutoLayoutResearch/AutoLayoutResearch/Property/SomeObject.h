//
//  SomeObject.h
//  AutoLayoutResearch
//
//  Created by 毕志锋 on 2023/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SomeObject : NSObject
@property (nonatomic,strong) NSArray<NSString*> * _Nullable arr;
@property (nonatomic,strong,nullable) NSDictionary <NSString*,NSString*> *dic;
@end

NS_ASSUME_NONNULL_END

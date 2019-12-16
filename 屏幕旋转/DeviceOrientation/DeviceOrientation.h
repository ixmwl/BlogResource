/**
 * 作者：LC
 * 创建时间：2019/12/16 11:25
 * 版本：[1.0, 2019/12/16]
 * 版权：LC
 * 描述：使用陀螺仪监控屏幕旋转
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol DeviceOrientationDelegate <NSObject>

- (void)directionChange:(UIInterfaceOrientation)direction;

@end
@interface DeviceOrientation : NSObject

@property(nonatomic,strong)id<DeviceOrientationDelegate>delegate;

- (instancetype)initWithDelegate:(id<DeviceOrientationDelegate>)delegate;
/**
 开启监听
 */
- (void)startMonitor;
/**
 结束监听，请stop
 */
- (void)stop;
@end

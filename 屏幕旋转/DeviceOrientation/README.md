## 导入头文件


```
#import "DeviceOrientation.h"
```

## 协议


```
@interface ViewController ()<DeviceOrientationDelegate>

@end
```

## 初始化


```
//定义一个全局
@implementation PZPreviewViewController{
    DeviceOrientation *deviceOrientation;
}

然后ViewDidLoad初始化
deviceOrientation = [[DeviceOrientation alloc] initWithDelegate:self];
```

## 开启/关闭


```
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [deviceOrientation startMonitor];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [deviceOrientation stop];
}
```

## 代理实现


```
-(void)directionChange:(UIInterfaceOrientation)direction{
    [self setOrientation:direction];
}
```


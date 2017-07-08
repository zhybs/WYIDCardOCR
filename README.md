# WYIDCardOCR

## 介绍
完整的身份证正反面、银行卡通过光学识别读取

可自动快速读出身份证上的信息
身份证：（姓名、性别、民族、住址、身份证号码）并截取到身份证正反面图像
银行卡：（卡号，银行名称）并截取到银行卡图像

![WYIDCardOCR-拍照正面](https://github.com/unseim/WYIDCardOCR/WYIDCardOCR/master/Image/拍照正面.png?raw=true)
![WYIDCardOCR-拍照反面](https://github.com/unseim/WYIDCardOCR/WYIDCardOCR/master/Image/拍照反面.png?raw=true)
![WYIDCardOCR-读取正面](https://github.com/unseim/WYIDCardOCR/WYIDCardOCR/master/Image/读取正面.png?raw=true)
![WYIDCardOCR-读取反面](https://github.com/unseim/WYIDCardOCR/WYIDCardOCR/master/Image/读取反面.png?raw=true)
![WYIDCardOCR-卡凹槽正面](https://github.com/unseim/WYIDCardOCR/WYIDCardOCR/master/Image/卡凹槽正面.png?raw=true)
![WYIDCardOCR-卡平滑正面](https://github.com/unseim/WYIDCardOCR/WYIDCardOCR/master/Image/卡平滑正面.png?raw=true)
![WYIDCardOCR-卡读取](https://github.com/unseim/WYIDCardOCR/WYIDCardOCR/master/Image/卡读取.png?raw=true)


## 使用

1、在你的项目的Info.plist文件中，添加权限描述（Key   Value）

Privacy - Camera Usage Description      是否允许访问相机

Privacy - Photo Library Usage Description       是否允许访问相册

2、运行程序，可能会报 ENABLE_BITCODE 错误：

![ENABLE_BITCODE Error](https://github.com/unseim/WYIDCardOCR/WYIDCardOCR/master/Image/错误.png?raw=true)

解决方法：

在TARGETS 中的 Buid Setting 下找到 Enable Bitcode 将其设置为NO。

3、在你的项目中的相应处倒入头文件：

`#import "WYIDScanViewController.h"`

`在使用该功能的地方：`

`WYIDScanViewController *VC = [[WYIDScanViewController alloc] initWithCarInfo: 扫描的类型  ];`

`[self.navigationController VC animated:YES];`


扫描成功回调：

`[VC scanDidFinishCarInfo:^(CardType status, WYScanResultModel *scanModel) {`


`}];`

4、使用真机，大功告成! 


## 特别感谢
本代码参考自[mxl123/IDAndBankCard](https://github.com/mxl123/IDAndBankCard)，非常感谢[mxl123](https://github.com/mxl123)大神的开源！


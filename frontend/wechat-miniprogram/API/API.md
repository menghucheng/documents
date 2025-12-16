# 微信小程序API

## 1. API概述

微信小程序提供了丰富的API，开发者可以通过这些API调用微信客户端的各种功能，实现与微信生态的深度集成。API覆盖了网络请求、数据存储、地理位置、设备信息、媒体、界面交互、开放接口等多个方面。

### 1.1 API分类

小程序API主要分为以下几类：

- **网络API**：用于发送网络请求、上传下载文件等
- **存储API**：用于本地数据存储和管理
- **地理位置API**：用于获取和操作地理位置信息
- **设备API**：用于获取设备信息、系统信息、传感器数据等
- **媒体API**：用于处理图片、音频、视频等媒体资源
- **界面API**：用于控制小程序界面，如弹窗、导航、动画等
- **开放接口**：用于调用微信开放功能，如登录、支付、分享等
- **云开发API**：用于调用微信云开发的各种功能

### 1.2 API调用方式

小程序API的调用方式通常为：

```javascript
wx.apiName({
  parameter1: value1,
  parameter2: value2,
  success: function(res) {
    // 调用成功回调
  },
  fail: function(err) {
    // 调用失败回调
  },
  complete: function() {
    // 调用完成回调（无论成功或失败都会执行）
  }
});
```

## 2. 网络API

### 2.1 wx.request

发送网络请求，用于与后端服务器进行数据交互。

**参数说明**：
- `url`：请求的URL地址
- `method`：HTTP请求方法，默认为`GET`
- `data`：请求的参数
- `header`：请求头
- `dataType`：返回的数据类型，默认为`json`
- `responseType`：响应的数据类型，默认为`text`

**使用示例**：

```javascript
wx.request({
  url: 'https://api.example.com/data',
  method: 'POST',
  data: {
    page: 1,
    limit: 10
  },
  header: {
    'content-type': 'application/json',
    'Authorization': 'Bearer ' + token
  },
  success: function(res) {
    console.log('请求成功', res.data);
  },
  fail: function(err) {
    console.error('请求失败', err);
  },
  complete: function() {
    console.log('请求完成');
  }
});
```

### 2.2 wx.uploadFile

上传文件到服务器。

**参数说明**：
- `url`：上传地址
- `filePath`：要上传文件的本地路径
- `name`：文件对应的 key，服务器端通过该 key 获取文件
- `formData`：其他额外的表单数据

**使用示例**：

```javascript
wx.chooseImage({
  count: 1,
  success: function(res) {
    const tempFilePath = res.tempFilePaths[0];
    
    wx.uploadFile({
      url: 'https://api.example.com/upload',
      filePath: tempFilePath,
      name: 'file',
      formData: {
        'user': 'test'
      },
      success: function(res) {
        const data = JSON.parse(res.data);
        console.log('上传成功', data);
      }
    });
  }
});
```

### 2.3 wx.downloadFile

从服务器下载文件。

**参数说明**：
- `url`：下载资源的URL地址
- `header`：HTTP请求头
- `filePath`：指定文件下载后存储的路径

**使用示例**：

```javascript
wx.downloadFile({
  url: 'https://example.com/image.jpg',
  success: function(res) {
    const filePath = res.tempFilePath;
    console.log('下载成功', filePath);
    
    // 保存到相册
    wx.saveImageToPhotosAlbum({
      filePath: filePath,
      success: function() {
        wx.showToast({
          title: '保存成功',
          icon: 'success'
        });
      }
    });
  }
});
```

## 3. 存储API

### 3.1 wx.setStorage/wx.setStorageSync

将数据存储在本地缓存中。

**参数说明**：
- `key`：本地缓存中的指定的 key
- `data`：需要存储的内容

**使用示例**：

```javascript
// 异步存储
wx.setStorage({
  key: 'userInfo',
  data: {
    name: '张三',
    age: 25
  },
  success: function() {
    console.log('存储成功');
  }
});

// 同步存储
try {
  wx.setStorageSync('userInfo', {
    name: '张三',
    age: 25
  });
  console.log('存储成功');
} catch (e) {
  console.error('存储失败', e);
}
```

### 3.2 wx.getStorage/wx.getStorageSync

从本地缓存中获取数据。

**参数说明**：
- `key`：本地缓存中的指定的 key

**使用示例**：

```javascript
// 异步获取
wx.getStorage({
  key: 'userInfo',
  success: function(res) {
    console.log('获取成功', res.data);
  }
});

// 同步获取
try {
  const userInfo = wx.getStorageSync('userInfo');
  console.log('获取成功', userInfo);
} catch (e) {
  console.error('获取失败', e);
}
```

### 3.3 wx.removeStorage/wx.removeStorageSync

从本地缓存中删除指定 key 对应的内容。

**参数说明**：
- `key`：本地缓存中的指定的 key

**使用示例**：

```javascript
// 异步删除
wx.removeStorage({
  key: 'userInfo',
  success: function() {
    console.log('删除成功');
  }
});

// 同步删除
try {
  wx.removeStorageSync('userInfo');
  console.log('删除成功');
} catch (e) {
  console.error('删除失败', e);
}
```

### 3.4 wx.clearStorage/wx.clearStorageSync

清理本地缓存。

**使用示例**：

```javascript
// 异步清理
wx.clearStorage({
  success: function() {
    console.log('清理成功');
  }
});

// 同步清理
try {
  wx.clearStorageSync();
  console.log('清理成功');
} catch (e) {
  console.error('清理失败', e);
}
```

## 4. 地理位置API

### 4.1 wx.getLocation

获取当前的地理位置、速度。

**参数说明**：
- `type`：坐标系类型，可选值为 `wgs84`（GPS坐标系）或 `gcj02`（国测局坐标系）
- `altitude`：是否需要高度信息，默认不返回
- `success`：调用成功的回调函数

**使用示例**：

```javascript
wx.getLocation({
  type: 'gcj02',
  altitude: true,
  success: function(res) {
    const latitude = res.latitude; // 纬度
    const longitude = res.longitude; // 经度
    const speed = res.speed; // 速度，单位m/s
    const altitude = res.altitude; // 高度，单位m
    const accuracy = res.accuracy; // 位置精度
    
    console.log('位置信息', res);
  }
});
```

### 4.2 wx.openLocation

使用微信内置地图查看位置。

**参数说明**：
- `latitude`：纬度
- `longitude`：经度
- `scale`：缩放比例，范围5-18，默认为16
- `name`：位置名称
- `address`：地址的详细说明

**使用示例**：

```javascript
wx.openLocation({
  latitude: 39.908823,
  longitude: 116.397470,
  scale: 18,
  name: '天安门',
  address: '北京市东城区东长安街'
});
```

### 4.3 wx.chooseLocation

打开地图选择位置。

**参数说明**：
- `latitude`：默认纬度
- `longitude`：默认经度
- `success`：调用成功的回调函数

**使用示例**：

```javascript
wx.chooseLocation({
  success: function(res) {
    const name = res.name; // 位置名称
    const address = res.address; // 详细地址
    const latitude = res.latitude; // 纬度
    const longitude = res.longitude; // 经度
    
    console.log('选择的位置', res);
  }
});
```

## 5. 设备API

### 5.1 wx.getSystemInfo/wx.getSystemInfoSync

获取系统信息。

**使用示例**：

```javascript
// 异步获取
wx.getSystemInfo({
  success: function(res) {
    console.log('系统信息', res);
    // 常用系统信息
    const brand = res.brand; // 设备品牌
    const model = res.model; // 设备型号
    const system = res.system; // 操作系统版本
    const version = res.version; // 微信版本号
    const screenWidth = res.screenWidth; // 屏幕宽度
    const screenHeight = res.screenHeight; // 屏幕高度
    const windowWidth = res.windowWidth; // 可使用窗口宽度
    const windowHeight = res.windowHeight; // 可使用窗口高度
    const pixelRatio = res.pixelRatio; // 设备像素比
  }
});

// 同步获取
try {
  const systemInfo = wx.getSystemInfoSync();
  console.log('系统信息', systemInfo);
} catch (e) {
  console.error('获取系统信息失败', e);
}
```

### 5.2 wx.getNetworkType

获取网络类型。

**返回值说明**：
- `networkType`：网络类型，可选值为 `wifi`、`2g`、`3g`、`4g`、`5g`、`unknown`、`none`

**使用示例**：

```javascript
wx.getNetworkType({
  success: function(res) {
    const networkType = res.networkType;
    console.log('网络类型', networkType);
    
    if (networkType === 'none') {
      wx.showToast({
        title: '当前无网络连接',
        icon: 'none'
      });
    }
  }
});
```

### 5.3 wx.onNetworkStatusChange

监听网络状态变化。

**回调参数**：
- `isConnected`：当前是否有网络连接
- `networkType`：网络类型

**使用示例**：

```javascript
// 监听网络状态变化
wx.onNetworkStatusChange(function(res) {
  console.log('网络状态变化', res);
  
  if (res.isConnected) {
    wx.showToast({
      title: '网络已连接',
      icon: 'success'
    });
  } else {
    wx.showToast({
      title: '网络已断开',
      icon: 'none'
    });
  }
});
```

## 6. 媒体API

### 6.1 wx.chooseImage

从相册选择图片或使用相机拍照。

**参数说明**：
- `count`：最多可以选择的图片张数，默认9
- `sizeType`：所选的图片的尺寸，可选值为 `original`（原图）、`compressed`（压缩图）
- `sourceType`：选择图片的来源，可选值为 `album`（从相册选择）、`camera`（使用相机）

**使用示例**：

```javascript
wx.chooseImage({
  count: 3,
  sizeType: ['compressed'],
  sourceType: ['album', 'camera'],
  success: function(res) {
    const tempFilePaths = res.tempFilePaths;
    console.log('选择的图片', tempFilePaths);
    
    // 显示图片
    this.setData({
      images: tempFilePaths
    });
  }
});
```

### 6.2 wx.chooseVideo

拍摄视频或从手机相册中选视频。

**参数说明**：
- `sourceType`：视频选择的来源，可选值为 `album`、`camera`
- `maxDuration`：拍摄视频最长拍摄时间，单位秒
- `camera`：默认调起的摄像头，可选值为 `back`、`front`

**使用示例**：

```javascript
wx.chooseVideo({
  sourceType: ['album', 'camera'],
  maxDuration: 60,
  camera: 'back',
  success: function(res) {
    const tempFilePath = res.tempFilePath; // 视频临时文件路径
    const duration = res.duration; // 视频时长
    const size = res.size; // 视频大小
    const height = res.height; // 视频高度
    const width = res.width; // 视频宽度
    
    console.log('选择的视频', res);
  }
});
```

### 6.3 wx.saveImageToPhotosAlbum

保存图片到系统相册。

**参数说明**：
- `filePath`：图片文件路径

**使用示例**：

```javascript
wx.saveImageToPhotosAlbum({
  filePath: 'tempFilePath',
  success: function() {
    wx.showToast({
      title: '保存成功',
      icon: 'success'
    });
  },
  fail: function(err) {
    console.error('保存失败', err);
    wx.showToast({
      title: '保存失败',
      icon: 'none'
    });
  }
});
```

## 7. 界面API

### 7.1 wx.showToast

显示消息提示框。

**参数说明**：
- `title`：提示的内容
- `icon`：图标，可选值为 `success`、`loading`、`none`
- `duration`：提示的延迟时间，默认1500ms
- `mask`：是否显示透明蒙层，防止触摸穿透

**使用示例**：

```javascript
wx.showToast({
  title: '操作成功',
  icon: 'success',
  duration: 2000
});

// 显示加载提示
wx.showToast({
  title: '加载中',
  icon: 'loading',
  duration: 3000,
  mask: true
});
```

### 7.2 wx.showModal

显示模态对话框。

**参数说明**：
- `title`：对话框标题
- `content`：对话框内容
- `showCancel`：是否显示取消按钮，默认true
- `cancelText`：取消按钮文字，默认"取消"
- `confirmText`：确定按钮文字，默认"确定"
- `success`：调用成功的回调函数

**使用示例**：

```javascript
wx.showModal({
  title: '提示',
  content: '确定要删除这条记录吗？',
  success: function(res) {
    if (res.confirm) {
      console.log('用户点击确定');
      // 执行删除操作
    } else if (res.cancel) {
      console.log('用户点击取消');
    }
  }
});
```

### 7.3 wx.showLoading

显示加载提示框，需主动调用 wx.hideLoading 关闭。

**参数说明**：
- `title`：提示的内容
- `mask`：是否显示透明蒙层，防止触摸穿透

**使用示例**：

```javascript
// 显示加载提示
wx.showLoading({
  title: '加载中...',
  mask: true
});

// 模拟异步操作
setTimeout(function() {
  // 关闭加载提示
  wx.hideLoading();
  
  wx.showToast({
    title: '加载完成',
    icon: 'success'
  });
}, 2000);
```

### 7.4 wx.navigateTo/wx.redirectTo/wx.navigateBack

页面导航相关API。

**参数说明**：
- `url`：跳转的页面路径
- `delta`：返回的页面数

**使用示例**：

```javascript
// 保留当前页面，跳转到应用内的某个页面
wx.navigateTo({
  url: '/pages/detail/detail?id=1'
});

// 关闭当前页面，跳转到应用内的某个页面
wx.redirectTo({
  url: '/pages/login/login'
});

// 返回上一页
wx.navigateBack({
  delta: 1
});
```

## 8. 开放接口

### 8.1 wx.login

获取登录凭证（code），用于后续调用微信登录接口。

**使用示例**：

```javascript
wx.login({
  success: function(res) {
    if (res.code) {
      // 发送 code 到后端换取 openId, sessionKey, unionId
      wx.request({
        url: 'https://api.example.com/login',
        data: {
          code: res.code
        },
        success: function(response) {
          // 保存登录信息
          wx.setStorageSync('token', response.data.token);
          wx.setStorageSync('userInfo', response.data.userInfo);
        }
      });
    } else {
      console.error('登录失败', res.errMsg);
    }
  }
});
```

### 8.2 wx.getUserProfile

获取用户信息，需要用户授权。

**参数说明**：
- `desc`：声明获取用户个人信息后的用途，不超过30个字符

**使用示例**：

```javascript
wx.getUserProfile({
  desc: '用于完善会员资料',
  success: function(res) {
    const userInfo = res.userInfo;
    console.log('用户信息', userInfo);
    
    this.setData({
      userInfo: userInfo
    });
  }
});
```

### 8.3 wx.requestPayment

发起微信支付。

**参数说明**：
- `timeStamp`：时间戳
- `nonceStr`：随机字符串
- `package`：统一下单接口返回的 prepay_id 参数值
- `signType`：签名算法，默认为MD5
- `paySign`：签名

**使用示例**：

```javascript
// 从后端获取支付参数
wx.request({
  url: 'https://api.example.com/pay',
  method: 'POST',
  data: {
    orderId: '123456'
  },
  success: function(res) {
    const payParams = res.data;
    
    // 发起支付
    wx.requestPayment({
      timeStamp: payParams.timeStamp,
      nonceStr: payParams.nonceStr,
      package: payParams.package,
      signType: payParams.signType,
      paySign: payParams.paySign,
      success: function() {
        wx.showToast({
          title: '支付成功',
          icon: 'success'
        });
      },
      fail: function(err) {
        console.error('支付失败', err);
        wx.showToast({
          title: '支付失败',
          icon: 'none'
        });
      }
    });
  }
});
```

### 8.4 wx.shareAppMessage

设置分享内容（仅在页面JS中定义，在用户点击分享按钮时触发）。

**使用示例**：

```javascript
// pages/index/index.js
Page({
  // 设置分享内容
  onShareAppMessage: function(res) {
    return {
      title: '我的小程序',
      path: '/pages/index/index?id=123',
      imageUrl: 'https://example.com/share.jpg',
      success: function() {
        console.log('分享成功');
      },
      fail: function() {
        console.error('分享失败');
      }
    };
  }
});
```

## 9. API调用的注意事项

### 9.1 异步API的回调处理

小程序的API大多是异步的，需要在回调函数中处理结果，避免直接在API调用后立即使用结果。

**错误示例**：
```javascript
let userInfo;
wx.getUserProfile({
  desc: '用于完善会员资料',
  success: function(res) {
    userInfo = res.userInfo;
  }
});
console.log(userInfo); // 这里会输出 undefined
```

**正确示例**：
```javascript
wx.getUserProfile({
  desc: '用于完善会员资料',
  success: function(res) {
    const userInfo = res.userInfo;
    console.log(userInfo); // 正确获取用户信息
  }
});
```

### 9.2 权限申请

某些API需要用户授权才能调用，如地理位置、相机、相册等。在调用这些API前，应该先检查用户是否已经授权。

**使用示例**：
```javascript
// 检查位置权限
wx.getSetting({
  success: function(res) {
    if (!res.authSetting['scope.userLocation']) {
      // 未授权，申请授权
      wx.authorize({
        scope: 'scope.userLocation',
        success: function() {
          // 授权成功，调用API
          wx.getLocation({
            success: function(res) {
              console.log('位置信息', res);
            }
          });
        },
        fail: function() {
          // 授权失败
          wx.showToast({
            title: '需要位置权限',
            icon: 'none'
          });
        }
      });
    } else {
      // 已授权，直接调用API
      wx.getLocation({
        success: function(res) {
          console.log('位置信息', res);
        }
      });
    }
  }
});
```

### 9.3 错误处理

在调用API时，应该总是处理失败情况，提供友好的错误提示。

**使用示例**：
```javascript
wx.request({
  url: 'https://api.example.com/data',
  success: function(res) {
    // 处理成功情况
  },
  fail: function(err) {
    // 处理失败情况
    console.error('请求失败', err);
    wx.showToast({
      title: '网络请求失败，请稍后重试',
      icon: 'none'
    });
  }
});
```

### 9.4 API调用频率限制

微信小程序对API调用有频率限制，应该避免频繁调用同一API，尤其是网络请求类API。

**优化建议**：
- 合并多个网络请求
- 缓存API调用结果
- 使用防抖和节流技术
- 避免在页面生命周期函数中频繁调用API

## 10. 总结

微信小程序提供了丰富的API，覆盖了开发过程中的各种需求。掌握这些API的使用方法对于开发高质量的小程序至关重要。

在使用API时，需要注意以下几点：
- 理解API的异步特性，正确处理回调
- 遵守API的调用规则和权限要求
- 合理处理错误情况，提供友好的用户体验
- 注意API调用频率限制，优化性能

通过合理使用微信小程序的API，可以构建出功能丰富、体验良好的小程序应用。
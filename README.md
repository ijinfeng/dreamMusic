## DreamMusic

一款基于开源网易云音乐API创建的音乐项目.

![](https://img.shields.io/badge/Flutter-3.0.5-blue)
![](https://img.shields.io/badge/Dart-2.17.6-blue)


![](https://img.shields.io/badge/%E6%94%AF%E6%8C%81-MacOS-green)
![](https://img.shields.io/badge/%E6%94%AF%E6%8C%81-Windows-green)
![](https://img.shields.io/badge/%E6%94%AF%E6%8C%81-Linux-green)


## 效果图展示
发现页
![发现页](/images/%E5%B0%81%E9%9D%A2%E5%9B%BE.png)


## 已完成的功能介绍

- [x]  登录：手机号密码登录，短信登录，扫码登录
- [x]  发现：每日音乐，推荐音乐
- [x]  音乐播放：在线播放，本地播放，播放列表，音量调节，上一首，下一首切换，播放模式切换
- [x]  音乐下载（JSON+mp3）模式，文件删除监听
- [x]  私人FM
- [x]  我喜欢的音乐
- [x]  我收藏的歌单列表
- [x]  音乐详情页，歌词滚动定位
- [x]  评论列表，发表文字评论


## API接口文档

本项目的数据来源于开源项目[NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)。

## 如何运行调试

### localhost

本项目支持本地服务器运行，如果要本地运行。需要先下载[NeteaseCloudMusicApi](https://github.com/Binaryify/NeteaseCloudMusicApi)项目，并通过`node app.js`跑起来服务端项目，再运行`DreamMusic`项目，不然接口是走不通的哦。


![%E6%88%AA%E5%B1%8F2022-11-01_14.43.50.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cf08badab53a45fb83b6c102b4a340a6~tplv-k3u1fbpfcp-watermark.image?)

### ****Vercel****

注意了`Vercel`运行是要**翻墙**的，我已经在`Vercel`上部署了一个服务，跳到设置页，网络设置，点击切换，选择`https://netease-cloud-music-api-eight-kappa-18.vercel.app`即可。

### 自定义域名

当然你也可以选择自己服务器，选择网络设置，自定义输入即可。


## TODO List

- [ ] 下载支持id3方式
- [ ] 切换为正常播放模式和下载模式，而不是使用外链



# flutter_douban2

这是一个flutter实现的简易版豆瓣客户端，利用现有的[douban API](http://api.douban.com)和[douban网页](https://movie.douban.com)实现电影电视的浏览.

## 实现的功能有：

* 电影
  + 热门推荐
  + 选电影
  + 排行榜
    - 一周口碑电影榜
    - 豆瓣电影Top250
    - 豆瓣电影新片榜
    - 豆瓣电影北美票房榜
    - 豆瓣年度榜单: 2018, 2017, 2016, 2015
    - 豆瓣高分榜: 爱情片, 喜剧片, 剧情片, ......
  + 电影分类
    - 形式, 类型, 地区, 年代, 特色, 排序, 评分
  + 影院热映
  + 即将上映
* 电视
  + 热门, 美剧, 英剧, 韩剧, 日剧, ......
  + 排序: 推荐, 评分, 时间
  + 分类找电视
  + 排行榜: 地区, 类型, 播出平台, 2018, 2017, 2016, 2015
* 影视详情
  + 一般信息
  + 评分
  + 分类
  + 简介
  + 剧照
  + 演职员
  + 预告片(播放)、花絮、剧照(保存+分享)
  + 也喜欢
  + 短评
  + 影评(详细)
* 个人简介
  + 简介
  + 主要作品
  + 相册(保存+分享)

## 横屏浏览

## 插件使用

  + [dio](https://pub.dev/packages/dio) 网络访问
  + [html](https://pub.dev/packages/html) Dom解析
  + [carousel_slider](https://pub.dev/packages/carousel_slider) Banner实现
  + [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) 屏幕适配
  + [cached_network_image](https://pub.dev/packages/cached_network_image) 图片缓存
  + [photo_view](https://pub.dev/packages/photo_view) 相册浏览
  + [video_player](https://pub.dev/packages/video_player) 视频播放
  + [chewie](https://pub.dev/packages/chewie) 视频播放
  + [flutter_range_slider](https://pub.dev/packages/flutter_range_slider) Slider控件
  + [flutter_html](https://pub.dev/packages/flutter_html) html内容显示
  + [url_launcher](https://pub.dev/packages/url_launcher) Launch URL
  + [provider](https://pub.dev/packages/provider) State管理
  + [share](https://pub.dev/packages/share) 图片url分享
  + [image_picker_saver](https://pub.dev/packages/image_picker_saver) 图片保存
  + [fluttertoast](https://pub.dev/packages/fluttertoast) 消息提示

## Setup

### Clone Repo

$ git clone https://github.com/cnlinqh/flutter_douban2.git
$ cd flutter_douban2

### Run

$ flutter run

## Videos

* [movie.mp4](https://github.com/cnlinqh/flutter_douban2/tree/master/video/movie.mp4)
* [tv.mp4](https://github.com/cnlinqh/flutter_douban2/tree/master/video/tv.mp4)
* [subject.mp4](https://github.com/cnlinqh/flutter_douban2/tree/master/video/subject.mp4)
* [orientation.mp4](https://github.com/cnlinqh/flutter_douban2/tree/master/video/orientation.mp4)

## Screenshots

* 01_豆瓣电影.png
![01_豆瓣电影.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/01_豆瓣电影.png)
* 02_选电影.png
![02_选电影.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/02_选电影.png)

* 03_豆瓣榜单.png
![03_豆瓣榜单.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/03_豆瓣榜单.png)
* 04_年度榜单.png
![04_年度榜单.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/04_年度榜单.png)
* 05_榜单列表.png
![05_榜单列表.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/05_榜单列表.png)
* 06_榜单列表2.png
![06_榜单列表2.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/06_榜单列表2.png)
* 07_分类影视.png
![07_分类影视.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/07_分类影视.png)
* 08_分类影视2.png
![08_分类影视2.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/08_分类影视2.png)
* 09_分类影视3.png
![09_分类影视3.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/09_分类影视3.png)
* 10_影院热映.png
![10_影院热映.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/10_影院热映.png)
* 11_即将上映.png
![11_即将上映.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/11_即将上映.png)
* 12_豆瓣电视剧.png
![12_豆瓣电视剧.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/12_豆瓣电视剧.png)
* 13_豆瓣电视剧2.png
![13_豆瓣电视剧2.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/13_豆瓣电视剧2.png)
* 14_豆瓣电视剧3.png
![14_豆瓣电视剧3.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/14_豆瓣电视剧3.png)
* 15_选电视剧.png
![15_选电视剧.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/15_选电视剧.png)
* 16_选电视剧2.png
![16_选电视剧2.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/16_选电视剧2.png)
* 17_电影详情.png
![17_电影详情.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/17_电影详情.png)
* 18_预告片.png
![18_预告片.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/18_预告片.png)
* 19_短评.png
![19_短评.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/19_短评.png)
* 20_影评.png
![20_影评.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/20_影评.png)
* 21_影评2.png
![21_影评2.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/21_影评2.png)
* 22_个人简介.png
![22_个人简介.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/22_个人简介.png)
* 23_个人相册.png
![23_个人相册.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/23_个人相册.png)
* 24_个人相册2.png
![24_个人相册2.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/24_个人相册2.png)
* 25_个人相册3.png
![25_个人相册3.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/25_个人相册3.png)
* 26_横屏.png
![26_横屏.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/26_横屏.png)
* 27_横屏2.png
![27_横屏2.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/27_横屏2.png)
* 28_横屏3.png
![28_横屏3.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/28_横屏3.png)
* 29_横屏4.png
![29_横屏4.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/29_横屏4.png)
* 30_横屏5.png
![30_横屏5.png](https://github.com/cnlinqh/flutter_douban2/blob/master/screenshots/30_横屏5.png)

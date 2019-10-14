class LabelConstant {
  static const String MOVIE_PAGE_TITLE = '豆瓣电影';

  static const String MOVIE_ENTRANCE_SELECT_ICON = "选电影";
  static const String MOVIE_ENTRANCE_RANK_ICON = "排行榜";
  static const String MOVIE_ENTRANCE_CATEGORY_ICON = "电影分类";

  static const String MOVIE_IN_THEATERS_TITLE = '影院热映';
  static const String MOVIE_COMING_SOON_TITLE = '即将上映';
  static const String MOVIE_RANK_LIST_TITLE = '豆瓣榜单';

  static const String MOVIE_ALL_TITLE = '全部>';
  static const String MOVIE_NO_RATE = "暂无评分";

  static const String MOVIE_TOP_WEEKLY = "一周口碑电影榜";
  static const String MOVIE_TOP_WEEKLY_SUB = "每周五更新，共10部";
  static const String MOVIE_TOP_TOP250 = "豆瓣电影Top250";
  static const String MOVIE_TOP_TOP250_SUB = "豆瓣榜单，共250部";
  static const String MOVIE_TOP_NEW = "豆瓣电影新片榜";
  static const String MOVIE_TOP_NEW_SUB = "最新新片";
  static const String MOVIE_TOP_US = "豆瓣电影北美票房榜";
  static const String MOVIE_TOP_US_SUB = "北美票房";

  static const String MOVIE_DETAILS_TITLE = "电影详情";
  static const String MOVIE_WANTED_TITLE = '想看';
  static const String MOVIE_WATCHED_TITLE = '看过';
  static const String MOVIE_ALL_PEOPLE = "演职员";
  static const String MOVIE_DIRECTOR = "导演";
  static const String MOVIE_ACTOR = "演员";
  static const String MOVIE_PHOTOS_TITLE = "预告片 / 花絮 / 剧照";
  static const String MOVIE_DOUBAN_RATE = "豆瓣评分";
  static const String MOVIE_TOTAL_RATE = "总评分";
  static const String MOVIE_TAGS_TITLE = "所属频道";
  static const String MOVIE_SUMMARY = "简介";
  static const String MOVIE_FOLD = "收起";
  static const String MOVIE_UNFOLD = "展开";
  static const String MOVIE_VIDEO_TITLE = "预告片/花絮";
  static const String MOVIE_PHOTO_TITLE = "剧照";

  static const String MOVIE_TOP_LIST_YEAR_TITLE = '豆瓣年度榜单';
  static const String MOVIE_YEAR_TOP_DETAILS_TITLE = "年度最高列表";
  static const String MOVIE_RANK_TOP20_LOVE = "爱情片TOP20";
  static const String MOVIE_RANK_TOP20_COMEDY = "喜剧片TOP20";
  static const String MOVIE_RANK_TOP20_STORY = "剧情片TOP20";
  static const String MOVIE_RANK_TOP20_CARTOON = "动画片TOP20";
  static const String MOVIE_RANK_TOP20_FICTION = "科幻片TOP20";
  static const String MOVIE_RANK_TOP20_DOCUMENTARY = "记录片TOP20";
  static const String MOVIE_RANK_TOP20_SHORT = "短片TOP20";
  static const String MOVIE_RANK_TOP20_LGBT = "同性片TOP20";
  static const String MOVIE_RANK_TOP20_MUSICAL = "音乐片TOP20";
  static const String MOVIE_RANK_TOP20_DANCE = "歌舞片TOP20";

  static const String MOVIE_CATEGORY_TITLE = "分类找电影";
  static const String MOVIE_CATEGORY_ALL = "全部";

  static const String MOVIE_SPECIAL_SELF_DEFINE = "+自定义标签";
  static const String MOVIE_CATEGORY_SORTBY = "排序";
  static const String MOVIE_CATEGORY_SORTBY_DEFAULT = "默认";
  static const String MOVIE_CATEGORY_SORTBY_HOT = "热度";
  static const String MOVIE_CATEGORY_SORTBY_RATE = "评分";
  static const String MOVIE_CATEGORY_SORTBY_TIME = "时间";
  static const String MOVIE_CATEGORY_RANGE_RATE = "评分";
  static var sStyleList = {
    "label": "类型",
    "list": [
      "全部",
      "剧情",
      "喜剧",
      "动作",
      "爱情",
      "科幻",
      "动画",
      "悬疑",
      "惊悚",
      "恐怖",
      "犯罪",
      "同性",
      "音乐",
      "歌舞",
      "传记",
      "历史",
      "战争",
      "西部",
      "奇幻",
      "冒险",
      "灾难",
      "武侠",
      "情色"
    ],
  };
  static var sCountriesList = {
    "label": "地区",
    "list": [
      "全部",
      "中国大陆",
      "美国",
      "中国香港",
      "中国台湾",
      "日本",
      "韩国",
      "英国",
      "法国",
      "德国",
      "意大利",
      "西班牙",
      "印度",
      "泰国",
      "俄罗斯",
      "伊朗",
      "加拿大",
      "澳大利亚",
      "爱尔兰",
      "瑞典",
      "巴西",
      "丹麦"
    ],
  };
  static var sYearList = {
    "label": "年代",
    "list": [
      "全部",
      "2019",
      "2018",
      "2010年代",
      "2000年代",
      "90年代",
      "80年代",
      "70年代",
      "60年代",
      "更早"
    ],
  };
  static var sSpecialList = {
    "label": "特色",
    "list": [
      "全部",
      "经典",
      "青春",
      "文艺",
      "搞笑",
      "励志",
      "魔幻",
      "感人",
      "女性",
      "黑帮",
      MOVIE_SPECIAL_SELF_DEFINE
    ],
  };
  static void resetSpecialList() {
    sSpecialList = {
      "label": "特色",
      "list": [
        "全部",
        "经典",
        "青春",
        "文艺",
        "搞笑",
        "励志",
        "魔幻",
        "感人",
        "女性",
        "黑帮",
        MOVIE_SPECIAL_SELF_DEFINE
      ],
    };
  }

  static void addOneSpecial(special) {
    resetSpecialList();
    List list = sSpecialList['list'];
    list.insert(list.length - 1, special);
  }

  static const String MOVIE_CHOOSE_TOPIC = "专题";
  static const String MOVIE_CHOOSE_TOPIC_HOT = "豆瓣热门";
  static const String MOVIE_CHOOSE_TOPIC_NEW = "最新电影";
  static const String MOVIE_CHOOSE_TOPIC_COOL = "冷门佳片";
  static const String MOVIE_CHOOSE_TOPIC_HIGH = "豆瓣高分";
  static const String MOVIE_CHOOSE_TOPIC_CLASSIC = "经典电影";
  static const List MOVIE_CHOOSE_TOPIC_LIST = [
    MOVIE_CHOOSE_TOPIC_HOT,
    MOVIE_CHOOSE_TOPIC_NEW,
    MOVIE_CHOOSE_TOPIC_COOL,
    MOVIE_CHOOSE_TOPIC_HIGH,
    MOVIE_CHOOSE_TOPIC_CLASSIC
  ];
  static const String MOVIE_CHOOSE_TYPE = "类型";
  static const List MOVIE_CHOOSE_TYPE_LIST = [
    "喜剧",
    "动作",
    "爱情",
    "科幻",
    "动画",
    "纪录片",
    "悬疑",
    "犯罪",
    "奇幻",
    "歌舞",
    "同性",
  ];
  static const String MOVIE_CHOOSE_PLACE = "地区";
  static const List MOVIE_CHOOSE_PLACE_LIST = [
    "中国大陆",
    "美国",
    "中国香港",
    "日本",
    "韩国",
    "中国台湾",
    "英国",
    "法国",
    "德国",
  ];
  static const String MOVIE_CHOOSE_SPEICAL = "特色";
  static const List MOVIE_CHOOSE_SPEICAL_LIST = [
    "青春",
    "治愈",
    "文艺",
    "女性",
    "小说改编",
    "超级英雄",
    "美食",
    "宗教",
    "励志",
  ];
}

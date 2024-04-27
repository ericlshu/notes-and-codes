drop TABLE `tbl_book`;

CREATE TABLE `tbl_book` (
  `id` Integer NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=UTF8MB4;

select * from tbl_book;

insert into tbl_book (type,name,description) values ('社会小说','人世间','第十届茅盾文学奖获奖作品，人世间（套装共3册）雷佳音宋辛柏青宋佳佳殷桃等主演同名电视剧');
insert into tbl_book (type,name,description) values ('官场小说','沧浪之水','豆瓣8.5分，入围茅盾文学奖。职场小白、考公人的启蒙之书');
insert into tbl_book (type,name,description) values ('外国小说','百年孤独','新版典藏内封。马尔克斯代表作，惟一正式中文版，未作任何删节，发行量超800万册');
insert into tbl_book (type,name,description) values ('科幻小说','三体全集','《三体》第73届世界科幻雨果奖获奖作品，银河奖特别奖，入选教育部《中小学生阅读指导目录（2020年版）》，刘慈欣十届银河奖得主2');
insert into tbl_book (type,name,description) values ('历史小说','曾国藩','唐浩明全新修订百余处细节，首部姚雪垠长篇历史小说奖获奖作品！从晚清重臣之沉浮，看中华国运之兴衰！');
insert into tbl_book (type,name,description) values ('名著小说','四大名著','西游记+红楼梦+水浒传+三国演义（全四册 精装彩色插图珍藏本 附赠精美书签）');
insert into tbl_book (type,name,description) values ('纪实文学','苦难辉煌','金一南教授授权，无删减全新修订增补版 获“中国出版政府奖”');
insert into tbl_book (type,name,description) values ('名家作品','活着','精装版，余华代表作，易烊千玺推荐阅读 2021新版，随机赠珍藏复刻手稿');
insert into tbl_book (type,name,description) values ('外国小说','挪威的森林','村上春树的残酷青春物语，纪念《挪威的森林》问世30周年');
insert into tbl_book (type,name,description) values ('文学理论','叙事的虚构性','当代学术棱镜译丛：叙事的虚构性：有关历史、文学和理论的论文（1957-2007）');
insert into tbl_book (type,name,description) values ('文学作品','你当像鸟飞往你的山','中文版销量超200万册，比尔·盖茨年度特别推荐！登顶《纽约时报》畅销榜80+周，这本书比你听说的还要好！');
insert into tbl_book (type,name,description) values ('戏剧文学','雷雨','中小学必读，东方的莎士比亚');
insert into tbl_book (type,name,description) values ('民间文学','古希腊神话与传说','世界名著小说，高中甫德文原版直译，随书附赠古希腊神谱卡 中小学生阅读书单');
insert into tbl_book (type,name,description) values ('悬疑推理','盗墓笔记','南派三叔盗墓悬疑经典之作，畅销百万册盗墓悬疑经典之作，全9册典藏升级版震撼来袭，南北各派盗墓术语秘技大揭密，当前盗墓小说狂潮的始作俑者之一！');
insert into tbl_book (type,name,description) values ('悬疑推理','福尔摩斯探案集','青少年初中生必读小学生课外阅读书籍儿童文学读物 像名侦探一样思考学习推理');
insert into tbl_book (type,name,description) values ('悬疑推理','白夜行','东野圭吾作品无冕之·王。我一直走在白夜里，从来就没有太阳，所以不怕失去。');
insert into tbl_book (type,name,description) values ('悬疑推理','解忧杂货店','东野圭吾代表作，1000万册纪念版，写给拥有无尽梦想与烦恼的你。现代人内心流失的东西，这家杂货店能帮你找回。东野圭吾特别寄语中国读者。');
insert into tbl_book (type,name,description) values ('悬疑推理','无人生还','阿加莎·克里斯蒂 无人生还（精装纪念新版）');
insert into tbl_book (type,name,description) values ('散文随笔','遥远的救世主+背叛+天幕红尘','聪蝶 遥远的救世主+背叛+天幕红尘 豆豆三部曲 未删减版可单选 遥远的救世主+天幕红尘+背叛 全三册');
insert into tbl_book (type,name,description) values ('散文随笔','时间从来不语，却回答了所有问题','季羡林写给年轻人的生命礼物！与大师共语，品味人生百态。活得通透，过得舒心，顺逆总平常，得失在人心。人民日报倡导的生活态度！');
insert into tbl_book (type,name,description) values ('散文随笔','心安即是归处','跨四代共读心灵读本，一本书阅尽大师智慧精华！人生最好状态就是活得清醒、坦荡、真实。季羡林写给万千迷茫的青年一代！愿你历尽沧桑，永葆天真模样');
insert into tbl_book (type,name,description) values ('散文随笔','有本事','继《无所畏》后暌违三年，冯唐全新作品。44篇全新智慧之作+10幅金句书法+35幅私人摄影作品！一个人有本事才是靠得住的财富。随书附赠2张冯唐字画书签！');
insert into tbl_book (type,name,description) values ('散文随笔','皮囊','直面人生的终极问题，刻在骨头里的故事，容纳既失去家乡又未到达远方的生命。');
insert into tbl_book (type,name,description) values ('散文随笔','瓦尔登湖','央视朗读者第二期朗读书目，清华大学校长推荐版本。译者李继宏作12822字导读');


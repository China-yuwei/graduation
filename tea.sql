/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 8.0.12 : Database - tea
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`tea` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `tea`;

/*Table structure for table `t_admin` */

DROP TABLE IF EXISTS `t_admin`;

CREATE TABLE `t_admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` char(20) NOT NULL,
  `admin_password` char(20) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `t_admin` */

LOCK TABLES `t_admin` WRITE;

insert  into `t_admin`(`admin_id`,`admin_name`,`admin_password`) values (1,'admin','admin');

UNLOCK TABLES;

/*Table structure for table `t_admin_tool` */

DROP TABLE IF EXISTS `t_admin_tool`;

CREATE TABLE `t_admin_tool` (
  `at_name` char(20) DEFAULT NULL,
  `at_icon` varchar(100) DEFAULT NULL,
  `at_background` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_admin_tool` */

LOCK TABLES `t_admin_tool` WRITE;

insert  into `t_admin_tool`(`at_name`,`at_icon`,`at_background`) values ('商品','../../static/admin-img/shangpinguanli.png','background-image: linear-gradient(to bottom right, rgba(255, 148, 26, 0.8), rgba(255, 148, 26, 1))'),('店铺','../../static/admin-img/dianpuguanli_1.png','background-image: linear-gradient(to bottom right,rgba(107, 190, 18, 0.8), rgba(107, 190, 18, 1))'),('订单','../../static/admin-img/dingdanguanli.png','background-image: linear-gradient(to bottom right, rgba(56, 56, 255, 0.8), rgba(56, 56, 255, 1))'),('用户','../../static/admin-img/chakanyonghu.png','background-image: linear-gradient(to bottom right, rgba(255, 33, 252, 0.8), rgba(255, 33, 252, 1))'),('发现','../../static/admin-img/faxian.png','background-image: linear-gradient(to bottom right, rgba(255, 46, 74, 0.8), rgba(255, 46, 74, 1))'),('新增商家','../../static/admin-img/dianpuguanli.png','background-image: linear-gradient(to bottom right, rgba(12, 171, 31, 0.8), rgba(12, 171, 31, 1))'),('新增发现','../../static/admin-img/xinzeng.png','background-image: linear-gradient(to bottom right, rgba(255, 195, 75, 0.6), rgba(255, 195, 75, 1))'),('发布商品','../../static/admin-img/fabu.png','background-image: linear-gradient(to bottom right, rgba(255, 92, 43, 0.8), rgba(255, 92, 43, 1))'),('用户收藏','../../static/admin-img/wodeshoucang.png','background-image: linear-gradient(to bottom right, rgba(138, 60, 255, 0.8), rgba(138, 60, 255, 0.8))'),('用户关注','../../static/admin-img/wodeguanzhu.png','background-image: linear-gradient(to bottom right, rgba(51, 179, 204, 0.8), rgba(51, 179, 204, 1))');

UNLOCK TABLES;

/*Table structure for table `t_commentary` */

DROP TABLE IF EXISTS `t_commentary`;

CREATE TABLE `t_commentary` (
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `fi_id` int(11) DEFAULT NULL,
  `g_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` char(20) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `s_name` char(20) DEFAULT NULL,
  `c_time` char(20) DEFAULT NULL,
  `c_content` varchar(255) DEFAULT NULL,
  `c_shou` int(11) DEFAULT NULL,
  `c_zan` int(11) DEFAULT NULL,
  UNIQUE KEY `c_id` (`c_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_commentary` */

LOCK TABLES `t_commentary` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_coupon` */

DROP TABLE IF EXISTS `t_coupon`;

CREATE TABLE `t_coupon` (
  `user_id` int(11) DEFAULT NULL,
  `c_id` int(11) NOT NULL AUTO_INCREMENT,
  `c_money` int(11) DEFAULT NULL,
  `c_full` int(11) DEFAULT NULL,
  `c_time` char(20) DEFAULT NULL,
  `c_date` int(11) DEFAULT NULL,
  `c_endTime` char(20) DEFAULT NULL,
  UNIQUE KEY `c_id` (`c_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `t_coupon` */

LOCK TABLES `t_coupon` WRITE;

UNLOCK TABLES;

/*Table structure for table `t_envelope` */

DROP TABLE IF EXISTS `t_envelope`;

CREATE TABLE `t_envelope` (
  `user_id` int(11) DEFAULT NULL,
  `e_name` char(20) DEFAULT NULL,
  `e_money` char(20) DEFAULT NULL,
  `e_type` char(20) DEFAULT NULL,
  `e_time` char(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_envelope` */

LOCK TABLES `t_envelope` WRITE;

insert  into `t_envelope`(`user_id`,`e_name`,`e_money`,`e_type`,`e_time`) values (7,'每日领取红包','0.89','1','2020-06-05 14:07:18'),(7,'每日领取红包','0.37','1','2020-06-03 14:08:04'),(7,'每日领取红包','0.20','1','2020-06-04 14:17:13'),(7,'红包抵扣','0.95','0','2020-06-04 14:44:17'),(7,'每日领取红包','0.38','1','2020-06-02 15:08:30'),(7,'每日领取红包','0.97','1','2020-06-07 13:08:35'),(7,'红包抵扣','3.76','0','2020-06-07 14:25:08');

UNLOCK TABLES;

/*Table structure for table `t_favorites` */

DROP TABLE IF EXISTS `t_favorites`;

CREATE TABLE `t_favorites` (
  `f_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `g_id` int(11) DEFAULT NULL,
  `g_name` char(30) DEFAULT NULL,
  `g_price` char(30) DEFAULT NULL,
  `g_src` varchar(100) DEFAULT NULL,
  UNIQUE KEY `f_id` (`f_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `t_favorites` */

LOCK TABLES `t_favorites` WRITE;

insert  into `t_favorites`(`f_id`,`user_id`,`g_id`,`g_name`,`g_price`,`g_src`) values (16,7,14,'白牡丹','35.8','../../static/images/white/05.jpg');

UNLOCK TABLES;

/*Table structure for table `t_find` */

DROP TABLE IF EXISTS `t_find`;

CREATE TABLE `t_find` (
  `find_id` int(11) NOT NULL AUTO_INCREMENT,
  `f_name` char(20) DEFAULT NULL,
  `f_icon` varchar(100) DEFAULT NULL,
  UNIQUE KEY `find_id` (`find_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_find` */

LOCK TABLES `t_find` WRITE;

insert  into `t_find`(`find_id`,`f_name`,`f_icon`) values (1,'茶叶','../../static/images01/f1.jpg'),(2,'泡茶','../../static/images01/f2.jpg'),(3,'品茶','../../static/images01/f3.jpg'),(4,'鉴茶','../../static/images01/f4.jpg'),(5,'茶道历史','../../static/images01/f5.jpg'),(6,'茶与健康','../../static/images01/f6.jpg'),(7,'茶饮礼仪','../../static/images01/f7.jpg'),(8,'制茶','../../static/images01/f8.jpg'),(9,'茶具','../../static/images01/f9.jpg'),(10,'茶俗文化','../../static/images01/f10.jpg');

UNLOCK TABLES;

/*Table structure for table `t_find_info` */

DROP TABLE IF EXISTS `t_find_info`;

CREATE TABLE `t_find_info` (
  `fi_id` int(11) NOT NULL AUTO_INCREMENT,
  `find_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fi_name` varchar(100) DEFAULT NULL,
  `fi_src` varchar(100) DEFAULT NULL,
  `fi_time` char(20) DEFAULT NULL,
  `fi_status` char(20) DEFAULT NULL,
  `fi_type` char(20) DEFAULT NULL,
  `fi_content` varchar(10000) DEFAULT NULL,
  `o_id` int(11) DEFAULT NULL,
  `fi_person` int(11) DEFAULT NULL,
  `fi_s_time` char(20) DEFAULT NULL,
  `fi_srcb` varchar(100) DEFAULT NULL,
  `fi_srcc` varchar(100) DEFAULT NULL,
  UNIQUE KEY `fi_id` (`fi_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `t_find_info` */

LOCK TABLES `t_find_info` WRITE;

insert  into `t_find_info`(`fi_id`,`find_id`,`user_id`,`fi_name`,`fi_src`,`fi_time`,`fi_status`,`fi_type`,`fi_content`,`o_id`,`fi_person`,`fi_s_time`,`fi_srcb`,`fi_srcc`) values (2,3,7,'不得不知的品茶小知识！ ','../../static/images/new/find-01.jpeg','2020-06-04 16:56:51','已读','通知信息','1、沏茶的要领 好茶、好水、好茶具，还要掌握好的泡茶技术，才能真正得到一杯好茶。 2、一杯茶该泡几次 茶叶的耐泡程度除与嫩度有关外，主要决定于茶叶加工的方法。初制过程中把茶叶切碎，茶汁就容易冲泡出来，粗、老、完整的茶叶，茶汁冲泡出来的速度就慢。 3、四季饮茶有区别 饮茶讲究四季有别，即：春饮花茶，夏饮绿茶，秋饮青茶，冬饮红茶。其道理在于：春季，人饮花茶，可以散发…饮红茶最为理想。红茶味甘性温，含有丰富的蛋白质，能助消化，补身体，使人体强壮。 4、每日饮茶2～6克 虽然茶叶中含有多种维生素和氨基酸，饮茶对于清油解腻，增强神经兴奋以及消食利尿具有一定的作用，但并不是喝得越多越好，也不是所有的人都适合饮茶。一般来说，每天1—2次，每次2—3克的饮量是比较适当的，对于患有神经衰弱、失眠、甲状腺机能亢进、结核病、心脏病、胃病、肠溃疡的病人都不适合饮茶，哺乳期及怀孕妇女和婴幼儿也不宜饮茶。 5、不饮用过浓的茶 浓茶会使人体“兴奋性”过度增高，对心血管系统、神经系统等造成不利影响。有心血管疾患的人在饮用浓茶后可能出现心跳过速，甚至心律不齐，造成病情反复。 6、临睡前不饮茶 这点对于初期饮茶者更为重要。很多人睡前饮茶后，入睡变得非常困难，甚至严重影响次日的精神状态。有神经衰弱或失眠症的人,尤应注意。',NULL,2,'2020-06-05 14:04:14','../../static/images/new/find_02.jpeg','../../static/images/new/find_03.jpeg'),(3,1,7,'普洱百科','../../static/images/new/find_04.jpg','2020-06-04 18:10:54','未读','通知信息','1、形态特征 大乔木，高达16米，胸径90厘米，嫩枝有微毛，顶芽有白柔毛。叶薄革质，椭圆形，长8-14厘米，宽3.5-7.5厘米，先端锐尖，基部楔形，上面干后褐绿色，略有光泽，下面浅绿色，中肋上有柔毛，其余被短柔毛，老叶变秃;侧脉8-9对，在上面明显，在下面突起，网脉在上下两面均能见，边缘有细锯齿，叶柄5-7毫米，被柔毛。花腋生，直径2.5-3厘米，花柄长6-8毫米，被柔毛。苞片2，早落。萼片5，近圆形，长3-4毫米，外面无毛。花瓣6-7片，倒卵形，长1-1.8厘米，无毛。雄蕊长8-10毫米，离生，无毛。子房3室，被茸毛;花柱长8毫米，先端3裂。蒴果扁三角球形，直径约2厘米，3爿裂开，果爿厚1-1.5毫米。种子每室1个，近圆形，直径1厘米。 2、品饮技巧 普洱茶既可清饮，也可混饮。清饮指不加任何辅料来冲泡，多见于汉族;混饮是指于在茶中添加辅料，多见于香港、台湾，如香港在普洱茶中加入菊花、枸杞、西洋参等养生食料。品饮普洱茶必须趁热闻香，举杯鼻前，此时即可感受陈味芳香如泉涌般扑鼻而来，其高雅沁心之感，不在幽兰清菊之下。普洱茶需用心品茗，啜饮入口，始能得其真韵，虽茶汤入口略感苦涩，但待茶汤于喉舌间略作停留时，即可感受茶汤穿透牙缝、沁渗齿龈，并由舌根产生甘津送回舌面，此时满口芳香，甘露生津，令人神清气爽，而且津液四溢，持久不散不渴，此乃品茗之最佳感受。 3、饮茶禁忌 普洱茶随泡随饮，不宜茶水浸泡过久再饮，忌饮隔夜普洱茶。隔夜茶中茶多酚的浸出量会较多，不管茶汤的新鲜度，滋味的好喝程度，保健功效上，还是卫生角度来看，都不宜饮用。饮普洱茶分体质。饮用普洱茶后会出现有点胀气、嗳气，还有便秘的迹象，属于体质不适宜喝普洱类型。忌饭前后大量饮普洱茶。普洱茶在饭后半小时饮用最佳，若饮食过少，普洱也不宜多喝。刚生产的普洱茶不宜多喝。普洱茶宜温饮，不宜烫饮、冷饮;宜长饮，不宜间断;宜兼饮，不宜偏饮;宜淡饮，不宜浓饮。忌饮劣质茶或变质茶，忌饮冲泡次数过多的普洱茶，生茶慎用烹煮法，熟茶可适当煮饮。',NULL,1,'2020-06-05 13:59:49','../../static/images/new/find_06.jpg','../../static/images/new/find_05.jpg'),(5,4,7,'茶叶鉴别方法','../../static/images/new/find_09.jpg','2020-06-04 18:22:52','未读','通知信息','1、色 包括外观的色泽及汤色。新茶外观干硬疏松，色泽新鲜，一般呈嫩绿色。老陈的茶叶则紧缩暗软。选购茶叶时，外观颜色应以纯而泽为好，杂而暗为次。茶叶的汤色以明亮清晰为优，暗而深为劣。 2、香 质量好的茶叶，一般都香味纯正，浸人心脾。若茶叶香味淡薄或根本无香味的，或者有异味的，则不是好茶叶。如茉莉花茶是许多消费者所喜爱的，这种茶有浓郁的茉莉花清香。如无这种香气或有其它气味，则说明该茉莉花茶质量较差。 3、味 是指茶水的滋味。新茶汤色澄清而香气足、陈茶则汤色变褐、香味差。就绿茶、红茶来说，质量好的绿茶口感略带苦涩，饮后又感鲜甜，且回味越久越浓。若苦涩味重，鲜甜味少的则为次茶。红茶口感甜爽为好，苦涩为次。 4、形 指茶叶的外形。各种名茶都有它的外形特征，千姿百态。不同的品种有不同的鉴别方法：有的品种要看它的茸毛多少，多者为优，少者为劣；有的品种要看它的条索松紧，紧者为好，松者为差。质量好的茶叶外形应均匀一致，所含碎茶和杂质少。',NULL,1,'2020-06-05 14:01:16','../../static/images/new/find_08.jpg','../../static/images/new/find_07.jpg'),(6,2,7,'泡茶的基本步骤','../../static/images/new/find_14.jpg','2020-06-06 19:18:33','已读','通知信息','1、温杯 泡茶讲究的是茶壶内外和茶杯都得用热水烧烫，这样既可以净壶，也可以去霉。 2、选茶 茶叶大概有茶壶总量的五分之一或是二分之一左右的放进去，不要放多了，也不要放少了。 3、洗茶 倒入开水后，马上把茶壶中的水倒掉，洗一下茶叶。 4、泡茶 倒入大概80-85摄氏度的水，等待1分钟左右，即可饮用，使用完之后，取出壶盖，壶底朝天，这样可以保护茶具。',NULL,1,'2020-06-07 14:25:38','../../static/images/new/find_10.jpg','../../static/images/new/find_15.jpg'),(7,5,7,'乌龙茶的茶道发展历史','../../static/images/new/find_16.jpg','2020-06-06 19:28:43','未读','通知信息','1、乌龙茶的产生 据《福建之茶》、《福建茶叶民间传说》载清朝雍正年间，在福建省安溪县西坪乡南岩村里有一个退隐将军，也是打猎能手，姓苏名龙，因他长得黝黑健壮，乡亲们都叫他乌龙。一年春天，乌龙腰挂茶篓，身背猎枪上山采茶，采到中午，一头山獐突然从身边溜过，乌龙举枪射击但负伤的山獐拼命逃向山林中，乌龙也随后紧追不舍，终于捕获了猎物，当把山獐背到家时已是掌灯时分，乌龙和全家人忙于宰杀、品尝野味，已将制茶的事全然忘记了。翌日清晨全家人才忙着炒制昨天采回的茶青。没有想到放置了一夜的鲜叶，已镶上了红边了，并散发出阵阵清香，当茶叶制好时，滋味格外清香浓厚，全无往日的苦涩之味，并经心琢磨与反复试验，经过萎雕、摇青、半发酵、烘焙等工序，终于制出了品质优异的茶类新品——乌龙茶。安溪也遂之成了乌龙茶的著名茶乡。 2、乌龙茶的前身 乌龙茶的前身——北苑茶乌龙茶起源于福建，至今已有1000多年的历史。乌龙茶的形成与发展，首先要溯源北苑茶。北苑茶是福建最早的贡茶，也是宋代以后最为著名的茶叶，历史上介绍北苑茶产制和煮饮的著作就有十多种。北苑是福建建瓯凤凰山周围的地区，在唐末已产茶。据《闽通志》载，唐末建安张廷晖雇工在凤凰山开辟山地种茶，初为研膏茶，宋太宗太平兴国二年(977年)已产制龙凤茶，宋真宗(998年)以后改造小团茶，成为名扬天下的龙团凤饼。当时任过福建转运吏，监督制造贡茶的蔡襄，特别称颂北苑茶。北苑茶重要成品属于龙团凤饼，要采得一筐的鲜叶，要经过一天的时间，叶子在筐子里摇荡积压，到晚上才能开始蒸制，这种经过积压的原料无意中就发生了部分红变，芽叶经酶促氧化的部分变成了紫色或褐色，究其实质已属于半发酵了，也就是所谓乌龙茶的范畴。因此，说北苑茶是乌龙茶的前身是有一定科学根据。',NULL,0,'2020-06-05 14:05:16','../../static/images/new/find_17.jpg','../../static/images/new/find-01.jpeg'),(8,6,7,'茶的功效与作用','../../static/images/new/find_03.jpeg','2020-06-06 19:45:04','未读','通知信息','1、绿茶的功效与作用 抗衰老、降血脂、防动脉硬化、降低心血管疾病（绿茶本身含有茶甘宁，茶甘宁是提高血管韧性的，使血管不容易破裂）；瘦身减脂、防龋齿、清口臭、防癌、美白及防紫外线作用；抗菌，具备整肠的功能；可改善消化不良情况，如由细菌引起的急性腹泻，可喝一点绿茶减轻病况。 2、红茶的功效与作用 红茶品性温和、香味醇厚，可以帮助胃肠消化、去油腻、开胃口、助养生,促进食欲,可利尿、消除水肿。有强壮心肌功能。抗菌力强，用红茶漱口可防滤过性病毒引起的感冒，并预防蛀牙与食物中毒，降低血糖值与高血压。红茶功效不逊于绿茶且更有益于心脏。对脾胃虚弱的人来说，喝红茶时加点奶，可以起到一定的温胃作用。 3、黑茶的功效与作用 补充膳食营养、助消化、解油腻、顺肠胃；降脂、减肥、软化人体血管、预防心血管疾病；抗氧化、延缓衰老，延年益寿；抗癌、抗突变、降血压；降血糖，、杀菌、消炎、利尿解毒、降低烟酒毒害。 4、乌龙茶功效与作用 美肤，抵抗衰老：饮用乌龙茶可以使血中维生素C含量持较高水平，尿中维生素C排出量减少。瘦身：不可多得的减肥品。防蛀牙：饭后一杯乌龙，茶中含有的多酚类具有能够抑制齿垢酵素产生的功效。改善皮肤过敏。 5、黄茶的功效与作用 黄茶是沤茶，在沤的过程中，产生的消化酶，可保护脾胃，提高食欲，帮助消化。消化酶能恢复脂肪细胞代谢功能，化除脂肪。黄茶中的茶多酚、氨基酸、可溶糖、维生素等营养物质，防治食道癌。黄茶鲜叶中天然物质保留有85％以上，这些物质能杀菌、消炎。 6、白茶的功效与作用 白茶是一种轻微发酵茶。白茶功效具有三抗（抗辐射、抗氧化、抗肿瘤）三降（降血压、降血脂、降血糖）之保健功效，同时还有养心、养肝、养目、养神、养气、养颜的养身功效。 可治糖尿病、预防脑血管病、降血压、抗病毒提高免疫力。',NULL,0,'2020-06-05 14:07:16','../../static/images/new/find_13.jpg','../../static/images/new/find_07.jpg'),(9,7,7,'喝茶前的基本礼仪','../../static/images/new/004.jpg','2020-06-07 12:47:05','未读','通知信息','1、座位 如今很少人知道客位的尊卑问题，虽然茶道里面讲究的是客随主便一说，不过喝茶的人多了，自然应该遵循这样的原则:面对主人，主人的左手边是尊!顺时针旋转，由尊到卑，直到主人的右手边，不论茶桌上的形式如何，这个是不变的铁律。 2、尊位的第一顺序 老年人、中年人，比自己年龄大的人。其中师长、长者为尊，如果年龄相差不大，女士优先坐尊位。 3、座位方面的特别规定 忌讳对头坐，就是头对头和主人面对面坐!哪怕就是只有你和主人两个人，也不要坐对头的，知礼的客人应该坐主人的右手边的卑位，人多实在避免不了坐对头的情况，小孩来坐这个位子。 4、第一道礼节 客人最重要的礼节是答礼，也称回礼!所谓第一道礼节，是指主人冲泡了第一泡茶品，并且请你品尝的时候，作为客人的第一次回礼。 5、正式的、正规的第一次客人回礼 起身，男性抱拳女性合十，一躬，坐下，双手接过(或者双手捧起茶杯)先闻香，后慢慢缀茶一口，放下茶杯，口中称赞主人。注:抱拳者，右手握拳左手包上去。一躬，躬身行礼。躬身越低，表示对于主人越发尊敬，对于主人是长辈客人是晚辈，躬身应该至少为45度的倾斜角的!',NULL,0,'2020-06-07 12:47:05','../../static/images/new/find_11.jpg','../../static/images/new/find_12.jpg'),(10,7,7,'喝茶礼仪基础','../../static/images/new/find_14.jpg','2020-06-07 12:52:06','未读','通知信息','1、茶具要清洁 客人进屋后，先让座，后备茶。冲茶之前，一定要把茶具洗干净，尤其是久置未用的茶具，难免沾上灰尘、污垢，更要细心地用清水洗刷一遍。在冲茶、倒茶之前最好用开水烫一下茶壶、茶杯。这样，既讲究卫生，又显得彬彬有礼。如果不管茶具干净不干净，胡乱给客人倒茶，这是不礼貌的表现。人家一看到茶壶、茶杯上的斑斑污迹就反胃，怎么还愿意喝你的茶呢?现在一般的公司都是一次性杯子，在倒茶前要注意给一次性杯子套上杯托，以免水热烫手，让客人一时无法端杯喝茶。 2、茶水要适量 放置的茶叶不宜过多，也不宜太少。茶叶过多，茶味过浓;茶叶太少，冲出的茶没啥味道。假如客人主动介绍自己喜欢喝浓茶或淡茶的习惯，那就按照客人的口胃把茶冲好。倒茶时，无论是大杯小杯，都不宜倒得太满，太满了容易溢出，把桌子、凳子、地板弄湿。不小心，还会烫伤自己或客人的手脚，使宾主都很难为情。当然，也不宜倒得太少。倘若茶水只遮过杯底就端给客人，会使人觉得是在装模作样，不是诚心实意。 3、端茶要得法 按照我国人民的传统习惯，只要两手不残废，都是用双手给客人端茶的。但是，现在有的年青人不懂得这个规矩，用一只手把茶递给客人了事。双手端茶也要很注意，对有杯耳的茶杯，通常是用一只手抓住杯耳，另一只手托住杯底，把茶端给客人。没有杯耳的茶杯倒满茶之后周身滚烫，双手不好接近。有的同志不管三七二十一，用五指捏住杯口边缘就往客人面前送。这种端茶方法虽然可以防止烫伤事故发生，但很不雅观，也不够卫生。请试想，让客人的嘴舔主人的手指痕，好受吗? 4、添茶要及时 如果上司和客户的杯子里需要添茶了，你要义不容辞地去给他们添茶。你可以示意服务生来添茶。让服务生把茶壶留在餐桌上，由你自己亲自来添则更好——这是不知道该说什么好的时候最好的掩饰办法。当然，添茶的时候要先给上司和客户添茶，最后再给自己添，这样也体现出自己对上司和客户的尊重。',NULL,0,'2020-06-07 12:52:06','../../static/images/new/find_11.jpg','../../static/images/new/find_17.jpg'),(11,8,7,'铁观音制作工序','../../static/images/new/find_18.jpg',NULL,'未读','通知信息','1、采摘 3月下旬萌芽，一年分四季采制，谷雨至立夏(4月中下旬一5月上旬)为春茶，产量占全年总产量的40-45%；夏至至小暑(6月中下旬一7月上旬)为夏茶，产量占15-20%；立秋至处暑(8月上旬一8月下旬)为暑茶，产量占25-30%；秋分至寒露(9月下旬一10月上旬)为秋茶，产量占25-30%。生长地带不同的茶树鲜叶要分开，特别是早青、午青、晚青要严格分开制造，以午青品质为最优。 2、凉青 鲜叶按标准采收进厂经过凉青后进行晒青。晒青时间以午后4时阳光柔和时为宜，叶子宜薄摊，以失去原有光泽，叶色转暗，手模叶子柔软。顶叶下垂，失重6-9%左右为适度。然后移入室内凉青后进行做青。 3、做青 摇青与摊置相间进行，合称做青。做青技术性高，灵活性强，是决定毛茶品质优劣的关键。摇青使叶子边缘经过摩擦，叶缘细胞受损，再经过摊置，在一定的温度、湿度条件下伴随着叶子水分逐渐丧失，叶中多酚类在酶的作用下缓慢地氧化并引起了一系列化学变化，从而形成乌龙茶的特有品质。 4、炒青 炒青要及时，当做青叶青味消失，香气初露即应抓紧进行。 揉捻、烘焙：铁观音的揉捻是多次反复进行的。初揉约3-4分钟，解块后即行初焙。焙至五、六成干，不粘手时下焙，趁热包揉，运用揉、压、搓、抓、缩等手法，经三揉三焙后，再用50-60℃的文火慢烤，使成品香气敛藏，滋味醇厚，外表色泽油亮，茶条表面凝集有-层白霜。包揉、揉捻与焙火是多次重复进行的。直到外形满意为止。最好才焙火烤干成品。 5、簸拣 慢烤后的茶叶最后经过簸拣，除去梗片、杂质即为成品。',NULL,0,'2020-06-07 13:14:48','../../static/images/new/find-19.jpg','../../static/images/new/find_20.jpg');

UNLOCK TABLES;

/*Table structure for table `t_follow` */

DROP TABLE IF EXISTS `t_follow`;

CREATE TABLE `t_follow` (
  `f_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `shop_name` char(20) DEFAULT NULL,
  `shop_icon` varchar(100) DEFAULT NULL,
  `s_bg` varchar(100) DEFAULT NULL,
  `s_bga` varchar(100) DEFAULT NULL,
  `s_bgb` varchar(100) DEFAULT NULL,
  `s_bgc` varchar(100) DEFAULT NULL,
  UNIQUE KEY `f_id` (`f_id`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `t_follow` */

LOCK TABLES `t_follow` WRITE;

insert  into `t_follow`(`f_id`,`user_id`,`shop_id`,`shop_name`,`shop_icon`,`s_bg`,`s_bga`,`s_bgb`,`s_bgc`) values (29,7,2,'春福润茶叶','../../static/images/shop/02.jpg','../../static/images/shop/05-bg.jpg','../../static/images/shop/02-bga.jpg','../../static/images/shop/02-bgb.jpg','../../static/images/shop/02-bgc.jpg');

UNLOCK TABLES;

/*Table structure for table `t_footprint` */

DROP TABLE IF EXISTS `t_footprint`;

CREATE TABLE `t_footprint` (
  `user_id` int(11) DEFAULT NULL,
  `g_id` int(11) DEFAULT NULL,
  `g_name` char(20) DEFAULT NULL,
  `g_price` char(30) DEFAULT NULL,
  `g_src` varchar(100) DEFAULT NULL,
  `f_time` char(30) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_footprint` */

LOCK TABLES `t_footprint` WRITE;

insert  into `t_footprint`(`user_id`,`g_id`,`g_name`,`g_price`,`g_src`,`f_time`) values (7,2,'嘉年华壹号','99.9','../../static/images/black/black-puer06.jpg','2020-06-06 18:57:39'),(7,13,'白毫银针','72.5','../../static/images/white/04.jpg','2020-06-04 14:36:59'),(7,3,'普洱砖茶','25.0','../../static/images/black/black-zhuan01.jpg','2020-06-03 15:36:03'),(7,1,'普洱方砖','9800.0','../../static/images/black/black-puer08.png','2020-06-03 15:35:03');

UNLOCK TABLES;

/*Table structure for table `t_g_class_child` */

DROP TABLE IF EXISTS `t_g_class_child`;

CREATE TABLE `t_g_class_child` (
  `c_id` int(11) DEFAULT NULL,
  `class_id` int(11) DEFAULT NULL,
  `c_name` char(20) DEFAULT NULL,
  `c_src` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_g_class_child` */

LOCK TABLES `t_g_class_child` WRITE;

insert  into `t_g_class_child`(`c_id`,`class_id`,`c_name`,`c_src`) values (1,1,'普洱茶','../../static/images/black/black-puer01.png'),(2,1,'砖茶','../../static/images/black/zhuan.jpg'),(3,1,'小青桔','../../static/images/black/xiao.jpg'),(4,1,'七子饼茶','../../static/images/black/qi.jpg'),(5,1,'沱茶','../../static/images/black/tuo.jpg'),(6,1,'安化黑茶','../../static/images/black/an.jpg'),(7,1,'老茶头','../../static/images/black/lao.jpg'),(8,1,'六堡茶','../../static/images/black/liu.jpg'),(9,2,'福鼎白茶','../../static/images/white/fu.jpg'),(10,2,'寿眉','../../static/images/white/shou.jpg'),(11,2,'贡眉','../../static/images/white/gong.jpg'),(12,2,'白牡丹','../../static/images/white/bai.jpg'),(13,2,'白毫银针','../../static/images/white/yin.jpg'),(14,2,'政和白茶','../../static/images/white/zheng.jpg'),(15,3,'正山小种','../../static/images/red/zheng.jpg'),(16,3,'金骏眉','../../static/images/red/jin.jpg'),(17,3,'云南滇红','../../static/images/red/yun.jpg'),(18,3,'锡兰红茶','../../static/images/red/xi.jpg'),(19,3,'狗牯脑红茶','../../static/images/red/gou.jpg'),(20,3,'英红九号','../../static/images/red/ying.jpg'),(21,3,'祁门红茶','../../static/images/red/qi.jpg'),(22,4,'龙井','../../static/images/green/long.jpg'),(23,4,'碧螺春','../../static/images/green/bi.jpg'),(24,4,'太平猴魁','../../static/images/green/tai.jpg'),(25,4,'六安瓜片','../../static/images/green/lu.jpg'),(26,4,'狗牯脑绿茶','../../static/images/green/gou.jpg'),(27,4,'雀舌绿茶','../../static/images/green/que.jpg'),(28,4,'黄金茶','../../static/images/green/huang.jpg'),(29,4,'安吉白茶','../../static/images/green/an.jpg'),(30,4,'毛尖','../../static/images/green/mao.jpg'),(31,4,'日照云雾','../../static/images/green/ri.jpg'),(32,4,'高山毛峰','../../static/images/green/gao.jpg'),(33,4,'武平绿茶','../../static/images/green/wu.jpg'),(34,5,'铁观音','../../static/images/oOlong/tie.jpg'),(35,5,'大红袍','../../static/images/oOlong/da.jpg'),(36,5,'肉桂','../../static/images/oOlong/rou.jpg'),(37,5,'永春佛手','../../static/images/oOlong/yong.jpg'),(38,5,'台湾高山茶','../../static/images/oOlong/tai.jpg'),(39,5,'凤凰单枞','../../static/images/oOlong/feng.jpg'),(40,5,'武夷水仙','../../static/images/oOlong/wu.jpg'),(41,5,'漳平水仙','../../static/images/oOlong/zhang.jpg'),(42,6,'玫瑰花茶','../../static/images/flower/mei.jpg'),(43,6,'菊花','../../static/images/flower/ju.png'),(44,6,'甘草','../../static/images/flower/gan.jpg'),(45,7,'黄茶','../../static/images/yellow/huang.jpg'),(46,7,'蒙山黄芽','../../static/images/yellow/meng.jpg'),(47,8,'紫砂茶具','../../static/images/other/ziju.jpg'),(48,8,'玻璃茶具','../../static/images/other/boju.jpg'),(49,8,'陶瓷茶具','../../static/images/other/taoju.jpg'),(50,8,'冰裂茶具','../../static/images/other/bingju.jpg'),(51,8,'玉瓷茶具','../../static/images/other/yuju.jpg'),(52,8,'建盏茶具','../../static/images/other/jianju.jpg'),(53,8,'汝窑茶具','../../static/images/other/ruju.jpg'),(54,8,'单杯','../../static/images/other/danju.jpg'),(55,8,'公道杯','../../static/images/other/gongju.jpg'),(56,9,'电茶壶','../../static/images/other/dianhu.jpg'),(57,9,'紫砂壶','../../static/images/other/zihu.jpg'),(58,9,'铁壶','../../static/images/other/tiehu.jpg'),(59,9,'铜壶','../../static/images/other/tonghu.jpg'),(60,9,'玻璃壶','../../static/images/other/bohu.jpg'),(61,9,'陶瓷壶','../../static/images/other/taohu.jpg'),(62,10,'实木茶盘','../../static/images/other/shipan.jpg'),(63,10,'玉石茶盘','../../static/images/other/yupan.jpg'),(64,10,'电木茶盘','../../static/images/other/dianpan.jpg'),(65,10,'竹制茶盘','../../static/images/other/zhupan.jpg'),(66,10,'陶瓷茶盘','../../static/images/other/taopan.jpg');

UNLOCK TABLES;

/*Table structure for table `t_goods` */

DROP TABLE IF EXISTS `t_goods`;

CREATE TABLE `t_goods` (
  `g_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_id` int(11) DEFAULT NULL,
  `c_id` int(11) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `class_name` char(20) DEFAULT NULL,
  `g_name` char(20) DEFAULT NULL,
  `g_introduce` varchar(100) DEFAULT NULL,
  `g_src` varchar(100) DEFAULT NULL,
  `g_price` char(20) DEFAULT NULL,
  `g_buy_num` int(11) DEFAULT NULL,
  `g_discount` char(20) DEFAULT NULL,
  `g_integral` int(11) DEFAULT NULL,
  `g_num` int(11) DEFAULT NULL,
  UNIQUE KEY `g_id` (`g_id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods` */

LOCK TABLES `t_goods` WRITE;

insert  into `t_goods`(`g_id`,`class_id`,`c_id`,`shop_id`,`class_name`,`g_name`,`g_introduce`,`g_src`,`g_price`,`g_buy_num`,`g_discount`,`g_integral`,`g_num`) values (1,1,1,4,'黑茶','普洱方砖','1996年中茶普洱 普洱方砖 熟茶 250克','../../static/images/black/black-puer08.png','9800.0',8,NULL,NULL,300),(2,1,1,2,'黑茶','嘉年华壹号','2020年双陈普洱 嘉年华壹号 熟茶 357克','../../static/images/black/black-puer06.jpg','99.9',38,'89.0',8900,300),(4,1,2,5,'黑茶','易武老树砖茶','2016年龙园号 易武老树砖茶 生茶 250克','../../static/images/black/black-zhuan02.jpg','79.9',6,NULL,NULL,300),(5,1,2,5,'黑茶','金奖砖茶','2007年龙园号 金奖砖茶 生茶 250克','../../static/images/black/black-zhuan03.png','180.0',18,'136.0',NULL,300),(6,1,4,1,'黑茶','云南七子饼茶 班章','2020年中茶普洱 云南七子饼茶 班章 熟茶 357克','../../static/images/black/black-qi01.jpg','3300.0',0,NULL,NULL,300),(7,1,4,6,'黑茶','云南七子饼茶','2012年六大茶山 云南七子饼茶 生茶 357克','../../static/images/black/black-qi02.jpg','6000.0',10,'5800.0',NULL,300),(8,1,5,7,'黑茶','绿盒甲级沱茶','2001年下关沱茶 甲级沱茶 绿盒 生茶 100克','../../static/images/black/black-t01.jpg','2690.0',2,'2600.0',NULL,300),(9,1,7,1,'黑茶','老茶头砖','2020年中茶普洱 老茶头砖 熟茶 250克','../../static/images/black/black-t03.jpg','188.0',12,NULL,NULL,300),(10,2,9,2,'白茶','白茶园','2018年润元昌 白茶园 生茶 360克','../../static/images/white/01.jpg','99.9',20,NULL,NULL,300),(11,2,11,1,'白茶','白茶园','2013年岁月知味 白茶园 生茶 200克','../../static/images/white/02.jpg','45.0',5,'36.0',3600,300),(12,2,11,2,'白茶','（春）白茶园','2014年彩农茶 （春）白茶园 生茶 200克','../../static/images/white/03.png','68.9',90,NULL,NULL,300),(13,2,13,3,'白茶','白毫银针','2014年彩农茶 白毫银针 生茶 200克','../../static/images/white/04.jpg','72.5',24,'60.0',NULL,300),(14,2,12,3,'白茶','白牡丹','2014年彩农茶 白牡丹 生茶 200克','../../static/images/white/05.jpg','35.8',12,'20.5',2050,300),(15,3,15,4,'红茶','正山小种','正山小种正山小种正山小种正山小种正山小种正山小种','../../static/images/red/01.jpg','99.9',30,'90.0',NULL,300),(16,3,16,4,'红茶','金骏眉','金骏眉金骏眉金骏眉金骏眉金骏眉金骏眉','../../static/images/red/02.jpg','60.0',20,NULL,NULL,300),(17,3,17,4,'红茶','云南滇红','云南滇红云南滇红云南滇红云南滇红云南滇红云南滇红','../../static/images/red/03.jpg','56.6',12,'48.0',4800,300),(18,3,21,4,'红茶','祁门红茶','祁门红茶祁门红茶祁门红茶祁门红茶祁门红茶祁门红茶祁门红茶','../../static/images/red/04.jpg','80.0',4,'64.0',NULL,300),(19,4,22,5,'绿茶','xx龙井','xx龙井xx龙井xx龙井xx龙井xx龙井','../../static/images/green/01.png','124.0',120,NULL,NULL,300),(20,4,22,5,'绿茶','x龙井','x龙井x龙井x龙井x龙井x龙井x龙井x龙井','../../static/images/green/02.jpg','200.0',320,'180.0',NULL,300),(21,4,23,2,'绿茶','xx碧螺春','xx碧螺春xx碧螺春xx碧螺春xx碧螺春xx碧螺春xx碧螺春','../../static/images/green/03.jpg','164.6',106,NULL,NULL,300),(22,4,24,2,'绿茶','xx太平猴魁','xx太平猴魁xx太平猴魁xx太平猴魁xx太平猴魁xx太平猴魁','../../static/images/green/04.jpg','69.9',34,NULL,NULL,300),(23,4,25,1,'绿茶','六安瓜片','六安瓜片六安瓜片六安瓜片六安瓜片六安瓜片六安瓜片六安瓜片六安瓜片','../../static/images/green/05.jpg','99.9',68,NULL,9990,300),(24,4,30,2,'绿茶','毛尖','毛尖毛尖毛尖毛尖毛尖毛尖毛尖毛尖','../../static/images/green/06.jpg','126.0',358,'100.0',NULL,300),(25,5,34,3,'乌龙茶','铁观音','铁观音铁观音铁观音铁观音铁观音铁观音铁观音铁观音','../../static/images/oOlong/01.jpg','399.9',265,'299.9',NULL,300),(26,5,35,3,'乌龙茶','大红袍','大红袍大红袍大红袍大红袍大红袍大红袍大红袍大红袍','../../static/images/oOlong/02.jpg','289.9',28,'259.9',NULL,300),(27,6,42,1,'花茶','玫瑰花茶','玫瑰花茶玫瑰花茶玫瑰花茶玫瑰花茶玫瑰花茶玫瑰花茶玫瑰花茶玫瑰花茶','../../static/images/flower/03.jpg','45.0',68,NULL,NULL,300),(28,6,43,2,'花茶','菊花','菊花菊花菊花菊花菊花菊花菊花','../../static/images/flower/01.jpg','32.0',97,'28.0',2800,300),(29,6,44,1,'花茶','甘草','甘草甘草甘草甘草甘草甘草甘草甘草','../../static/images/flower/02.jpg','42.0',138,'39.9',NULL,300),(30,7,46,5,'黄茶','蒙山黄芽','蒙山黄芽蒙山黄芽蒙山黄芽蒙山黄芽蒙山黄芽蒙山黄芽蒙山黄芽','../../static/images/yellow/01.jpg','99.9',34,NULL,NULL,300),(31,8,47,6,'茶具','紫砂茶具','紫砂茶具紫砂茶具紫砂茶具紫砂茶具紫砂茶具紫砂茶具紫砂茶具','../../static/images/other/01.jpg','128.0',30,NULL,NULL,300),(32,8,52,6,'茶具','建盏茶具','建盏茶具建盏茶具建盏茶具建盏茶具建盏茶具建盏茶具建盏茶具','../../static/images/other/02.jpg','185.0',12,'150.0',NULL,300),(33,9,61,6,'茶壶','陶瓷壶','陶瓷壶陶瓷壶陶瓷壶陶瓷壶陶瓷壶陶瓷壶','../../static/images/other/03.jpg','89.9',28,NULL,NULL,300),(34,10,66,6,'茶盘','陶瓷茶盘','陶瓷茶盘陶瓷茶盘陶瓷茶盘陶瓷茶盘陶瓷茶盘陶瓷茶盘','../../static/images/other/04.jpg','68.8',14,NULL,NULL,300),(35,5,40,3,'乌龙茶','武夷水仙','武夷水仙武夷水仙武夷水仙武夷水仙武夷水仙武夷水仙武夷水仙武夷水仙','../../static/images/oOlong/03.jpg','56.8',30,NULL,5680,300),(36,1,1,1,'黑茶','忙肺乔木','2020年中茶普洱 忙肺乔木 生茶 357克','../../static/images/black/black-puer05.jpg','688.0',66,NULL,8000,300),(37,1,1,1,'黑茶','7741','2020年中茶普洱 7741 生茶 357克','../../static/images/black/black-puer03.jpg','168.0',12,NULL,NULL,300),(38,1,1,1,'黑茶','邦东乔木','2020年中茶普洱 邦东乔木 生茶 357克','../../static/images/black/black-puer04.jpg','628.0',23,'600.0',NULL,300),(39,1,1,1,'黑茶','90健茶','1990年双陈普洱 90健茶 熟茶 250克','../../static/images/black/black-puer07.jpg','11800.0',10,NULL,NULL,300),(47,3,1,1,'红茶','qweq','qwewqeqwe','../../static/images/new/001.jpg','123',0,'',0,123),(44,2,3,5,'白茶','新增白茶','新增白茶新增白茶新增白茶新增白茶新增白茶','../../static/images/new/002.jpg','64.0',0,'60.0',0,100);

UNLOCK TABLES;

/*Table structure for table `t_goods_class` */

DROP TABLE IF EXISTS `t_goods_class`;

CREATE TABLE `t_goods_class` (
  `class_id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_goods_class` */

LOCK TABLES `t_goods_class` WRITE;

insert  into `t_goods_class`(`class_id`,`class_name`) values (1,'黑茶'),(2,'白茶'),(3,'红茶'),(4,'绿茶'),(5,'乌龙茶'),(6,'花茶'),(7,'黄茶'),(8,'茶具'),(9,'茶壶'),(10,'茶盘');

UNLOCK TABLES;

/*Table structure for table `t_home_list` */

DROP TABLE IF EXISTS `t_home_list`;

CREATE TABLE `t_home_list` (
  `list_name` char(20) DEFAULT NULL,
  `list_icon` varchar(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_home_list` */

LOCK TABLES `t_home_list` WRITE;

insert  into `t_home_list`(`list_name`,`list_icon`) values ('茶店严选','../../static/images01/hl1.png'),('每日好店','../../static/images01/hl2.jpg'),('天天特卖','../../static/images01/hl3.jpg'),('限时抢购','../../static/images01/hl4.jpg'),('拼团购买','../../static/images01/hl5.jpg'),('好礼佳选','../../static/images01/hl6.jpg'),('玩转积分','../../static/images01/hl7.png'),('每日红包','../../static/images01/hl8.png'),('积分商城','../../static/images01/hl9.jpg'),('有好茶','../../static/images01/hl10.jpg');

UNLOCK TABLES;

/*Table structure for table `t_home_search` */

DROP TABLE IF EXISTS `t_home_search`;

CREATE TABLE `t_home_search` (
  `search_keyword` varchar(100) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_home_search` */

LOCK TABLES `t_home_search` WRITE;

insert  into `t_home_search`(`search_keyword`,`user_id`) values ('牡丹',7),('花茶',7);

UNLOCK TABLES;

/*Table structure for table `t_integral` */

DROP TABLE IF EXISTS `t_integral`;

CREATE TABLE `t_integral` (
  `user_id` int(11) DEFAULT NULL,
  `i_id` int(11) DEFAULT NULL,
  `i_name` char(20) DEFAULT NULL,
  `i_num` int(11) DEFAULT NULL,
  `i_time` char(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_integral` */

LOCK TABLES `t_integral` WRITE;

insert  into `t_integral`(`user_id`,`i_id`,`i_name`,`i_num`,`i_time`) values (7,1,'签到赠送积分',10,'2020-06-07 14:25:55'),(7,1,'签到赠送积分',10,'2020-06-07 13:08:41'),(7,1,'签到赠送积分',10,'2020-06-05 14:07:41'),(7,3,'积分兑换',30,'2020-06-04 14:44:17'),(7,1,'签到赠送积分',10,'2020-06-04 14:17:08'),(7,1,'签到赠送积分',10,'2020-06-03 14:07:58'),(7,1,'签到赠送积分',10,'2020-06-02 14:24:01');

UNLOCK TABLES;

/*Table structure for table `t_my_content` */

DROP TABLE IF EXISTS `t_my_content`;

CREATE TABLE `t_my_content` (
  `my_id` int(11) NOT NULL AUTO_INCREMENT,
  `my_name` char(20) DEFAULT NULL,
  `my_icon` varchar(100) DEFAULT NULL,
  `my_icon_bg` varchar(100) DEFAULT NULL,
  `my_color` varchar(100) DEFAULT NULL,
  `my_src01` varchar(100) DEFAULT NULL,
  `my_src02` varchar(100) DEFAULT NULL,
  `my_src03` varchar(100) DEFAULT NULL,
  `my_src04` varchar(100) DEFAULT NULL,
  `my_src05` varchar(100) DEFAULT NULL,
  `my_title` char(20) DEFAULT NULL,
  `my_in` char(20) DEFAULT NULL,
  `my_text` varchar(100) DEFAULT NULL,
  UNIQUE KEY `my_id` (`my_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `t_my_content` */

LOCK TABLES `t_my_content` WRITE;

insert  into `t_my_content`(`my_id`,`my_name`,`my_icon`,`my_icon_bg`,`my_color`,`my_src01`,`my_src02`,`my_src03`,`my_src04`,`my_src05`,`my_title`,`my_in`,`my_text`) values (1,'茶店严选','../../static/my-img/boutique.png','background-image: linear-gradient(to bottom right, rgba(255, 92, 43, 0.6), rgba(255, 92, 43, 1))','background: rgba(255, 92, 43, 1)','../../static/images/shop/01-bg.jpg','../../static/images01/mc-11.jpg','../../static/images01/mc-12.jpg','../../static/images01/mc-13.jpg','../../static/images01/mc-14.jpg','挑选钜惠好茶','精选好茶','color: rgba(255, 92, 43, 1)'),(2,'限时抢购','../../static/my-img/flash-sale.png','background-image: linear-gradient(to bottom right, rgba(41, 105, 255, .6), rgba(41, 105, 255, 1))','background: rgba(41, 105, 255, 1)','../../static/images/shop/02-bg.jpg','../../static/images01/mc-21.jpg','../../static/images01/mc-22.jpg','../../static/images01/mc-23.jpg','../../static/images01/mc-24.jpg','限时限量抢购','限时半价','color: rgba(41, 105, 255, 1)'),(3,'天天特卖','../../static/my-img/special-sale.png','background-image: linear-gradient(to bottom right, rgba(255, 128, 37, .6), rgba(255, 128, 37, 1))','background: rgba(255, 128, 37, 1)','../../static/images/shop/03-bg.jpg','../../static/images01/mc-31.jpg','../../static/images01/mc-32.jpg','../../static/images01/mc-33.jpg','../../static/images01/mc-34.jpg','更多包邮爆款','源头好货','color: rgba(255, 128, 37, 1)'),(4,'每日好店','../../static/my-img/good-shop.png','background-image: linear-gradient(to bottom right, rgba(153, 226, 85, .6), rgba(153, 226, 85, 1))','background: rgba(153, 226, 85, 1)','../../static/images/shop/01-bg.jpg','../../static/images01/mc-41.jpg','../../static/images01/mc-42.jpg','../../static/images01/mc-43.jpg','../../static/images01/mc-44.jpg','探寻神奇店铺','寻深藏老店','color: rgba(153, 226, 85, 1)'),(5,'寻找好茶','../../static/my-img/good-tea.png','background-image: linear-gradient(to bottom right, rgba(84, 14, 127, 0.6), rgba(84, 14, 127, 1))','background: rgba(84, 14, 127, 1)','../../static/images/shop/05-bg.jpg','../../static/images01/mc-51.jpg','../../static/images01/mc-52.jpg','../../static/images01/mc-53.jpg','../../static/images01/mc-54.png','寻找世间好茶','发现好茶叶','color: rgba(84, 14, 127, 1)'),(6,'拼团热购','../../static/my-img/vedio.png','background-image: linear-gradient(to bottom right, rgba(51, 179, 204, .6), rgba(51, 179, 204, 1))','background: rgba(51, 179, 204, 1)','../../static/images/shop/06-bg.jpg','../../static/images01/mc-61.jpg','../../static/images01/mc-62.jpg','../../static/images01/mc-63.jpg','../../static/images01/mc-64.jpg','组团便宜抢购','低价多购','color: rgba(51, 179, 204, 1)');

UNLOCK TABLES;

/*Table structure for table `t_order` */

DROP TABLE IF EXISTS `t_order`;

CREATE TABLE `t_order` (
  `o_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `shop_name` char(20) DEFAULT NULL,
  `g_id` int(11) DEFAULT NULL,
  `g_name` char(20) DEFAULT NULL,
  `g_price` char(20) DEFAULT NULL,
  `g_num` int(11) DEFAULT NULL,
  `g_src` varchar(100) DEFAULT NULL,
  `o_time` char(20) DEFAULT NULL,
  `o_type` char(20) DEFAULT NULL,
  `sc_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL,
  `sc_des` varchar(100) DEFAULT NULL,
  `o_evenlope` char(20) DEFAULT NULL,
  `o_integral` int(11) DEFAULT NULL,
  `o_coupon` int(11) DEFAULT NULL,
  `o_total` char(20) DEFAULT NULL,
  UNIQUE KEY `o_id` (`o_id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

/*Data for the table `t_order` */

LOCK TABLES `t_order` WRITE;

insert  into `t_order`(`o_id`,`user_id`,`shop_id`,`shop_name`,`g_id`,`g_name`,`g_price`,`g_num`,`g_src`,`o_time`,`o_type`,`sc_id`,`address_id`,`sc_des`,`o_evenlope`,`o_integral`,`o_coupon`,`o_total`) values (20,7,3,'云南下关沱茶',3,'普洱砖茶','25.0',2,'../../static/images/black/black-zhuan01.jpg','2020-06-04 13:52:01','待付款',25,20,NULL,'0.75',20,0,'49.05'),(21,7,3,'云南下关沱茶',13,'白毫银针','72.5',2,'../../static/images/white/04.jpg','2020-06-04 14:37:57','待付款',26,18,NULL,'0.95',0,0,'143.75'),(24,7,4,'兴海茶业',1,'普洱方砖','9800.0',1,'../../static/images/black/black-puer08.png','2020-06-07 14:24:51','待付款',30,18,NULL,'3.76',0,0,'9796.24');

UNLOCK TABLES;

/*Table structure for table `t_shopping_car` */

DROP TABLE IF EXISTS `t_shopping_car`;

CREATE TABLE `t_shopping_car` (
  `sc_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `g_id` int(11) DEFAULT NULL,
  `shop_id` int(11) DEFAULT NULL,
  `s_name` char(20) DEFAULT NULL,
  `g_name` char(20) DEFAULT NULL,
  `g_introduce` char(30) DEFAULT NULL,
  `g_src` varchar(100) DEFAULT NULL,
  `g_price` char(20) DEFAULT NULL,
  `sc_num` int(11) DEFAULT NULL,
  `sc_des` varchar(100) DEFAULT NULL,
  UNIQUE KEY `sc_id` (`sc_id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Data for the table `t_shopping_car` */

LOCK TABLES `t_shopping_car` WRITE;

insert  into `t_shopping_car`(`sc_id`,`user_id`,`g_id`,`shop_id`,`s_name`,`g_name`,`g_introduce`,`g_src`,`g_price`,`sc_num`,`sc_des`) values (28,7,2,2,'春福润茶叶','嘉年华壹号','2020年双陈普洱 嘉年华壹号 熟茶 357克','../../static/images/black/black-puer06.jpg','99.9',1,NULL);

UNLOCK TABLES;

/*Table structure for table `t_shops` */

DROP TABLE IF EXISTS `t_shops`;

CREATE TABLE `t_shops` (
  `shop_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_name` char(20) DEFAULT NULL,
  `s_icon` varchar(100) DEFAULT NULL,
  `s_y` char(20) DEFAULT NULL,
  `s_v` char(20) DEFAULT NULL,
  `s_p` char(20) DEFAULT NULL,
  `s_des` int(11) DEFAULT NULL,
  `s_log` int(11) DEFAULT NULL,
  `s_ser` int(11) DEFAULT NULL,
  `s_phone` char(11) DEFAULT NULL,
  `s_address` char(20) DEFAULT NULL,
  `s_person` int(11) DEFAULT NULL,
  `s_time` char(20) DEFAULT NULL,
  `s_bg` varchar(100) DEFAULT NULL,
  `s_introduce` varchar(100) DEFAULT NULL,
  `s_title` char(20) DEFAULT NULL,
  `s_bga` varchar(100) DEFAULT NULL,
  `s_bgb` varchar(100) DEFAULT NULL,
  `s_bgc` varchar(100) DEFAULT NULL,
  `s_run` char(20) DEFAULT NULL,
  UNIQUE KEY `shop_id` (`shop_id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `t_shops` */

LOCK TABLES `t_shops` WRITE;

insert  into `t_shops`(`shop_id`,`s_name`,`s_icon`,`s_y`,`s_v`,`s_p`,`s_des`,`s_log`,`s_ser`,`s_phone`,`s_address`,`s_person`,`s_time`,`s_bg`,`s_introduce`,`s_title`,`s_bga`,`s_bgb`,`s_bgc`,`s_run`) values (1,'云南中茶茶业','../../static/images/shop/01.jpg','严选','V店','品牌',5,4,5,'18712311111','云南省昆明市',122,'2019-01-01','../../static/images/shop/01-bg.jpg','中国荣耀，茗茶荟萃。','专业、周到','../../static/images/shop/01-bga.jpg','../../static/images/shop/01-bgb.jpg','../../static/images/shop/01-bgc.jpg','黑茶、白茶、绿茶、花茶'),(2,'春福润茶叶','../../static/images/shop/02.jpg','严选',NULL,NULL,4,5,2,'18712311112','四川成都',59,'2020-01-01','../../static/images/shop/05-bg.jpg','心向自由，让茶香立刻绽放！','经典、纯正','../../static/images/shop/02-bga.jpg','../../static/images/shop/02-bgb.jpg','../../static/images/shop/02-bgc.jpg','黑茶、白茶、绿茶、花茶'),(3,'云南下关沱茶','../../static/images/shop/03.jpg',NULL,NULL,'品牌',5,3,4,'18712311113','云南昆明',25,'2018-12-03','../../static/images/shop/03-bg.jpg','料与技彼此成就，茶与仓相互成全！','传承','../../static/images/shop/03-bga.jpg','../../static/images/shop/03-bgb.jpg','../../static/images/shop/03-bgc.jpg','乌龙茶、黑茶、白茶'),(4,'兴海茶业','../../static/images/shop/04.jpg',NULL,'V店','品牌',3,5,4,'18712311114','勐海',36,'2019-12-30','../../static/images/shop/04-bg.jpg','精细研发，口感十足。','优质与精细','../../static/images/shop/04-bga.jpg','../../static/images/shop/04-bgb.jpg','../../static/images/shop/04-bgc.jpg','红茶、黑茶'),(5,'老同志茶厂','../../static/images/shop/05.jpg','严选',NULL,NULL,4,3,3,'18712311115','浙江杭州',1,'2020-05-01','../../static/images/shop/02-bg.jpg','大师制作，口感丰富，活力十足','技术、活力','../../static/images/shop/05-bga.jpg','../../static/images/shop/05-bgb.jpg','../../static/images/shop/05-bgc.jpg','黑茶、黄茶、绿茶'),(6,'云南六大茶山茶业','../../static/images/shop/06.jpg',NULL,'V店',NULL,5,5,4,'18712311116','云南省昆明市',16,'2016-05-01','../../static/images/shop/06-bg.jpg','口感鲜嫩、外观丰富','鲜嫩','../../static/images/shop/06-bga.jpg','../../static/images/shop/06-bgb.jpg','../../static/images/shop/06-bgc.jpg','茶具、茶壶、茶盘、黑茶'),(7,'八角亭茶叶','../../static/images/shop/07.jpg',NULL,NULL,'品牌',4,4,4,'18712311117','福建',12,'2016-05-01','../../static/images/shop/07-bg.jpg','口感醇厚浓化，温润下沉。','新品','../../static/images/shop/07-bga.png','../../static/images/shop/07-bgb.png','../../static/images/shop/07-bgc.png','黑茶');

UNLOCK TABLES;

/*Table structure for table `t_tool` */

DROP TABLE IF EXISTS `t_tool`;

CREATE TABLE `t_tool` (
  `tool_name` char(20) DEFAULT NULL,
  `tool_background` char(100) DEFAULT NULL,
  `tool_src` char(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `t_tool` */

LOCK TABLES `t_tool` WRITE;

insert  into `t_tool`(`tool_name`,`tool_background`,`tool_src`) values ('我的收藏','background-image: linear-gradient(to bottom right, rgba(255, 148, 26, 0.8), rgba(255, 148, 26, 1))','../../static/my-img/wodeshoucang.png'),('我的评价','background-image: linear-gradient(to bottom right,rgba(107, 190, 18, 0.8), rgba(107, 190, 18, 1))','../../static/my-img/iconfontevaluate.png'),('个人资料','background-image: linear-gradient(to bottom right, rgba(51, 179, 204, 0.8), rgba(51, 179, 204, 1))','../../static/my-img/gerenziliao.png'),('我的关注','background-image: linear-gradient(to bottom right, rgba(12, 171, 31, 0.8), rgba(12, 171, 31, 1))','../../static/my-img/wodeguanzhu.png'),('红包','background-image: linear-gradient(to bottom right, rgba(255, 92, 43, 0.8), rgba(255, 92, 43, 1))','../../static/my-img/hongbao.png'),('分享','background-image: linear-gradient(to bottom right, rgba(255, 46, 74, 0.8), rgba(255, 46, 74, 1))','../../static/my-img/plus-share.png'),('收货地址','background-image: linear-gradient(to bottom right, rgba(255, 33, 252, 0.8), rgba(255, 33, 252, 1))','../../static/my-img/shouhuodizhi.png'),('优惠券','background-image: linear-gradient(to bottom right, rgba(255, 195, 75, 0.6), rgba(255, 195, 75, 1))','../../static/my-img/youhuiquan.png');

UNLOCK TABLES;

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` char(20) DEFAULT NULL,
  `user_password` char(20) DEFAULT NULL,
  `user_phone` char(11) DEFAULT NULL,
  `user_sex` char(4) DEFAULT NULL,
  `user_type` char(20) DEFAULT NULL,
  `user_headImg` varchar(20000) DEFAULT NULL,
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

LOCK TABLES `t_user` WRITE;

insert  into `t_user`(`user_id`,`user_name`,`user_password`,`user_phone`,`user_sex`,`user_type`,`user_headImg`) values (7,'001','123456','13111111111','男','普通用户','../../static/images/new/001.jpg');

UNLOCK TABLES;

/*Table structure for table `t_user_address` */

DROP TABLE IF EXISTS `t_user_address`;

CREATE TABLE `t_user_address` (
  `user_id` int(11) DEFAULT NULL,
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_user` char(20) DEFAULT NULL,
  `address_phone` char(11) DEFAULT NULL,
  `address_provence` varchar(100) DEFAULT NULL,
  `address_house` varchar(100) DEFAULT NULL,
  UNIQUE KEY `address_id` (`address_id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `t_user_address` */

LOCK TABLES `t_user_address` WRITE;

insert  into `t_user_address`(`user_id`,`address_id`,`address_user`,`address_phone`,`address_provence`,`address_house`) values (7,20,'001','13111111111','北京市-市辖区-西城区','xxxx-xx'),(7,18,'001','13111111111','四川省-宜宾市-翠屏区','xxxx-xx-xx');

UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

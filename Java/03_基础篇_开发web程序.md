# 一. C/S 架构

## 1. C/S 架构

之前我们开发的贷款计算器，属于单机程序，同一时刻只能有一个用户使用，为了支持多用户同时使用贷款计算器，需要改为 web 程序，也就是网络应用程序

网络应用程序，需要采用下面的软件架构方式

![image-20220503175227048](imgs\image-20220503175227048.png)

这样，多个客户端都可以通过网络连接至服务器，通过【请求】（绿色箭头）将信息传输给服务器，服务器运算后，通过【响应】（蓝色箭头）将计算结果返回给客户端，见下图

![image-20220503181637321](imgs\image-20220503181637321.png)

* 客户端将贷款金额、年利率、贷款月数发给服务器
* 服务器计算完毕后，将还款总额返回给客户端



这种架构方式称为 Client/Server 架构，为了能支持 C/S 架构，需要引入一个新的开发技术 Spring Boot

* 它内置了一个软件 Tomcat，可以与客户端进行交互
  * 我们即将编写的代码，就是运行在服务器这边

* 使用系统自带的浏览器就可以充当架构中的客户端
  * 客户端可以使用网页技术来接收用户的输入、同时用网页向用户展现服务器的结果输出
  * 网页技术暂时不作为重点内容，可视为已经提供
  * C/S 中的 C 可以有很多种，浏览器只是其中一种特例，称浏览器这种客户端的架构为 B/S 架构




## 2. URL 格式

浏览器客户端要与服务器交互，请求和响应都需要遵从一定的格式，发请求时需要遵从一种 URL 格式

```
协议://主机[:端口]/路径[?查询参数]
```

* 协议常见的有 http 和 https，其中 http 对传输的内容不会加密，安全性差一些，但速度更快
* 主机，决定了请求哪个服务器，例如：www.baidu.com，自己这台机器可以用 localhost 表示
* 端口，因为服务器上可能同时运行多个程序，要用不同的端口加以区分，如果是 80，可以省略
* 路径，服务器提供了很多功能，为了区分这些功能，用不同的路径表示，例如
  * 可以定义一个路径 /add 做加法
  * 另一个路径 /calculate 做还款计算
* ? 后面的称之为查询参数，用来代表功能的输入信息，例如 
  * /add 需要 ?a=100&b=200 这两个查询参数
  * /calculate 需要 ?p=2000000.0&yr=6.0&m=360 这三个查询参数
  * 可以看到参数用=分成了名称和值，多个参数之间用 & 连接
* 可以看到 URL 就是起到一个定位和传参的作用：它决定了你将来发的这个请求到底是想访问哪台服务器，里的哪个程序，用程序中的哪个功能，并能把功能所需参数也传递过来。



# 二. Spring Boot

Spring Boot 不光内嵌 Tomcat，省却了搭建服务程序的成本，还提供了方便处理 C/S 开发中输入和输出的类（对服务程序来说，输入就对应着请求，输出就对应着响应），核心类库处理控制台的输入输出还行，但处理 C/S 下的请求、响应就不够看了，Spring boot 是由 [VMware](https://www.vmware.com/) 公司维护的一个开源框架，让我们能快速开发独立的、生产级的应用程序。

什么是框架，它包含两方面

1. 条条框框，必须按照框架的规则来编写代码
2. 通用功能，框架提供了很多通用的功能，能够节省开发时间，提升开发效率
   * 对比核心类库，核心类库的提供的类功能更基本，框架提供的功能更有针对性，专注解决某方面问题



## 1. 向导生成

* 如果使用 Idea 最终版，可以通过它的向导创建 Spring Boot 项目。
* 如果只有 Idea 社区版也没有关系，可以用 [官网 Spring Boot 向导](https://start.spring.io/) 网页版的向导来生成 Spring Boot 项目
  * 如果官网向导打不开，可以替换为 [Aliyun Spring Boot 向导](https://start.aliyun.com/bootstrap.html?spm=a2ck6.17690074.0.0.503c2e7dm5Tqe6)

![image-20220628092347574](imgs\image-20220628092347574.png)

* 他一开始让你去选择项目的构建方式，这个先不用管啥意思，用默认 maven 就可以
* 开发语言没啥说的，默认的Java就行
* Spring boot 版本这一块你随便选一个啊，因为他选完了以后我们最终还得改，我们为了配合 java 17，最后得改成 2.7.0 这个版本
* 接下来就是填写一些项目的基本信息，这个 group 就填写公司域名的那个倒置，它会影响代码中 package 包名。比如说我这是黑马的，那就写 com.itheima。
* artifact 这里，一般就填写功能名称，比如说你是做的是一个商城系统，你就写一个mall，那如果你是一个管理系统你就写某某 management，总之根据程序功能来定，我这儿就随便起个名字吧，叫 module2
* 高级选项里，是让你去选打包方式啊，Java的版本啊等等，阿里云的java版本也是比较低，它最高才支持15，这个也不用关心，最后再统一修改
* 组件依赖这儿呢，我们一定要选一个叫web，你先敲一下web，他会提示出来一些候选项，选第1个，这是啥意思呢？Springboot中支持很多功能组件，其中做 web 程序开发，需要用到这个 web 组件

主要关注图中红框的几处位置就可以，都设置完了，点击获取代码，它就会根据刚才的选择生成一个压缩包并下载。

## 2. 准备工作

骨架代码生成好之后，还有两个准备工作要做一下

### 1) 修改版本

刚才也说了，如果是官网生成的骨架，版本不用改，springboot 就用 2.7.0 Java 就用 17，但 aliyun 生成的骨架版本较低，需要修改一下，怎么改呢

1. 解压缩
2. 找到 pom.xml，把其中的
   * java 改为 17
   * boot 改为 2.7.0

### 2) 修改maven 设置

maven 到底是干嘛的呢，以后咱们进行 java 开发，会用到很多第三方的压缩 jar 包，例如今天学的 spring boot，spring boot 中的 web 组件等等，都是以这种 jar 包形式提供的，这些 jar 包需要下载到本地才能使用吧，如果让我们人工下载管理的话，显然太过麻烦，maven 就是这么一个工具，能帮我们下载、管理这些第三方的 jar 包。

1. idea 已经集成了maven 工具，但是由于maven默认会连接国外地址进行下载，不仅下载很慢还容易出错，因此需要用配置将 jar 包下载地址改为国内的

2. 找到 idea 带的 maven 配置文件

   D:\ideaIC-2022.1.win\plugins\maven\lib\maven3\conf\settings.xml 

在内部加入如下的配置

```xml
<mirrors>  
	<mirror>
        <id>central</id>
        <mirrorOf>central</mirrorOf>
        <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
    
    <!-- ... -->
</mirrors>  
```



## 3. 导入模块

准备工作做好了之后，就可以把刚才的骨架代码加入到当前项目中了。

* 先到下载目录，把刚刚修改好的 module2 目录，复制到当前项目目录下

* 切换回 idea 可以看到已经有了，不过 idea 还没有把这个文件夹识别为模块，这时找到 module2 下的 pom.xml 文件，右键点击它，选择【添加为 maven 项目】，就可以了。
  * 第一次操作时会慢一些，这是 idea 正在通过 maven 来下载 jar 包
  * 下载完毕，如果右侧还有报错，没关系，这是 idea 没有刷新过来，关掉项目重新打开一般就能解决



## 4. hello world

骨架代码中，有一个 XxxApplication 类，它其中的 main 方法是程序的入口，但与控制台版的 Hello world 不同，要通过 C/S 的方式处理输入和输出，需要学习一点新的知识

```java
@Controller
public class HelloController {

    @RequestMapping("/hello")
    @ResponseBody
    public String hi() {
        return "hello world";
    }
}
```

这段代码描述的是一个称为控制器的类，用来处理输入、输出。

* 不是所有的类都能成为控制器类，@Controller 是java中的语法，叫做注解，这个注解是 Spring 给我们提供的，由它标注的类才能作为控制器。

方法上还有分别跟输入、输出相关的两个注解

* @RequestMapping("/hello") 对应着 URL 中的路径部分，例如请求 URL 中携带了 /hello，那么将来就会执行 hi 这个方法
* @ResponseBody 是用来处理 hi 方法的返回结果，将方法执行结果作为响应内容（即输出）

这些注解就是框架提供的条条框框



## 5. 处理输入

这节课来学习控制器如何处理输入

客户端这边当然可以以查询参数的方式将数据传递给服务器，但这样对于使用者不太友好，因此会用到网页技术，以更友好的方式处理数据。

网页里就可以用下面文本框接收用户的输入，作为查询参数，对用户隐藏了复杂性，提高了用户体验，我现在想做的效果很简单

![image-20220524102740483](imgs\image-20220524102740483.png)

就是在文本块中输入一个名字 xxx，点击 say hello,  由服务器返回 hello, xxx

### 页面

页面要放在 static 目录下，页面也需要通过 URL 来访问，格式为 http://localhost:8080/页面名称

双击 hello.html 网页，就看到了它的源代码，这段代码里包含了两种语言，html 语言 和 javascript 语言（简称js），不过这些代码绝大部分也不需要理解，并非我们的重点，我只会讲作用，不会讲语法

* 其中文本框对应的代码是这一行，`<input type="text" name="name" id="n">`，可以接收用户键入的文字
* `var n = document.querySelector("#n").value;` 是页面中用的 js 语言，=右边的代码作用是获取用户在文本框输入的值，var n 是定义了一个变量，用来代表=号后的值。但是输入的值目前还在浏览器这边，并没有通过网络传输给服务器

* 接下来按格式拼接好 URL，`"http://localhost:8080/hello?name=" + n`

  * 这是 js 中一种拼接字符串的方法

  * fetch 处的代码才是真正根据 URL 发送请求，并把服务器返回的内容显示出来，但这部分暂不需要了解


运行，发现总是返回 hello world，这是因为hello控制器这边还未对查询参数做出任何处理，下面就来解决这个问题



### 接收参数

hi 如何接收请求中的查询参数呢，一种方式就是提供同名的方法参数

```java
@Controller
public class HelloController {

    @RequestMapping("/hello")
    @ResponseBody
    String hi(String name) { // ⬅️ 这里的方法参数要和查询参数【名称】一致
        return "Hello, " + name;
    }
}
```





### 练习 - 加法

加法例子，这回要提供两个参数，两个参数用 int 接收即可，其实请求中的参数类型原始是 String，Spring 会把 String 转换为 int

```java
@Controller
public class AddController {

    @RequestMapping("/add")
    @ResponseBody
    int add(int a, int b) {
        return a + b;
    }
}
```

页面上的 URL 拼接有两种方法

```js
`http://localhost:8080/add?a=${a}&b=${b}`
```

和

```js
"http://localhost:8080/add?a=" + a + "&b=" + b
```

其中 a 和 b 来自于页面的两个数字框

![image-20220628095009599](imgs\image-20220628095009599.png)



# 三. 贷款计算器 - WEB 版

需求1，计算还款总额，这个其实很简单

```java
@Controller
public class CalController {
    @RequestMapping("/cal")
    @ResponseBody
    String[] cal(double p, int m, double yr) {
        double mr = yr / 12 / 100.0;
        double pow = Math.pow(1 + mr, m);
        double payment = p * mr * pow / (pow - 1);
        return NumberFormat.getCurrencyInstance().format(payment * m);
    }
}
```



需求2，计算还款总额，以及利息总额

* 如何用方法返回多个值呢，需要用到数组



## 1. 数组

### 定义

方法只能返回一个结果，现在要返回两个值，可以使用数组。数组可以容纳多个值。

定义字符串数组、给数组的两个元素赋值

```java
String[] a = new String[2];
a[0] = "hello";
a[1] = "world";
```

定义并赋值（一步完成）

```java
String[] a = new String[]{"hello", "world"};
```

后者可以简化为

```java
String[] a = {"hello", "world"};
```

* 最后这种，虽然看着简单，但它的限制较多，用的少



### 改写贷款计算器

前端页面要求

* 数组索引为0的元素，代表还款总额

* 数组索引为1的元素，代表利息总额

因此代码改写如下

```java
@Controller
public class CalController {

    @RequestMapping("/cal")
    @ResponseBody
    String[] cal(double p, int m, double yr) {
        double mr = yr / 12 / 100.0;
        double pow = Math.pow(1 + mr, m);
        double payment = p * mr * pow / (pow - 1);
		// [0]还款总额   [1]总利息
        return new String[]{
                NumberFormat.getCurrencyInstance().format(payment * m),
                NumberFormat.getCurrencyInstance().format(payment * m - p)
        };
    }
}
```



### 越界

数组呢，有一个需要大家注意的地方就是。这个数组一旦它的长度确定了，就不能改了。并且啊，不能越过他的这个大小限制，比如说对于下面的数组

```java
String[] a = {"hello", "world"};
```

我想访问他的索引2的元素行不行？

* 不行，这个时候会报一个错误，他叫做。ArrayIndexOutOfBoundsException 数组索引越界异常，大家一定要避免
* 可以通过数组的一个 length 变量来得知此数组的大小是多少。



### 遍历

即逐一获取数组中的每个元素进行操作

```java
for(int i = 0; i < a.length; i++) {
    System.out.println(a[i]); // 获取数组中第 i 个元素
}
```



### 默认值

整数数组，new int[5]，创建了五个元素的数组，并未给元素赋初始值，这时元素默认值是 0

类似的

* String[] 的元素默认值是 null
* double[] 的元素默认值是 0.0
* boolean[] 的元素默认值是 false



## 2. 二维数组

比如我想表示一张表格

![image-20220524150534370](imgs\image-20220524150534370.png)

可以用二维数组来表示，就是数组里面再套一个数组

例如上面的表格可以表示为：外层数组长度3，内层数组长度5，内层长度可以不指定

```java
String[][] a2 = new String[3][5];
```

即

```java
a2[0] = new String[]{"1", "¥33,667.22", "¥33,167.22", "¥500.00", "¥66,832.78"};
a2[1] = new String[]{"2", "¥33,667.22", "¥33,333.06", "¥334.16", "¥33,499.72"};
a2[2] = new String[]{"3", "¥33,667.22", "¥33,499.72", "¥167.50", "¥0.00"};
```



如何动态生成这张表格呢

回忆一下以前的代码

```java
double mr = yr / 100.0 / 12.0;
double pow = Math.pow((1 + mr), m);
double payment = p * mr * pow / (pow - 1); 			// 月供
for (int i = 0; i < m; i++) {
    double payInterest = p * mr;      				// 月利息=剩余本金*月利率
    double payPrincipal = payment - payInterest;    // 月本金=月供-月利息
    p -= payPrincipal;                              // 更新剩余本金    
}
```

只需要把月供、月利息、月本金、剩余本金等作为 row，多个 row 作为二维数组即可。得到最终用二维数组改写的代码

```java
@Controller
public class CalController {
	// ...

    @RequestMapping("/details")
    @ResponseBody
    String[][] details(double p, int m, double yr, int type) {
        String[][] a2 = new String[m][]; // 二维数组        
        double mr = yr / 12 / 100.0;
        double pow = Math.pow(1 + mr, m);
        double payment = p * mr * pow / (pow - 1);              // 月供
        for (int i = 0; i < m; i++) {
            double payInterest = p * mr;                        // 偿还利息
            double payPrincipal = payment - payInterest;        // 偿还本金
            p -= payPrincipal;                                  // 剩余本金
            String[] row = new String[]{                       // 一行的数据
                    (i + 1) + "",
                    NumberFormat.getCurrencyInstance().format(payment),
                    NumberFormat.getCurrencyInstance().format(payPrincipal),
                    NumberFormat.getCurrencyInstance().format(payInterest),
                    NumberFormat.getCurrencyInstance().format(p)
            };
            a2[i] = row; // 将每一行放入二维数组
        }
        return a2;
    }
}
```



## 3. 贷款计算器 - 增加等额本金计算

增加按等额本金计算的功能

* 每月偿还的本金是固定的，即 $payPrincipal = p / m$，其中 $p$ 是初始本金
* 每月偿还的利息还是 $payInterest = p' * mr$，其中 $p'$ 是剩余本金，随月份越还越少

页面新增了还款类型，等额本息的类型为 0，等额本金的类型为1

![image-20220628103842594](imgs\image-20220628103842594.png)

* 选择本息会附带查询参数 type=0
* 选择本金会附带查询参数 type=1



改写后代码如下

```java
@Controller
public class CalController {
    
    @RequestMapping("/cal")
    @ResponseBody
    String[] cal(double p, int m, double yr, int type) {
        if (type == 0) { // 等额本息
            return cal0(p, m, yr);
        } else {    // 等额本金
            return cal1(p, m, yr);
        }
    }

    @RequestMapping("/details")
    @ResponseBody
    String[][] details(double p, int m, double yr, int type) {
        if (type == 0) {
            return details0(p, m, yr);
        } else {
            return details1(p, m, yr);
        }

    }

    static String[] cal0(double p, int m, double yr) {
        double mr = yr / 12 / 100.0;
        double pow = Math.pow(1 + mr, m);
        double payment = p * mr * pow / (pow - 1);
        return new String[]{
                NumberFormat.getCurrencyInstance().format(payment * m),
                NumberFormat.getCurrencyInstance().format(payment * m - p)
        };
    }

    static String[] cal1(double p, int m, double yr) {
        double payPrincipal = p / m;        // 偿还本金
        double backup = p;                  // 备份本金
        double mr = yr / 12 / 100.0;
        double payInterestTotal = 0.0;      // 总利息
        for (int i = 0; i < m; i++) {
            double payInterest = p * mr;    // 偿还利息
            p -= payPrincipal;              // 剩余本金
            payInterestTotal += payInterest;
        }
        // [0]还款总额   [1]总利息
        return new String[]{
                NumberFormat.getCurrencyInstance().format(backup + payInterestTotal),
                NumberFormat.getCurrencyInstance().format(payInterestTotal)
        };
    }
    
    static String[][] details0(double p, int m, double yr) {
        String[][] a2 = new String[m][];
        double mr = yr / 12 / 100.0;
        double pow = Math.pow(1 + mr, m);
        double payment = p * mr * pow / (pow - 1);              // 月供
        for (int i = 0; i < m; i++) {
            double payInterest = p * mr;                        // 偿还利息
            double payPrincipal = payment - payInterest;        // 偿还本金
            p -= payPrincipal;                                  // 剩余本金
            String[] row = new String[]{                       // 一行的数据
                    (i + 1) + "",
                    NumberFormat.getCurrencyInstance().format(payment),
                    NumberFormat.getCurrencyInstance().format(payPrincipal),
                    NumberFormat.getCurrencyInstance().format(payInterest),
                    NumberFormat.getCurrencyInstance().format(p)
            };
            a2[i] = row;
        }
        return a2;
    }

    static String[][] details1(double p, int m, double yr) {
        // 等额本金
        double payPrincipal = p / m;                        // 偿还本金
        double mr = yr / 12 / 100.0;
        String[][] a2 = new String[m][];
        for (int i = 0; i < m; i++) {
            double payInterest = p * mr;                    // 偿还利息
            p -= payPrincipal;                              // 剩余本金
            double payment = payPrincipal + payInterest;    // 月供
            String[] row = new String[]{
                    (i + 1) + "",
                    NumberFormat.getCurrencyInstance().format(payment),
                    NumberFormat.getCurrencyInstance().format(payPrincipal),
                    NumberFormat.getCurrencyInstance().format(payInterest),
                    NumberFormat.getCurrencyInstance().format(p)
            };
            a2[i] = row;
        }
        return a2;
    }
}
```





## 4. 贷款计算器 - 异常处理

对输入的数据做合法检查

* 贷款金额必须大于0
* 贷款月份范围必须在 1 ~ 360 之间
* 年利率范围必须在 1 ~ 36 之间
* 还款类型只能有 0 和 1 两种类型，其它应该显示【不支持的还款类型】



改写后的代码

```java
@Controller
public class CalController {
    
    @RequestMapping("/cal")
    @ResponseBody
    String[] cal(double p, int m, double yr, int type) {
        check(p, m, yr, type); // 检查通过，才会向下运行
        if (type == 0) { // 等额本息
            return cal0(p, m, yr);
        } else {    // 等额本金
            return cal1(p, m, yr);
        }
    }

    @RequestMapping("/details")
    @ResponseBody
    String[][] details(double p, int m, double yr, int type) {
        check(p, m, yr, type); // 检查通过，才会向下运行
        if (type == 0) {
            return details0(p, m, yr);
        } else {
            return details1(p, m, yr);
        }

    }
    
    // 检查方法
    static void check(double p, int m, double yr, int type) {
        if (p <= 0) {
            throw new IllegalArgumentException("贷款金额必须>0");
        }
        if (m < 1 || m > 360) {
            throw new IllegalArgumentException("贷款月份必须在 1~360 之间");
        }
        if (yr < 1.0 || yr > 36.0) {
            throw new IllegalArgumentException("年利率必须在 1~36 之间");
        }
        if (type != 0 && type != 1) {
            throw new IllegalArgumentException("不支持的还款类型");
        }
    }

    // ...
}
```

需要在 application.properties 文件中加入

```properties
server.error.include-message=always
```

这样才能在页面上显示错误详情



## 5. 打包

Web 程序打包与之前控制台打包操作不一样，参考下图

![image-20220628104843045](imgs\image-20220628104843045.png)

使用 package 打包

打包成功后，会在 module2 模块下 target 目录下找到这个打好的 jar 包，运行 jar 包的方法是一样的，进入 jar 包所在目录，用终端程序执行

```java
java -jar module2-0.0.1-SNAPSHOT.jar
```


<!DOCTYPE html>
<!-- saved from url=(0039)https://www.kubernetes.org.cn/3805.html -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<meta http-equiv="X-UA-Compatible" content="IE=11,IE=10,IE=9,IE=8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-title" content="Kubernetes中文社区">
<meta http-equiv="Cache-Control" content="no-siteapp">
<meta name="baidu-site-verification" content="e2Ho2t2X7Q">
<meta name="applicable-device" content="pc,mobile">
<title>使用kubeadm安装Kubernetes v1.10以及常见问题解答_Kubernetes中文社区</title>
<link rel="dns-prefetch" href="https://apps.bdimg.com/">
<link rel="stylesheet" id="hctpc_stylesheet-css" href="./download_images_files/front_end_style.css" type="text/css" media="all">
<link rel="stylesheet" id="dashicons-css" href="./download_images_files/dashicons.min.css" type="text/css" media="all">
<link rel="stylesheet" id="hctpc_desktop_style-css" href="./download_images_files/desktop_style.css" type="text/css" media="all">
<link rel="stylesheet" id="_bootstrap-css" href="./download_images_files/bootstrap.min.css" type="text/css" media="all">
<link rel="stylesheet" id="_fontawesome-css" href="./download_images_files/font-awesome.min.css" type="text/css" media="all">
<link rel="stylesheet" id="_main-css" href="./download_images_files/main.css" type="text/css" media="all">
<script src="./download_images_files/push.js.下载"></script><script src="./download_images_files/hm.js.下载"></script><script type="text/javascript" src="./download_images_files/jquery.min.js.下载"></script>
<link rel="prev" title="Kubernetes安装部署演示介绍-（二）" href="https://www.kubernetes.org.cn/3797.html">
<link rel="next" title="Kubernetes成为主流，对开发者而言是好是坏？" href="https://www.kubernetes.org.cn/3806.html">
<link rel="canonical" href="https://www.kubernetes.org.cn/3805.html">
<meta name="keywords" content="k8s代码解读, kubeadm, Kubernetes1.10, Kubernetes安装说明, Kubernetes教程/入门教程">
<meta name="description" content="关于K8S：  Kubernetes是Google开源的容器集群管理系统。它构建于docker技术之上，为容器化的应用提供资源调度、部署运行、服务发现、扩 容缩容等整一套功能，本质上可看作是基于容器技术的mini-PaaS平台。  相信看过我博客的童鞋应该知道，我在14年的时候就发表了一篇名为Docker容器管理之Kubernetes当时国内Docker刚刚">
<style>a:hover, .site-navbar li:hover > a, .site-navbar li.active a:hover, .site-navbar a:hover, .search-on .site-navbar li.navto-search a, .topbar a:hover, .site-nav li.current-menu-item > a, .site-nav li.current-menu-parent > a, .site-search-form a:hover, .branding-primary .btn:hover, .title .more a:hover, .excerpt h2 a:hover, .excerpt .meta a:hover, .excerpt-minic h2 a:hover, .excerpt-minic .meta a:hover, .article-content .wp-caption:hover .wp-caption-text, .article-content a, .article-nav a:hover, .relates a:hover, .widget_links li a:hover, .widget_categories li a:hover, .widget_ui_comments strong, .widget_ui_posts li a:hover .text, .widget_ui_posts .nopic .text:hover , .widget_meta ul a:hover, .tagcloud a:hover, .textwidget a:hover, .sign h3, #navs .item li a, .url, .url:hover{color: #3366cc;}.btn-primary, .label-primary, .branding-primary, .post-copyright:hover, .article-tags a, .pagination ul > .active > a, .pagination ul > .active > span, .pagenav .current, .widget_ui_tags .items a:hover, .sign .close-link, .pagemenu li.active a, .pageheader, .resetpasssteps li.active, #navs h2, #navs nav, .btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open > .dropdown-toggle.btn-primary, .tag-clouds a:hover{background-color: #3366cc;}.btn-primary, .search-input:focus, #bdcs .bdcs-search-form-input:focus, #submit, .plinks ul li a:hover,.btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open > .dropdown-toggle.btn-primary{border-color: #3366cc;}.search-btn, .label-primary, #bdcs .bdcs-search-form-submit, #submit, .excerpt .cat{background-color: #3366cc;}.excerpt .cat i{border-left-color:#3366cc;}@media (max-width: 720px) {.site-navbar li.active a, .site-navbar li.active a:hover, .m-nav-show .m-icon-nav{color: #3366cc;}}@media (max-width: 480px) {.pagination ul > li.next-page a{background-color:#3366cc;}}</style><link rel="icon" href="https://www.kubernetes.org.cn/img/2018/07/cropped-con999-32x32.png" sizes="32x32">
<link rel="icon" href="https://www.kubernetes.org.cn/img/2018/07/cropped-con999-192x192.png" sizes="192x192">
<link rel="apple-touch-icon-precomposed" href="https://www.kubernetes.org.cn/img/2018/07/cropped-con999-180x180.png">
<meta name="msapplication-TileImage" content="https://www.kubernetes.org.cn/img/2018/07/cropped-con999-270x270.png">
<!--[if lt IE 9]><script src="https://www.kubernetes.org.cn/wp-content/themes/dux/js/libs/html5.min.js"></script><![endif]-->
<script async="" data-requirecontext="_" data-requiremodule="main" src="./download_images_files/main.js.下载"></script><script async="" data-requirecontext="_" data-requiremodule="lazyload" src="./download_images_files/lazyload.min.js.下载"></script><script async="" data-requirecontext="_" data-requiremodule="signpop" src="./download_images_files/signpop.js.下载"></script><script async="" data-requirecontext="_" data-requiremodule="comment" src="./download_images_files/comment.js.下载"></script><link href="chrome-extension://iihgchombimnadbbapofogflgbifgbgl/content/css/fontcustom/fontcustom.css" rel="stylesheet" type="text/css"><link href="chrome-extension://iihgchombimnadbbapofogflgbifgbgl/content/css/jlzs.css" rel="stylesheet" type="text/css"><link href="chrome-extension://iihgchombimnadbbapofogflgbifgbgl/content/css/select.css" rel="stylesheet" type="text/css"><link href="chrome-extension://iihgchombimnadbbapofogflgbifgbgl/content/css/input.css" rel="stylesheet" type="text/css"><link href="chrome-extension://iihgchombimnadbbapofogflgbifgbgl/content/css/checkbox.css" rel="stylesheet" type="text/css"></head>
<body data-rsssl="1" class="post-template-default single single-post postid-3805 single-format-standard comment-open site-layout-2">
<header class="header">
	<div class="container">
		<div class="logo"><a href="https://www.kubernetes.org.cn/" title="Kubernetes中文社区"><img src="./download_images_files/logo023.jpg">Kubernetes中文社区</a></div>				<ul class="site-nav site-navbar">
			<li id="menu-item-12" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-12"><a href="https://www.kubernetes.org.cn/practice">开发实践</a></li>
<li id="menu-item-14" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-14"><a href="https://www.kubernetes.org.cn/news">行业动态</a></li>
<li id="menu-item-15" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-15"><a href="https://www.kubernetes.org.cn/course">入门教程</a></li>
<li id="menu-item-3312" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-3312"><a href="https://www.kubernetes.org.cn/course/install">安装教程</a></li>
<li id="menu-item-357" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-357"><a href="https://www.kubernetes.org.cn/%E6%96%87%E6%A1%A3%E4%B8%8B%E8%BD%BD">文档下载</a></li>
<li id="menu-item-17" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-17"><a href="https://www.kubernetes.org.cn/kubernetes%E4%BA%A4%E6%B5%81%E7%BE%A4">QQ/微信群</a></li>
<li id="menu-item-16" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-16"><a href="https://www.kubernetes.org.cn/video">视频</a></li>
<li id="menu-item-2645" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-2645"><a href="https://www.kubernetes.org.cn/meetup">活动</a></li>
<li id="menu-item-596" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-596"><a href="http://docs.kubernetes.org.cn/">中文文档</a></li>
							<li class="navto-search"><a href="javascript:;" class="search-show active"><i class="fa fa-search"></i></a></li>
					</ul>
		<div class="topbar">
			<ul class="site-nav topmenu">
				<li id="menu-item-3343" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-3343"><a href="https://www.kubernetes.org.cn/tags/kubernetes1-12">K8S 1.12版本</a></li>
<li id="menu-item-207" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-207"><a href="https://www.kubernetes.org.cn/tags/kubernetes1-11">1.11</a></li>
<li id="menu-item-2636" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-2636"><a href="https://www.kubernetes.org.cn/tags/kubernetes1-10">1.10</a></li>
<li id="menu-item-46" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-46"><a href="https://www.kubernetes.org.cn/tags/devops">DevOps</a></li>
<li id="menu-item-47" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-47"><a href="https://www.kubernetes.org.cn/tags/cicd">CI/CD</a></li>
<li id="menu-item-48" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-48"><a href="https://www.kubernetes.org.cn/tags/%E7%BD%91%E7%BB%9C">网络</a></li>
<li id="menu-item-49" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-49"><a href="https://www.kubernetes.org.cn/tags/%E5%AD%98%E5%82%A8">存储</a></li>
<li id="menu-item-50" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-50"><a href="https://www.kubernetes.org.cn/tags/%E5%AE%89%E5%85%A8">安全</a></li>
<li id="menu-item-51" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-51"><a href="https://www.kubernetes.org.cn/tags/%E7%9B%91%E6%8E%A7">监控</a></li>
<li id="menu-item-2649" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-2649"><a target="_blank" href="http://docs.kubernetes.org.cn/683.html">kubectl命令表</a></li>
				<li class="menusns">
					<a href="javascript:;">关注本站 <i class="fa fa-angle-down"></i></a>
					<ul class="sub-menu">
						<li><a class="sns-wechat" href="javascript:;" title="关注”K8S中文社区“" data-src="https://www.kubernetes.org.cn/img/2018/07/wxlogoww.jpg"><i class="fa fa-wechat"></i> 微信</a></li>																																			</ul>
				</li>
			</ul>
			<a href="https://www.kubernetes.org.cn/wp-login.php?cms=k8s" rel="nofollow">登录</a>&nbsp;|&nbsp;<a href="https://www.kubernetes.org.cn/%e8%81%94%e7%b3%bb%e6%88%91%e4%bb%ac" rel="nofollow">加入我们</a>
			<a></a>
		</div>
		<i class="fa fa-bars m-icon-nav"></i>
	</div>
</header>
<div class="site-search">
	<div class="container">
		<form method="get" class="site-search-form" action="https://www.kubernetes.org.cn/"><input class="search-input" name="s" type="text" placeholder="输入关键字" value=""><button class="search-btn" type="submit"><i class="fa fa-search"></i></button></form>	</div>
</div>
<div class="ad-top-header"><a href="https://www.kubernetes.org.cn/peixun" target="_blank"><img src="./download_images_files/k8s02-1200.jpg"></a></div><section class="container">
	<div class="content-wrap">
	<div class="content">
	<span class="contentmeta">您目前处于：</span><ul id="crumbs"><li><a href="https://www.kubernetes.org.cn/">社区首页</a></li>&gt;<li><a href="https://www.kubernetes.org.cn/course/install" rel="category tag">Kubernetes安装说明</a> </li>&gt;<li> <a href="https://www.kubernetes.org.cn/course" rel="category tag">Kubernetes教程/入门教程</a></li>&gt;<li>使用kubeadm安装Kubernetes v1.10以及常见问题解答</li></ul>				<header class="article-header">
			<h1 class="article-title"><a href="https://www.kubernetes.org.cn/3805.html">使用kubeadm安装Kubernetes v1.10以及常见问题解答</a></h1>
			<div class="article-meta">
				<span class="item">2018-04-11 09:58</span>
												<!--添加作者信息 -->
							<span class="item">
							<a href="https://www.kubernetes.org.cn/author/mr-devin" rel="author">Mr.Devin</a>
							</span>	
				
				<span class="item">分类：<a href="https://www.kubernetes.org.cn/course/install" rel="category tag">Kubernetes安装说明</a> / <a href="https://www.kubernetes.org.cn/course" rel="category tag">Kubernetes教程/入门教程</a></span>
								<span class="item post-views">阅读(13737)</span>				
				<!--添加自定义字段 -->
				<span class="item">
								</span>
				<span class="item">
								</span>
				<span class="item">评论(14)</span>
				<span class="item"></span>
			</div>
		</header>
		<article class="article-content">
						<p><strong>关于K8S：</strong></p>
<p>Kubernetes是Google开源的容器集群管理系统。它构建于docker技术之上，为容器化的应用提供资源调度、部署运行、服务发现、扩 容缩容等整一套功能，本质上可看作是基于容器技术的mini-PaaS平台。</p>
<p>相信看过我博客的童鞋应该知道，我在14年的时候就发表了一篇名为<a href="http://blog.51cto.com/devingeng/1573975" target="_blank" rel="noopener">Docker容器管理之Kubernetes</a>当时国内Docker刚刚兴起，对于Docker的兴起我很有感触，仿佛一瞬间就火了，当时也是一个偶然的机会了解到K8S，所以当时就写文简单的介绍了下K8S以及如何采用源码部署。今时不同往日K8S在容器界已经是翘首，再读旧文有感而发，索性来研究下kubeadm安装K8S以及Dashboard功能预览。</p>
<p><strong>环境描述：</strong></p>
<p>采用CentOS7.4 minimual，docker 1.13，kubeadm 1.10.0，etcd 3.0， k8s 1.10.0</p>
<p>我们这里选用三个节点搭建一个实验环境。</p>
<p class="p1"><span class="s1">10.0.100.202 k8smaster</span></p>
<p class="p1"><span class="s1">10.0.100.203 k8snode1</span></p>
<p class="p1"><span class="s1">10.0.100.204 k8snode2</span></p>
<p><strong>准备环境：</strong></p>
<p>1.配置好各节点hosts文件</p>
<p>2.关闭系统防火墙</p>
<p>3.关闭SElinux</p>
<p>4.关闭swap</p>
<p>5.配置系统内核参数使流过网桥的流量也进入iptables/netfilter框架中，在/etc/sysctl.conf中添加以下配置：</p>
<div>
<div id="highlighter_988959" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">net.bridge.bridge-nf-call-iptables&nbsp;=&nbsp;1</code></div>
<div class="line number2 index1 alt1"></div>
<div class="line number3 index2 alt2"><code class="bash plain">net.bridge.bridge-nf-call-ip6tables&nbsp;=&nbsp;1</code></div>
<div class="line number4 index3 alt1"></div>
<div class="line number5 index4 alt2"><code class="bash plain">sysctl&nbsp;-p</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p><strong>使用kubeadm安装：</strong></p>
<p>1.首先配置阿里K8S YUM源</p>
<div>
<div id="highlighter_612831" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
<div class="line number9 index8 alt2">9</div>
<div class="line number10 index9 alt1">10</div>
<div class="line number11 index10 alt2">11</div>
<div class="line number12 index11 alt1">12</div>
<div class="line number13 index12 alt2">13</div>
<div class="line number14 index13 alt1">14</div>
<div class="line number15 index14 alt2">15</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash functions">cat</code>&nbsp;<code class="bash plain">&lt;&lt;EOF&nbsp;&gt;&nbsp;</code><code class="bash plain">/etc/yum</code><code class="bash plain">.repos.d</code><code class="bash plain">/kubernetes</code><code class="bash plain">.repo</code></div>
<div class="line number2 index1 alt1"></div>
<div class="line number3 index2 alt2"><code class="bash plain">[kubernetes]</code></div>
<div class="line number4 index3 alt1"><code class="bash plain">name=Kubernetes</code></div>
<div class="line number5 index4 alt2"><code class="bash plain">baseurl=https:</code><code class="bash plain">//mirrors</code><code class="bash plain">.aliyun.com</code><code class="bash plain">/kubernetes/yum/repos/kubernetes-el7-x86_64</code></div>
<div class="line number6 index5 alt1"><code class="bash plain">enabled=1</code></div>
<div class="line number7 index6 alt2"><code class="bash plain">gpgcheck=0</code></div>
<div class="line number8 index7 alt1"></div>
<div class="line number9 index8 alt2"><code class="bash plain">EOF</code></div>
<div class="line number10 index9 alt1"></div>
<div class="line number11 index10 alt2"><code class="bash plain">yum&nbsp;-y&nbsp;</code><code class="bash functions">install</code>&nbsp;<code class="bash plain">epel-release</code></div>
<div class="line number12 index11 alt1"></div>
<div class="line number13 index12 alt2"><code class="bash plain">yum&nbsp;clean&nbsp;all</code></div>
<div class="line number14 index13 alt1"></div>
<div class="line number15 index14 alt2"><code class="bash plain">yum&nbsp;makecache</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>2.安装kubeadm和相关工具包</p>
<div>
<div id="highlighter_528081" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">yum&nbsp;-y&nbsp;</code><code class="bash functions">install</code>&nbsp;<code class="bash plain">docker&nbsp;kubelet&nbsp;kubeadm&nbsp;kubectl&nbsp;kubernetes-cni</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>3.启动Docker与kubelet服务</p>
<div>
<div id="highlighter_301619" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">systemctl&nbsp;</code><code class="bash functions">enable</code>&nbsp;<code class="bash plain">docker&nbsp;&amp;&amp;&nbsp;systemctl&nbsp;start&nbsp;docker</code></div>
<div class="line number2 index1 alt1"></div>
<div class="line number3 index2 alt2"><code class="bash plain">systemctl&nbsp;</code><code class="bash functions">enable</code>&nbsp;<code class="bash plain">kubelet&nbsp;&amp;&amp;&nbsp;systemctl&nbsp;start&nbsp;kubelet</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>提示：此时kubelet的服务运行状态是异常的，因为缺少主配置文件kubelet.conf。但可以暂不处理，因为在完成Master节点的初始化后才会生成这个配置文件。</p>
<p>4.下载K8S相关镜像</p>
<p>因为无法直接访问gcr.io下载镜像，所以需要配置一个国内的容器镜像加速器</p>
<p>配置一个阿里云的加速器：</p>
<p>登录&nbsp;<a href="https://cr.console.aliyun.com/" target="_blank" rel="noopener">https://cr.console.aliyun.com/</a></p>
<p>在页面中找到并点击镜像加速按钮，即可看到属于自己的专属加速链接，选择Centos版本后即可看到配置方法。</p>
<p>提示：在阿里云上使用 Docker 并配置阿里云镜像加速器，可能会遇到 daemon.json 导致 docker daemon 无法启动的问题，可以通过以下方法解决。</p>
<div>
<div id="highlighter_534436" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
<div class="line number9 index8 alt2">9</div>
<div class="line number10 index9 alt1">10</div>
<div class="line number11 index10 alt2">11</div>
<div class="line number12 index11 alt1">12</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">你需要的是编辑&nbsp;</code></div>
<div class="line number2 index1 alt1"></div>
<div class="line number3 index2 alt2"><code class="bash plain">vim&nbsp;</code><code class="bash plain">/etc/sysconfig/docker</code></div>
<div class="line number4 index3 alt1"></div>
<div class="line number5 index4 alt2"><code class="bash plain">然后&nbsp;</code></div>
<div class="line number6 index5 alt1"></div>
<div class="line number7 index6 alt2"><code class="bash plain">OPTIONS=</code><code class="bash string">'--selinux-enabled&nbsp;--log-driver=journald&nbsp;--registry-mirror=http://xxxx.mirror.aliyuncs.com'</code></div>
<div class="line number8 index7 alt1"><code class="bash plain">registry-mirror&nbsp;输入你的镜像地址&nbsp;</code></div>
<div class="line number9 index8 alt2"></div>
<div class="line number10 index9 alt1"><code class="bash plain">最后&nbsp;service&nbsp;docker&nbsp;restart&nbsp;重启&nbsp;daemon&nbsp;</code></div>
<div class="line number11 index10 alt2"></div>
<div class="line number12 index11 alt1"><code class="bash plain">然后&nbsp;</code><code class="bash functions">ps</code>&nbsp;<code class="bash plain">aux&nbsp;|&nbsp;</code><code class="bash functions">grep</code>&nbsp;<code class="bash plain">docker&nbsp;然后你就会发现带有镜像的启动参数了。</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>5.下载K8S相关镜像</p>
<p>OK，解决完加速器的问题之后，开始下载k8s相关镜像，下载后将镜像名改为k8s.gcr.io/开头的名字，以便kubeadm识别使用。</p>
<div>
<div id="highlighter_38845" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
<div class="line number9 index8 alt2">9</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash preprocessor bold">#!/bin/bash</code></div>
<div class="line number2 index1 alt1"><code class="bash plain">images=(kube-proxy-amd64:v1.10.0&nbsp;kube-scheduler-amd64:v1.10.0&nbsp;kube-controller-manager-amd64:v1.10.0&nbsp;kube-apiserver-amd64:v1.10.0</code></div>
<div class="line number3 index2 alt2"><code class="bash plain">etcd-amd64:3.1.12&nbsp;pause-amd64:3.1&nbsp;kubernetes-dashboard-amd64:v1.8.3&nbsp;k8s-dns-sidecar-amd64:1.14.8&nbsp;k8s-dns-kube-dns-amd64:1.14.8</code></div>
<div class="line number4 index3 alt1"><code class="bash plain">k8s-dns-dnsmasq-nanny-amd64:1.14.8)</code></div>
<div class="line number5 index4 alt2"><code class="bash keyword">for</code>&nbsp;<code class="bash plain">imageName&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">${images[@]}&nbsp;;&nbsp;</code><code class="bash keyword">do</code></div>
<div class="line number6 index5 alt1"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash plain">docker&nbsp;pull&nbsp;keveon/$imageName</code></div>
<div class="line number7 index6 alt2"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash plain">docker&nbsp;tag&nbsp;keveon/$imageName&nbsp;k8s.gcr.io/$imageName</code></div>
<div class="line number8 index7 alt1"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash plain">docker&nbsp;rmi&nbsp;keveon/$imageName</code></div>
<div class="line number9 index8 alt2"><code class="bash keyword">done</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>上面的shell脚本主要做了3件事，下载各种需要用到的容器镜像、重新打标记为符合k8s命令规范的版本名称、清除旧的容器镜像。</p>
<p>提示：镜像版本一定要和kubeadm安装的版本一致，否则会出现time out问题。</p>
<p>6.初始化安装K8S Master</p>
<p>执行上述shell脚本，等待下载完成后，执行kubeadm init</p>
<div>
<div id="highlighter_539040" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
<div class="line number9 index8 alt2">9</div>
<div class="line number10 index9 alt1">10</div>
<div class="line number11 index10 alt2">11</div>
<div class="line number12 index11 alt1">12</div>
<div class="line number13 index12 alt2">13</div>
<div class="line number14 index13 alt1">14</div>
<div class="line number15 index14 alt2">15</div>
<div class="line number16 index15 alt1">16</div>
<div class="line number17 index16 alt2">17</div>
<div class="line number18 index17 alt1">18</div>
<div class="line number19 index18 alt2">19</div>
<div class="line number20 index19 alt1">20</div>
<div class="line number21 index20 alt2">21</div>
<div class="line number22 index21 alt1">22</div>
<div class="line number23 index22 alt2">23</div>
<div class="line number24 index23 alt1">24</div>
<div class="line number25 index24 alt2">25</div>
<div class="line number26 index25 alt1">26</div>
<div class="line number27 index26 alt2">27</div>
<div class="line number28 index27 alt1">28</div>
<div class="line number29 index28 alt2">29</div>
<div class="line number30 index29 alt1">30</div>
<div class="line number31 index30 alt2">31</div>
<div class="line number32 index31 alt1">32</div>
<div class="line number33 index32 alt2">33</div>
<div class="line number34 index33 alt1">34</div>
<div class="line number35 index34 alt2">35</div>
<div class="line number36 index35 alt1">36</div>
<div class="line number37 index36 alt2">37</div>
<div class="line number38 index37 alt1">38</div>
<div class="line number39 index38 alt2">39</div>
<div class="line number40 index39 alt1">40</div>
<div class="line number41 index40 alt2">41</div>
<div class="line number42 index41 alt1">42</div>
<div class="line number43 index42 alt2">43</div>
<div class="line number44 index43 alt1">44</div>
<div class="line number45 index44 alt2">45</div>
<div class="line number46 index45 alt1">46</div>
<div class="line number47 index46 alt2">47</div>
<div class="line number48 index47 alt1">48</div>
<div class="line number49 index48 alt2">49</div>
<div class="line number50 index49 alt1">50</div>
<div class="line number51 index50 alt2">51</div>
<div class="line number52 index51 alt1">52</div>
<div class="line number53 index52 alt2">53</div>
<div class="line number54 index53 alt1">54</div>
<div class="line number55 index54 alt2">55</div>
<div class="line number56 index55 alt1">56</div>
<div class="line number57 index56 alt2">57</div>
<div class="line number58 index57 alt1">58</div>
<div class="line number59 index58 alt2">59</div>
<div class="line number60 index59 alt1">60</div>
<div class="line number61 index60 alt2">61</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">[root@k8smaster&nbsp;~]</code><code class="bash comments">#&nbsp;kubeadm&nbsp;init&nbsp;--kubernetes-version=v1.10.0&nbsp;--pod-network-cidr=10.244.0.0/16</code></div>
<div class="line number2 index1 alt1"><code class="bash plain">[init]&nbsp;Using&nbsp;Kubernetes&nbsp;version:&nbsp;v1.10.0</code></div>
<div class="line number3 index2 alt2"><code class="bash plain">[init]&nbsp;Using&nbsp;Authorization&nbsp;modes:&nbsp;[Node&nbsp;RBAC]</code></div>
<div class="line number4 index3 alt1"><code class="bash plain">[preflight]&nbsp;Running&nbsp;pre-flight&nbsp;checks.</code></div>
<div class="line number5 index4 alt2"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">[WARNING&nbsp;Service-Kubelet]:&nbsp;kubelet&nbsp;service&nbsp;is&nbsp;not&nbsp;enabled,&nbsp;please&nbsp;run&nbsp;</code><code class="bash string">'systemctl&nbsp;enable&nbsp;kubelet.service'</code></div>
<div class="line number6 index5 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">[WARNING&nbsp;FileExisting-crictl]:&nbsp;crictl&nbsp;not&nbsp;found&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">system&nbsp;path</code></div>
<div class="line number7 index6 alt2"><code class="bash plain">Suggestion:&nbsp;go&nbsp;get&nbsp;github.com</code><code class="bash plain">/kubernetes-incubator/cri-tools/cmd/crictl</code></div>
<div class="line number8 index7 alt1"><code class="bash plain">[preflight]&nbsp;Starting&nbsp;the&nbsp;kubelet&nbsp;service</code></div>
<div class="line number9 index8 alt2"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;ca&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number10 index9 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;apiserver&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number11 index10 alt2"><code class="bash plain">[certificates]&nbsp;apiserver&nbsp;serving&nbsp;cert&nbsp;is&nbsp;signed&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">DNS&nbsp;names&nbsp;[k8smaster&nbsp;kubernetes&nbsp;kubernetes.default&nbsp;kubernetes.default.svc&nbsp;kubernetes.default.svc.cluster.</code><code class="bash functions">local</code><code class="bash plain">]&nbsp;and&nbsp;IPs&nbsp;[10.96.0.1&nbsp;10.0.100.202]</code></div>
<div class="line number12 index11 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;apiserver-kubelet-client&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number13 index12 alt2"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;etcd</code><code class="bash plain">/ca</code>&nbsp;<code class="bash plain">certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number14 index13 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;etcd</code><code class="bash plain">/server</code>&nbsp;<code class="bash plain">certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number15 index14 alt2"><code class="bash plain">[certificates]&nbsp;etcd</code><code class="bash plain">/server</code>&nbsp;<code class="bash plain">serving&nbsp;cert&nbsp;is&nbsp;signed&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">DNS&nbsp;names&nbsp;[localhost]&nbsp;and&nbsp;IPs&nbsp;[127.0.0.1]</code></div>
<div class="line number16 index15 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;etcd</code><code class="bash plain">/peer</code>&nbsp;<code class="bash plain">certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number17 index16 alt2"><code class="bash plain">[certificates]&nbsp;etcd</code><code class="bash plain">/peer</code>&nbsp;<code class="bash plain">serving&nbsp;cert&nbsp;is&nbsp;signed&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">DNS&nbsp;names&nbsp;[k8smaster]&nbsp;and&nbsp;IPs&nbsp;[10.0.100.202]</code></div>
<div class="line number18 index17 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;etcd</code><code class="bash plain">/healthcheck-client</code>&nbsp;<code class="bash plain">certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number19 index18 alt2"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;apiserver-etcd-client&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number20 index19 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;sa&nbsp;key&nbsp;and&nbsp;public&nbsp;key.</code></div>
<div class="line number21 index20 alt2"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;front-proxy-ca&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number22 index21 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;front-proxy-client&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number23 index22 alt2"><code class="bash plain">[certificates]&nbsp;Valid&nbsp;certificates&nbsp;and&nbsp;keys&nbsp;now&nbsp;exist&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash string">"/etc/kubernetes/pki"</code></div>
<div class="line number24 index23 alt1"><code class="bash plain">[kubeconfig]&nbsp;Wrote&nbsp;KubeConfig&nbsp;</code><code class="bash functions">file</code>&nbsp;<code class="bash plain">to&nbsp;disk:&nbsp;</code><code class="bash string">"/etc/kubernetes/admin.conf"</code></div>
<div class="line number25 index24 alt2"><code class="bash plain">[kubeconfig]&nbsp;Wrote&nbsp;KubeConfig&nbsp;</code><code class="bash functions">file</code>&nbsp;<code class="bash plain">to&nbsp;disk:&nbsp;</code><code class="bash string">"/etc/kubernetes/kubelet.conf"</code></div>
<div class="line number26 index25 alt1"><code class="bash plain">[kubeconfig]&nbsp;Wrote&nbsp;KubeConfig&nbsp;</code><code class="bash functions">file</code>&nbsp;<code class="bash plain">to&nbsp;disk:&nbsp;</code><code class="bash string">"/etc/kubernetes/controller-manager.conf"</code></div>
<div class="line number27 index26 alt2"><code class="bash plain">[kubeconfig]&nbsp;Wrote&nbsp;KubeConfig&nbsp;</code><code class="bash functions">file</code>&nbsp;<code class="bash plain">to&nbsp;disk:&nbsp;</code><code class="bash string">"/etc/kubernetes/scheduler.conf"</code></div>
<div class="line number28 index27 alt1"><code class="bash plain">[controlplane]&nbsp;Wrote&nbsp;Static&nbsp;Pod&nbsp;manifest&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">component&nbsp;kube-apiserver&nbsp;to&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests/kube-apiserver.yaml"</code></div>
<div class="line number29 index28 alt2"><code class="bash plain">[controlplane]&nbsp;Wrote&nbsp;Static&nbsp;Pod&nbsp;manifest&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">component&nbsp;kube-controller-manager&nbsp;to&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests/kube-controller-manager.yaml"</code></div>
<div class="line number30 index29 alt1"><code class="bash plain">[controlplane]&nbsp;Wrote&nbsp;Static&nbsp;Pod&nbsp;manifest&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">component&nbsp;kube-scheduler&nbsp;to&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests/kube-scheduler.yaml"</code></div>
<div class="line number31 index30 alt2"><code class="bash plain">[etcd]&nbsp;Wrote&nbsp;Static&nbsp;Pod&nbsp;manifest&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">a&nbsp;</code><code class="bash functions">local</code>&nbsp;<code class="bash plain">etcd&nbsp;instance&nbsp;to&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests/etcd.yaml"</code></div>
<div class="line number32 index31 alt1"><code class="bash plain">[init]&nbsp;Waiting&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">the&nbsp;kubelet&nbsp;to&nbsp;boot&nbsp;up&nbsp;the&nbsp;control&nbsp;plane&nbsp;as&nbsp;Static&nbsp;Pods&nbsp;from&nbsp;directory&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests"</code><code class="bash plain">.</code></div>
<div class="line number33 index32 alt2"><code class="bash plain">[init]&nbsp;This&nbsp;might&nbsp;take&nbsp;a&nbsp;minute&nbsp;or&nbsp;longer&nbsp;</code><code class="bash keyword">if</code>&nbsp;<code class="bash plain">the&nbsp;control&nbsp;plane&nbsp;images&nbsp;have&nbsp;to&nbsp;be&nbsp;pulled.</code></div>
<div class="line number34 index33 alt1"><code class="bash plain">[apiclient]&nbsp;All&nbsp;control&nbsp;plane&nbsp;components&nbsp;are&nbsp;healthy&nbsp;after&nbsp;21.001790&nbsp;seconds</code></div>
<div class="line number35 index34 alt2"><code class="bash plain">[uploadconfig]&nbsp;Storing&nbsp;the&nbsp;configuration&nbsp;used&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">ConfigMap&nbsp;</code><code class="bash string">"kubeadm-config"</code>&nbsp;<code class="bash keyword">in</code>&nbsp;<code class="bash plain">the&nbsp;</code><code class="bash string">"kube-system"</code>&nbsp;<code class="bash plain">Namespace</code></div>
<div class="line number36 index35 alt1"><code class="bash plain">[markmaster]&nbsp;Will&nbsp;mark&nbsp;node&nbsp;k8smaster&nbsp;as&nbsp;master&nbsp;by&nbsp;adding&nbsp;a&nbsp;label&nbsp;and&nbsp;a&nbsp;taint</code></div>
<div class="line number37 index36 alt2"><code class="bash plain">[markmaster]&nbsp;Master&nbsp;k8smaster&nbsp;tainted&nbsp;and&nbsp;labelled&nbsp;with&nbsp;key</code><code class="bash plain">/value</code><code class="bash plain">:&nbsp;node-role.kubernetes.io</code><code class="bash plain">/master</code><code class="bash plain">=</code><code class="bash string">""</code></div>
<div class="line number38 index37 alt1"><code class="bash plain">[bootstraptoken]&nbsp;Using&nbsp;token:&nbsp;thczis.64adx0imeuhu23xv</code></div>
<div class="line number39 index38 alt2"><code class="bash plain">[bootstraptoken]&nbsp;Configured&nbsp;RBAC&nbsp;rules&nbsp;to&nbsp;allow&nbsp;Node&nbsp;Bootstrap&nbsp;tokens&nbsp;to&nbsp;post&nbsp;CSRs&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">order&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">nodes&nbsp;to&nbsp;get&nbsp;long&nbsp;term&nbsp;certificate&nbsp;credentials</code></div>
<div class="line number40 index39 alt1"><code class="bash plain">[bootstraptoken]&nbsp;Configured&nbsp;RBAC&nbsp;rules&nbsp;to&nbsp;allow&nbsp;the&nbsp;csrapprover&nbsp;controller&nbsp;automatically&nbsp;approve&nbsp;CSRs&nbsp;from&nbsp;a&nbsp;Node&nbsp;Bootstrap&nbsp;Token</code></div>
<div class="line number41 index40 alt2"><code class="bash plain">[bootstraptoken]&nbsp;Configured&nbsp;RBAC&nbsp;rules&nbsp;to&nbsp;allow&nbsp;certificate&nbsp;rotation&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">all&nbsp;node&nbsp;client&nbsp;certificates&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">the&nbsp;cluster</code></div>
<div class="line number42 index41 alt1"><code class="bash plain">[bootstraptoken]&nbsp;Creating&nbsp;the&nbsp;</code><code class="bash string">"cluster-info"</code>&nbsp;<code class="bash plain">ConfigMap&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">the&nbsp;</code><code class="bash string">"kube-public"</code>&nbsp;<code class="bash plain">namespace</code></div>
<div class="line number43 index42 alt2"><code class="bash plain">[addons]&nbsp;Applied&nbsp;essential&nbsp;addon:&nbsp;kube-dns</code></div>
<div class="line number44 index43 alt1"><code class="bash plain">[addons]&nbsp;Applied&nbsp;essential&nbsp;addon:&nbsp;kube-proxy</code></div>
<div class="line number45 index44 alt2"></div>
<div class="line number46 index45 alt1"><code class="bash plain">Your&nbsp;Kubernetes&nbsp;master&nbsp;has&nbsp;initialized&nbsp;successfully!</code></div>
<div class="line number47 index46 alt2"></div>
<div class="line number48 index47 alt1"><code class="bash plain">To&nbsp;start&nbsp;using&nbsp;your&nbsp;cluster,&nbsp;you&nbsp;need&nbsp;to&nbsp;run&nbsp;the&nbsp;following&nbsp;as&nbsp;a&nbsp;regular&nbsp;user:</code></div>
<div class="line number49 index48 alt2"></div>
<div class="line number50 index49 alt1"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash functions">mkdir</code>&nbsp;<code class="bash plain">-p&nbsp;$HOME/.kube</code></div>
<div class="line number51 index50 alt2"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash functions">sudo</code>&nbsp;<code class="bash functions">cp</code>&nbsp;<code class="bash plain">-i&nbsp;</code><code class="bash plain">/etc/kubernetes/admin</code><code class="bash plain">.conf&nbsp;$HOME/.kube</code><code class="bash plain">/config</code></div>
<div class="line number52 index51 alt1"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash functions">sudo</code>&nbsp;<code class="bash functions">chown</code>&nbsp;<code class="bash plain">$(</code><code class="bash functions">id</code>&nbsp;<code class="bash plain">-u):$(</code><code class="bash functions">id</code>&nbsp;<code class="bash plain">-g)&nbsp;$HOME/.kube</code><code class="bash plain">/config</code></div>
<div class="line number53 index52 alt2"></div>
<div class="line number54 index53 alt1"><code class="bash plain">You&nbsp;should&nbsp;now&nbsp;deploy&nbsp;a&nbsp;pod&nbsp;network&nbsp;to&nbsp;the&nbsp;cluster.</code></div>
<div class="line number55 index54 alt2"><code class="bash plain">Run&nbsp;</code><code class="bash string">"kubectl&nbsp;apply&nbsp;-f&nbsp;[podnetwork].yaml"</code>&nbsp;<code class="bash plain">with&nbsp;one&nbsp;of&nbsp;the&nbsp;options&nbsp;listed&nbsp;at:</code></div>
<div class="line number56 index55 alt1"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash plain">https:</code><code class="bash plain">//kubernetes</code><code class="bash plain">.io</code><code class="bash plain">/docs/concepts/cluster-administration/addons/</code></div>
<div class="line number57 index56 alt2"></div>
<div class="line number58 index57 alt1"><code class="bash plain">You&nbsp;can&nbsp;now&nbsp;</code><code class="bash functions">join</code>&nbsp;<code class="bash plain">any&nbsp;number&nbsp;of&nbsp;machines&nbsp;by&nbsp;running&nbsp;the&nbsp;following&nbsp;on&nbsp;each&nbsp;node</code></div>
<div class="line number59 index58 alt2"><code class="bash plain">as&nbsp;root:</code></div>
<div class="line number60 index59 alt1"></div>
<div class="line number61 index60 alt2"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash plain">kubeadm&nbsp;</code><code class="bash functions">join</code>&nbsp;<code class="bash plain">10.0.100.202:6443&nbsp;--token&nbsp;thczis.64adx0imeuhu23xv&nbsp;--discovery-token-ca-cert-</code><code class="bash functions">hash</code>&nbsp;<code class="bash plain">sha256:fa7b11bb569493fd44554aab0afe55a4c051cccc492dbdfafae6efeb6ffa80e6</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>&nbsp;</p>
<p>提示：选项–kubernetes-version=v1.10.0是必须的，否则会因为访问google网站被墙而无法执行命令。这里使用v1.10.0版本，刚才前面也说到了下载的容器镜像版本必须与K8S版本一致否则会出现time out。</p>
<p>上面的命令大约需要1分钟的过程，期间可以观察下tail -f /var/log/message日志文件的输出，掌握该配置过程和进度。上面最后一段的输出信息保存一份，后续添加工作节点还要用到。</p>
<p>7.配置kubectl认证信息</p>
<div>
<div id="highlighter_496982" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
<div class="line number9 index8 alt2">9</div>
<div class="line number10 index9 alt1">10</div>
<div class="line number11 index10 alt2">11</div>
<div class="line number12 index11 alt1">12</div>
<div class="line number13 index12 alt2">13</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash comments">#&nbsp;对于非root用户</code></div>
<div class="line number2 index1 alt1"><code class="bash functions">mkdir</code>&nbsp;<code class="bash plain">-p&nbsp;$HOME/.kube</code></div>
<div class="line number3 index2 alt2"></div>
<div class="line number4 index3 alt1"><code class="bash functions">sudo</code>&nbsp;<code class="bash functions">cp</code>&nbsp;<code class="bash plain">-i&nbsp;</code><code class="bash plain">/etc/kubernetes/admin</code><code class="bash plain">.conf&nbsp;$HOME/.kube</code><code class="bash plain">/config</code></div>
<div class="line number5 index4 alt2"></div>
<div class="line number6 index5 alt1"><code class="bash functions">sudo</code>&nbsp;<code class="bash functions">chown</code>&nbsp;<code class="bash plain">$(</code><code class="bash functions">id</code>&nbsp;<code class="bash plain">-u):$(</code><code class="bash functions">id</code>&nbsp;<code class="bash plain">-g)&nbsp;$HOME/.kube</code><code class="bash plain">/config</code></div>
<div class="line number7 index6 alt2"></div>
<div class="line number8 index7 alt1"><code class="bash comments">#&nbsp;对于root用户</code></div>
<div class="line number9 index8 alt2"><code class="bash functions">export</code>&nbsp;<code class="bash plain">KUBECONFIG=</code><code class="bash plain">/etc/kubernetes/admin</code><code class="bash plain">.conf</code></div>
<div class="line number10 index9 alt1"></div>
<div class="line number11 index10 alt2"><code class="bash plain">也可以直接放到~/.bash_profile</code></div>
<div class="line number12 index11 alt1"></div>
<div class="line number13 index12 alt2"><code class="bash functions">echo</code>&nbsp;<code class="bash string">"export&nbsp;KUBECONFIG=/etc/kubernetes/admin.conf"</code>&nbsp;<code class="bash plain">&gt;&gt;&nbsp;~/.bash_profile</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>8.安装flannel网络</p>
<div>
<div id="highlighter_788474" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
<div class="line number9 index8 alt2">9</div>
<div class="line number10 index9 alt1">10</div>
<div class="line number11 index10 alt2">11</div>
<div class="line number12 index11 alt1">12</div>
<div class="line number13 index12 alt2">13</div>
<div class="line number14 index13 alt1">14</div>
<div class="line number15 index14 alt2">15</div>
<div class="line number16 index15 alt1">16</div>
<div class="line number17 index16 alt2">17</div>
<div class="line number18 index17 alt1">18</div>
<div class="line number19 index18 alt2">19</div>
<div class="line number20 index19 alt1">20</div>
<div class="line number21 index20 alt2">21</div>
<div class="line number22 index21 alt1">22</div>
<div class="line number23 index22 alt2">23</div>
<div class="line number24 index23 alt1">24</div>
<div class="line number25 index24 alt2">25</div>
<div class="line number26 index25 alt1">26</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash functions">mkdir</code>&nbsp;<code class="bash plain">-p&nbsp;</code><code class="bash plain">/etc/cni/net</code><code class="bash plain">.d/</code></div>
<div class="line number2 index1 alt1"></div>
<div class="line number3 index2 alt2"><code class="bash functions">cat</code>&nbsp;<code class="bash plain">&lt;&lt;EOF&gt;&nbsp;</code><code class="bash plain">/etc/cni/net</code><code class="bash plain">.d</code><code class="bash plain">/10-flannel</code><code class="bash plain">.conf</code></div>
<div class="line number4 index3 alt1"><code class="bash plain">{</code></div>
<div class="line number5 index4 alt2"><code class="bash plain">“name”:&nbsp;“cbr0”,</code></div>
<div class="line number6 index5 alt1"><code class="bash plain">“</code><code class="bash functions">type</code><code class="bash plain">”:&nbsp;“flannel”,</code></div>
<div class="line number7 index6 alt2"><code class="bash plain">“delegate”:&nbsp;{</code></div>
<div class="line number8 index7 alt1"><code class="bash plain">“isDefaultGateway”:&nbsp;</code><code class="bash functions">true</code></div>
<div class="line number9 index8 alt2"><code class="bash plain">}</code></div>
<div class="line number10 index9 alt1"><code class="bash plain">}</code></div>
<div class="line number11 index10 alt2"></div>
<div class="line number12 index11 alt1"><code class="bash plain">EOF</code></div>
<div class="line number13 index12 alt2"></div>
<div class="line number14 index13 alt1"><code class="bash functions">mkdir</code>&nbsp;<code class="bash plain">/usr/share/oci-umount/oci-umount</code><code class="bash plain">.d&nbsp;-p</code></div>
<div class="line number15 index14 alt2"></div>
<div class="line number16 index15 alt1"><code class="bash functions">mkdir</code>&nbsp;<code class="bash plain">/run/flannel/</code></div>
<div class="line number17 index16 alt2"></div>
<div class="line number18 index17 alt1"><code class="bash functions">cat</code>&nbsp;<code class="bash plain">&lt;&lt;EOF&gt;&nbsp;</code><code class="bash plain">/run/flannel/subnet</code><code class="bash plain">.</code><code class="bash functions">env</code></div>
<div class="line number19 index18 alt2"><code class="bash plain">FLANNEL_NETWORK=10.244.0.0</code><code class="bash plain">/16</code></div>
<div class="line number20 index19 alt1"><code class="bash plain">FLANNEL_SUBNET=10.244.1.0</code><code class="bash plain">/24</code></div>
<div class="line number21 index20 alt2"><code class="bash plain">FLANNEL_MTU=1450</code></div>
<div class="line number22 index21 alt1"><code class="bash plain">FLANNEL_IPMASQ=</code><code class="bash functions">true</code></div>
<div class="line number23 index22 alt2"></div>
<div class="line number24 index23 alt1"><code class="bash plain">EOF</code></div>
<div class="line number25 index24 alt2"></div>
<div class="line number26 index25 alt1"><code class="bash plain">kubectl&nbsp;apply&nbsp;-f&nbsp;https:</code><code class="bash plain">//raw</code><code class="bash plain">.githubusercontent.com</code><code class="bash plain">/coreos/flannel/v0</code><code class="bash plain">.9.1</code><code class="bash plain">/Documentation/kube-flannel</code><code class="bash plain">.yml</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>9.让node1、node2加入集群</p>
<p>在node1和node2节点上分别执行kubeadm join命令，加入集群：</p>
<div>
<div id="highlighter_231555" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
<div class="line number9 index8 alt2">9</div>
<div class="line number10 index9 alt1">10</div>
<div class="line number11 index10 alt2">11</div>
<div class="line number12 index11 alt1">12</div>
<div class="line number13 index12 alt2">13</div>
<div class="line number14 index13 alt1">14</div>
<div class="line number15 index14 alt2">15</div>
<div class="line number16 index15 alt1">16</div>
<div class="line number17 index16 alt2">17</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">[root@k8snode1&nbsp;~]</code><code class="bash comments">#&nbsp;kubeadm&nbsp;join&nbsp;10.0.100.202:6443&nbsp;--token&nbsp;thczis.64adx0imeuhu23xv&nbsp;--discovery-token-ca-cert-hash&nbsp;sha256:fa7b11bb569493fd44554aab0afe55a4c051cccc492dbdfafae6efeb6ffa80e6</code></div>
<div class="line number2 index1 alt1"><code class="bash plain">[preflight]&nbsp;Running&nbsp;pre-flight&nbsp;checks.</code></div>
<div class="line number3 index2 alt2"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">[WARNING&nbsp;Service-Kubelet]:&nbsp;kubelet&nbsp;service&nbsp;is&nbsp;not&nbsp;enabled,&nbsp;please&nbsp;run&nbsp;</code><code class="bash string">'systemctl&nbsp;enable&nbsp;kubelet.service'</code></div>
<div class="line number4 index3 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">[WARNING&nbsp;FileExisting-crictl]:&nbsp;crictl&nbsp;not&nbsp;found&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">system&nbsp;path</code></div>
<div class="line number5 index4 alt2"><code class="bash plain">Suggestion:&nbsp;go&nbsp;get&nbsp;github.com</code><code class="bash plain">/kubernetes-incubator/cri-tools/cmd/crictl</code></div>
<div class="line number6 index5 alt1"><code class="bash plain">[discovery]&nbsp;Trying&nbsp;to&nbsp;connect&nbsp;to&nbsp;API&nbsp;Server&nbsp;</code><code class="bash string">"10.0.100.202:6443"</code></div>
<div class="line number7 index6 alt2"><code class="bash plain">[discovery]&nbsp;Created&nbsp;cluster-info&nbsp;discovery&nbsp;client,&nbsp;requesting&nbsp;info&nbsp;from&nbsp;</code><code class="bash string">"https://10.0.100.202:6443"</code></div>
<div class="line number8 index7 alt1"><code class="bash plain">[discovery]&nbsp;Requesting&nbsp;info&nbsp;from&nbsp;</code><code class="bash string">"https://10.0.100.202:6443"</code>&nbsp;<code class="bash plain">again&nbsp;to&nbsp;validate&nbsp;TLS&nbsp;against&nbsp;the&nbsp;pinned&nbsp;public&nbsp;key</code></div>
<div class="line number9 index8 alt2"><code class="bash plain">[discovery]&nbsp;Cluster&nbsp;info&nbsp;signature&nbsp;and&nbsp;contents&nbsp;are&nbsp;valid&nbsp;and&nbsp;TLS&nbsp;certificate&nbsp;validates&nbsp;against&nbsp;pinned&nbsp;roots,&nbsp;will&nbsp;use&nbsp;API&nbsp;Server&nbsp;</code><code class="bash string">"10.0.100.202:6443"</code></div>
<div class="line number10 index9 alt1"><code class="bash plain">[discovery]&nbsp;Successfully&nbsp;established&nbsp;connection&nbsp;with&nbsp;API&nbsp;Server&nbsp;</code><code class="bash string">"10.0.100.202:6443"</code></div>
<div class="line number11 index10 alt2"></div>
<div class="line number12 index11 alt1"><code class="bash plain">This&nbsp;node&nbsp;has&nbsp;joined&nbsp;the&nbsp;cluster:</code></div>
<div class="line number13 index12 alt2"><code class="bash plain">*&nbsp;Certificate&nbsp;signing&nbsp;request&nbsp;was&nbsp;sent&nbsp;to&nbsp;master&nbsp;and&nbsp;a&nbsp;response</code></div>
<div class="line number14 index13 alt1"><code class="bash spaces">&nbsp;&nbsp;</code><code class="bash plain">was&nbsp;received.</code></div>
<div class="line number15 index14 alt2"><code class="bash plain">*&nbsp;The&nbsp;Kubelet&nbsp;was&nbsp;informed&nbsp;of&nbsp;the&nbsp;new&nbsp;secure&nbsp;connection&nbsp;details.</code></div>
<div class="line number16 index15 alt1"></div>
<div class="line number17 index16 alt2"><code class="bash plain">Run&nbsp;</code><code class="bash string">'kubectl&nbsp;get&nbsp;nodes'</code>&nbsp;<code class="bash plain">on&nbsp;the&nbsp;master&nbsp;to&nbsp;see&nbsp;this&nbsp;node&nbsp;</code><code class="bash functions">join</code>&nbsp;<code class="bash plain">the&nbsp;cluster.</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>提示：细心的童鞋应该会发现，这段命令其实就是前面K8S Matser安装成功后我让你们保存的那段命令。</p>
<p>默认情况下，Master节点不参与工作负载，但如果希望安装出一个All-In-One的k8s环境，则可以执行以下命令，让Master节点也成为一个Node节点：</p>
<div>
<div id="highlighter_34656" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">kubectl&nbsp;taint&nbsp;nodes&nbsp;--all&nbsp;node-role.kubernetes.io</code><code class="bash plain">/master-</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>10.验证K8S Master是否搭建成功</p>
<div>
<div id="highlighter_292330" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash comments">#&nbsp;查看节点状态</code></div>
<div class="line number2 index1 alt1"><code class="bash plain">kubectl&nbsp;get&nbsp;nodes</code></div>
<div class="line number3 index2 alt2"></div>
<div class="line number4 index3 alt1"><code class="bash comments">#&nbsp;查看pods状态</code></div>
<div class="line number5 index4 alt2"><code class="bash plain">kubectl&nbsp;get&nbsp;pods&nbsp;--all-namespaces</code></div>
<div class="line number6 index5 alt1"></div>
<div class="line number7 index6 alt2"><code class="bash comments">#&nbsp;查看K8S集群状态</code></div>
<div class="line number8 index7 alt1"><code class="bash plain">kubectl&nbsp;get&nbsp;cs</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p><strong>常见错误解析</strong></p>
<p>安装时候最常见的就是time out，因为K8S镜像在国外，所以我们在前面就说到了提前把他下载下来，可以用一个国外机器采用habor搭建一个私有仓库把镜像都download下来。</p>
<div>
<div id="highlighter_551328" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
<div class="line number2 index1 alt1">2</div>
<div class="line number3 index2 alt2">3</div>
<div class="line number4 index3 alt1">4</div>
<div class="line number5 index4 alt2">5</div>
<div class="line number6 index5 alt1">6</div>
<div class="line number7 index6 alt2">7</div>
<div class="line number8 index7 alt1">8</div>
<div class="line number9 index8 alt2">9</div>
<div class="line number10 index9 alt1">10</div>
<div class="line number11 index10 alt2">11</div>
<div class="line number12 index11 alt1">12</div>
<div class="line number13 index12 alt2">13</div>
<div class="line number14 index13 alt1">14</div>
<div class="line number15 index14 alt2">15</div>
<div class="line number16 index15 alt1">16</div>
<div class="line number17 index16 alt2">17</div>
<div class="line number18 index17 alt1">18</div>
<div class="line number19 index18 alt2">19</div>
<div class="line number20 index19 alt1">20</div>
<div class="line number21 index20 alt2">21</div>
<div class="line number22 index21 alt1">22</div>
<div class="line number23 index22 alt2">23</div>
<div class="line number24 index23 alt1">24</div>
<div class="line number25 index24 alt2">25</div>
<div class="line number26 index25 alt1">26</div>
<div class="line number27 index26 alt2">27</div>
<div class="line number28 index27 alt1">28</div>
<div class="line number29 index28 alt2">29</div>
<div class="line number30 index29 alt1">30</div>
<div class="line number31 index30 alt2">31</div>
<div class="line number32 index31 alt1">32</div>
<div class="line number33 index32 alt2">33</div>
<div class="line number34 index33 alt1">34</div>
<div class="line number35 index34 alt2">35</div>
<div class="line number36 index35 alt1">36</div>
<div class="line number37 index36 alt2">37</div>
<div class="line number38 index37 alt1">38</div>
<div class="line number39 index38 alt2">39</div>
<div class="line number40 index39 alt1">40</div>
<div class="line number41 index40 alt2">41</div>
<div class="line number42 index41 alt1">42</div>
<div class="line number43 index42 alt2">43</div>
<div class="line number44 index43 alt1">44</div>
<div class="line number45 index44 alt2">45</div>
<div class="line number46 index45 alt1">46</div>
<div class="line number47 index46 alt2">47</div>
<div class="line number48 index47 alt1">48</div>
<div class="line number49 index48 alt2">49</div>
<div class="line number50 index49 alt1">50</div>
<div class="line number51 index50 alt2">51</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">[root@k8smaster&nbsp;~]</code><code class="bash comments">#&nbsp;kubeadm&nbsp;init</code></div>
<div class="line number2 index1 alt1"><code class="bash plain">[init]&nbsp;Using&nbsp;Kubernetes&nbsp;version:&nbsp;v1.10.0</code></div>
<div class="line number3 index2 alt2"><code class="bash plain">[init]&nbsp;Using&nbsp;Authorization&nbsp;modes:&nbsp;[Node&nbsp;RBAC]</code></div>
<div class="line number4 index3 alt1"><code class="bash plain">[preflight]&nbsp;Running&nbsp;pre-flight&nbsp;checks.</code></div>
<div class="line number5 index4 alt2"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">[WARNING&nbsp;Service-Kubelet]:&nbsp;kubelet&nbsp;service&nbsp;is&nbsp;not&nbsp;enabled,&nbsp;please&nbsp;run&nbsp;</code><code class="bash string">'systemctl&nbsp;enable&nbsp;kubelet.service'</code></div>
<div class="line number6 index5 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">[WARNING&nbsp;FileExisting-crictl]:&nbsp;crictl&nbsp;not&nbsp;found&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">system&nbsp;path</code></div>
<div class="line number7 index6 alt2"><code class="bash plain">Suggestion:&nbsp;go&nbsp;get&nbsp;github.com</code><code class="bash plain">/kubernetes-incubator/cri-tools/cmd/crictl</code></div>
<div class="line number8 index7 alt1"><code class="bash plain">[preflight]&nbsp;Starting&nbsp;the&nbsp;kubelet&nbsp;service</code></div>
<div class="line number9 index8 alt2"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;ca&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number10 index9 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;apiserver&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number11 index10 alt2"><code class="bash plain">[certificates]&nbsp;apiserver&nbsp;serving&nbsp;cert&nbsp;is&nbsp;signed&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">DNS&nbsp;names&nbsp;[k8smaster&nbsp;kubernetes&nbsp;kubernetes.default&nbsp;kubernetes.default.svc&nbsp;kubernetes.default.svc.cluster.</code><code class="bash functions">local</code><code class="bash plain">]&nbsp;and&nbsp;IPs&nbsp;[10.96.0.1&nbsp;10.0.100.202]</code></div>
<div class="line number12 index11 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;apiserver-kubelet-client&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number13 index12 alt2"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;etcd</code><code class="bash plain">/ca</code>&nbsp;<code class="bash plain">certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number14 index13 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;etcd</code><code class="bash plain">/server</code>&nbsp;<code class="bash plain">certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number15 index14 alt2"><code class="bash plain">[certificates]&nbsp;etcd</code><code class="bash plain">/server</code>&nbsp;<code class="bash plain">serving&nbsp;cert&nbsp;is&nbsp;signed&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">DNS&nbsp;names&nbsp;[localhost]&nbsp;and&nbsp;IPs&nbsp;[127.0.0.1]</code></div>
<div class="line number16 index15 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;etcd</code><code class="bash plain">/peer</code>&nbsp;<code class="bash plain">certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number17 index16 alt2"><code class="bash plain">[certificates]&nbsp;etcd</code><code class="bash plain">/peer</code>&nbsp;<code class="bash plain">serving&nbsp;cert&nbsp;is&nbsp;signed&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">DNS&nbsp;names&nbsp;[k8smaster]&nbsp;and&nbsp;IPs&nbsp;[10.0.100.202]</code></div>
<div class="line number18 index17 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;etcd</code><code class="bash plain">/healthcheck-client</code>&nbsp;<code class="bash plain">certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number19 index18 alt2"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;apiserver-etcd-client&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number20 index19 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;sa&nbsp;key&nbsp;and&nbsp;public&nbsp;key.</code></div>
<div class="line number21 index20 alt2"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;front-proxy-ca&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number22 index21 alt1"><code class="bash plain">[certificates]&nbsp;Generated&nbsp;front-proxy-client&nbsp;certificate&nbsp;and&nbsp;key.</code></div>
<div class="line number23 index22 alt2"><code class="bash plain">[certificates]&nbsp;Valid&nbsp;certificates&nbsp;and&nbsp;keys&nbsp;now&nbsp;exist&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash string">"/etc/kubernetes/pki"</code></div>
<div class="line number24 index23 alt1"><code class="bash plain">[kubeconfig]&nbsp;Wrote&nbsp;KubeConfig&nbsp;</code><code class="bash functions">file</code>&nbsp;<code class="bash plain">to&nbsp;disk:&nbsp;</code><code class="bash string">"/etc/kubernetes/admin.conf"</code></div>
<div class="line number25 index24 alt2"><code class="bash plain">[kubeconfig]&nbsp;Wrote&nbsp;KubeConfig&nbsp;</code><code class="bash functions">file</code>&nbsp;<code class="bash plain">to&nbsp;disk:&nbsp;</code><code class="bash string">"/etc/kubernetes/kubelet.conf"</code></div>
<div class="line number26 index25 alt1"><code class="bash plain">[kubeconfig]&nbsp;Wrote&nbsp;KubeConfig&nbsp;</code><code class="bash functions">file</code>&nbsp;<code class="bash plain">to&nbsp;disk:&nbsp;</code><code class="bash string">"/etc/kubernetes/controller-manager.conf"</code></div>
<div class="line number27 index26 alt2"><code class="bash plain">[kubeconfig]&nbsp;Wrote&nbsp;KubeConfig&nbsp;</code><code class="bash functions">file</code>&nbsp;<code class="bash plain">to&nbsp;disk:&nbsp;</code><code class="bash string">"/etc/kubernetes/scheduler.conf"</code></div>
<div class="line number28 index27 alt1"><code class="bash plain">[controlplane]&nbsp;Wrote&nbsp;Static&nbsp;Pod&nbsp;manifest&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">component&nbsp;kube-apiserver&nbsp;to&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests/kube-apiserver.yaml"</code></div>
<div class="line number29 index28 alt2"><code class="bash plain">[controlplane]&nbsp;Wrote&nbsp;Static&nbsp;Pod&nbsp;manifest&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">component&nbsp;kube-controller-manager&nbsp;to&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests/kube-controller-manager.yaml"</code></div>
<div class="line number30 index29 alt1"><code class="bash plain">[controlplane]&nbsp;Wrote&nbsp;Static&nbsp;Pod&nbsp;manifest&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">component&nbsp;kube-scheduler&nbsp;to&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests/kube-scheduler.yaml"</code></div>
<div class="line number31 index30 alt2"><code class="bash plain">[etcd]&nbsp;Wrote&nbsp;Static&nbsp;Pod&nbsp;manifest&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">a&nbsp;</code><code class="bash functions">local</code>&nbsp;<code class="bash plain">etcd&nbsp;instance&nbsp;to&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests/etcd.yaml"</code></div>
<div class="line number32 index31 alt1"><code class="bash plain">[init]&nbsp;Waiting&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">the&nbsp;kubelet&nbsp;to&nbsp;boot&nbsp;up&nbsp;the&nbsp;control&nbsp;plane&nbsp;as&nbsp;Static&nbsp;Pods&nbsp;from&nbsp;directory&nbsp;</code><code class="bash string">"/etc/kubernetes/manifests"</code><code class="bash plain">.</code></div>
<div class="line number33 index32 alt2"><code class="bash plain">[init]&nbsp;This&nbsp;might&nbsp;take&nbsp;a&nbsp;minute&nbsp;or&nbsp;longer&nbsp;</code><code class="bash keyword">if</code>&nbsp;<code class="bash plain">the&nbsp;control&nbsp;plane&nbsp;images&nbsp;have&nbsp;to&nbsp;be&nbsp;pulled.</code></div>
<div class="line number34 index33 alt1"></div>
<div class="line number35 index34 alt2"><code class="bash plain">Unfortunately,&nbsp;an&nbsp;error&nbsp;has&nbsp;occurred:</code></div>
<div class="line number36 index35 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">timed&nbsp;out&nbsp;waiting&nbsp;</code><code class="bash keyword">for</code>&nbsp;<code class="bash plain">the&nbsp;condition</code></div>
<div class="line number37 index36 alt2"></div>
<div class="line number38 index37 alt1"><code class="bash plain">This&nbsp;error&nbsp;is&nbsp;likely&nbsp;caused&nbsp;by:</code></div>
<div class="line number39 index38 alt2"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;The&nbsp;kubelet&nbsp;is&nbsp;not&nbsp;running</code></div>
<div class="line number40 index39 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;The&nbsp;kubelet&nbsp;is&nbsp;unhealthy&nbsp;due&nbsp;to&nbsp;a&nbsp;misconfiguration&nbsp;of&nbsp;the&nbsp;node&nbsp;</code><code class="bash keyword">in</code>&nbsp;<code class="bash plain">some&nbsp;way&nbsp;(required&nbsp;cgroups&nbsp;disabled)</code></div>
<div class="line number41 index40 alt2"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;Either&nbsp;there&nbsp;is&nbsp;no&nbsp;internet&nbsp;connection,&nbsp;or&nbsp;imagePullPolicy&nbsp;is&nbsp;</code><code class="bash functions">set</code>&nbsp;<code class="bash plain">to&nbsp;</code><code class="bash string">"Never"</code><code class="bash plain">,</code></div>
<div class="line number42 index41 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">so&nbsp;the&nbsp;kubelet&nbsp;cannot&nbsp;pull&nbsp;or&nbsp;</code><code class="bash functions">find</code>&nbsp;<code class="bash plain">the&nbsp;following&nbsp;control&nbsp;plane&nbsp;images:</code></div>
<div class="line number43 index42 alt2"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;k8s.gcr.io</code><code class="bash plain">/kube-apiserver-amd64</code><code class="bash plain">:v1.10.0</code></div>
<div class="line number44 index43 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;k8s.gcr.io</code><code class="bash plain">/kube-controller-manager-amd64</code><code class="bash plain">:v1.10.0</code></div>
<div class="line number45 index44 alt2"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;k8s.gcr.io</code><code class="bash plain">/kube-scheduler-amd64</code><code class="bash plain">:v1.10.0</code></div>
<div class="line number46 index45 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;k8s.gcr.io</code><code class="bash plain">/etcd-amd64</code><code class="bash plain">:3.1.12&nbsp;(only&nbsp;</code><code class="bash keyword">if</code>&nbsp;<code class="bash plain">no&nbsp;external&nbsp;etcd&nbsp;endpoints&nbsp;are&nbsp;configured)</code></div>
<div class="line number47 index46 alt2"></div>
<div class="line number48 index47 alt1"><code class="bash plain">If&nbsp;you&nbsp;are&nbsp;on&nbsp;a&nbsp;systemd-powered&nbsp;system,&nbsp;you&nbsp;can&nbsp;try&nbsp;to&nbsp;troubleshoot&nbsp;the&nbsp;error&nbsp;with&nbsp;the&nbsp;following&nbsp;commands:</code></div>
<div class="line number49 index48 alt2"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;</code><code class="bash string">'systemctl&nbsp;status&nbsp;kubelet'</code></div>
<div class="line number50 index49 alt1"><code class="bash spaces">&nbsp;&nbsp;&nbsp;&nbsp;</code><code class="bash plain">-&nbsp;</code><code class="bash string">'journalctl&nbsp;-xeu&nbsp;kubelet'</code></div>
<div class="line number51 index50 alt2"><code class="bash plain">couldn't&nbsp;initialize&nbsp;a&nbsp;Kubernetes&nbsp;cluster</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>那出现这个问题大部分原因是因为安装的K8S版本和依赖的K8S相关镜像版本不符导致的，关于这部分排错可以查看/var/log/message我们在文章开始安装的时候也提到了要多看日志。</p>
<p>还有些童鞋可能会说，那我安装失败了，怎么清理环境重新安装啊？下面教大家一条命令：</p>
<div>
<div id="highlighter_186470" class="syntaxhighlighter bash">
<table border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td class="gutter">
<div class="line number1 index0 alt2">1</div>
</td>
<td class="code">
<div class="container">
<div class="line number1 index0 alt2"><code class="bash plain">kubeadm&nbsp;reset</code></div>
</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<p>好了，至此就完成了K8S三节点集群的安装部署。</p>
		</article>	
		<div style="text-align:  center;"><img src="./download_images_files/2018051201.jpg" alt="K8S中文社区微信公众号" width="177" height="188">
		</div>
										<div class="social-share share-component"><a class="social-share-icon icon-weibo" target="_blank" href="http://service.weibo.com/share/share.php?url=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html&amp;title=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;pic=https%3A%2F%2Fwww.kubernetes.org.cn%2Fimg%2F2018%2F07%2Flogo023.jpg&amp;appkey="></a><a class="social-share-icon icon-qq" target="_blank" href="http://connect.qq.com/widget/shareqq/index.html?url=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html&amp;title=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;source=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;desc=%E5%85%B3%E4%BA%8EK8S%EF%BC%9A%20%20Kubernetes%E6%98%AFGoogle%E5%BC%80%E6%BA%90%E7%9A%84%E5%AE%B9%E5%99%A8%E9%9B%86%E7%BE%A4%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F%E3%80%82%E5%AE%83%E6%9E%84%E5%BB%BA%E4%BA%8Edocker%E6%8A%80%E6%9C%AF%E4%B9%8B%E4%B8%8A%EF%BC%8C%E4%B8%BA%E5%AE%B9%E5%99%A8%E5%8C%96%E7%9A%84%E5%BA%94%E7%94%A8%E6%8F%90%E4%BE%9B%E8%B5%84%E6%BA%90%E8%B0%83%E5%BA%A6%E3%80%81%E9%83%A8%E7%BD%B2%E8%BF%90%E8%A1%8C%E3%80%81%E6%9C%8D%E5%8A%A1%E5%8F%91%E7%8E%B0%E3%80%81%E6%89%A9%20%E5%AE%B9%E7%BC%A9%E5%AE%B9%E7%AD%89%E6%95%B4%E4%B8%80%E5%A5%97%E5%8A%9F%E8%83%BD%EF%BC%8C%E6%9C%AC%E8%B4%A8%E4%B8%8A%E5%8F%AF%E7%9C%8B%E4%BD%9C%E6%98%AF%E5%9F%BA%E4%BA%8E%E5%AE%B9%E5%99%A8%E6%8A%80%E6%9C%AF%E7%9A%84mini-PaaS%E5%B9%B3%E5%8F%B0%E3%80%82%20%20%E7%9B%B8%E4%BF%A1%E7%9C%8B%E8%BF%87%E6%88%91%E5%8D%9A%E5%AE%A2%E7%9A%84%E7%AB%A5%E9%9E%8B%E5%BA%94%E8%AF%A5%E7%9F%A5%E9%81%93%EF%BC%8C%E6%88%91%E5%9C%A814%E5%B9%B4%E7%9A%84%E6%97%B6%E5%80%99%E5%B0%B1%E5%8F%91%E8%A1%A8%E4%BA%86%E4%B8%80%E7%AF%87%E5%90%8D%E4%B8%BADocker%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86%E4%B9%8BKubernetes%E5%BD%93%E6%97%B6%E5%9B%BD%E5%86%85Docker%E5%88%9A%E5%88%9A&amp;pics=https%3A%2F%2Fwww.kubernetes.org.cn%2Fimg%2F2018%2F07%2Flogo023.jpg"></a><a class="social-share-icon icon-wechat" target="_blank" href="javascript:"><div class="wechat-qrcode"><h4>微信扫一扫：分享</h4><div class="qrcode" title="https://www.kubernetes.org.cn/3805.html"><canvas width="100" height="100" style="display: none;"></canvas><img alt="Scan me!" src="data:image/png;base64,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" style="display: block;"></div><div class="help"><p>微信里点“发现”，扫一下</p><p>二维码便可将本文分享至朋友圈。</p></div></div></a><a class="social-share-icon icon-tencent" target="_blank" href="http://share.v.t.qq.com/index.php?c=share&amp;a=index&amp;title=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;url=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html&amp;pic=https%3A%2F%2Fwww.kubernetes.org.cn%2Fimg%2F2018%2F07%2Flogo023.jpg"></a><a class="social-share-icon icon-douban" target="_blank" href="http://shuo.douban.com/!service/share?href=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html&amp;name=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;text=%E5%85%B3%E4%BA%8EK8S%EF%BC%9A%20%20Kubernetes%E6%98%AFGoogle%E5%BC%80%E6%BA%90%E7%9A%84%E5%AE%B9%E5%99%A8%E9%9B%86%E7%BE%A4%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F%E3%80%82%E5%AE%83%E6%9E%84%E5%BB%BA%E4%BA%8Edocker%E6%8A%80%E6%9C%AF%E4%B9%8B%E4%B8%8A%EF%BC%8C%E4%B8%BA%E5%AE%B9%E5%99%A8%E5%8C%96%E7%9A%84%E5%BA%94%E7%94%A8%E6%8F%90%E4%BE%9B%E8%B5%84%E6%BA%90%E8%B0%83%E5%BA%A6%E3%80%81%E9%83%A8%E7%BD%B2%E8%BF%90%E8%A1%8C%E3%80%81%E6%9C%8D%E5%8A%A1%E5%8F%91%E7%8E%B0%E3%80%81%E6%89%A9%20%E5%AE%B9%E7%BC%A9%E5%AE%B9%E7%AD%89%E6%95%B4%E4%B8%80%E5%A5%97%E5%8A%9F%E8%83%BD%EF%BC%8C%E6%9C%AC%E8%B4%A8%E4%B8%8A%E5%8F%AF%E7%9C%8B%E4%BD%9C%E6%98%AF%E5%9F%BA%E4%BA%8E%E5%AE%B9%E5%99%A8%E6%8A%80%E6%9C%AF%E7%9A%84mini-PaaS%E5%B9%B3%E5%8F%B0%E3%80%82%20%20%E7%9B%B8%E4%BF%A1%E7%9C%8B%E8%BF%87%E6%88%91%E5%8D%9A%E5%AE%A2%E7%9A%84%E7%AB%A5%E9%9E%8B%E5%BA%94%E8%AF%A5%E7%9F%A5%E9%81%93%EF%BC%8C%E6%88%91%E5%9C%A814%E5%B9%B4%E7%9A%84%E6%97%B6%E5%80%99%E5%B0%B1%E5%8F%91%E8%A1%A8%E4%BA%86%E4%B8%80%E7%AF%87%E5%90%8D%E4%B8%BADocker%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86%E4%B9%8BKubernetes%E5%BD%93%E6%97%B6%E5%9B%BD%E5%86%85Docker%E5%88%9A%E5%88%9A&amp;image=https%3A%2F%2Fwww.kubernetes.org.cn%2Fimg%2F2018%2F07%2Flogo023.jpg&amp;starid=0&amp;aid=0&amp;style=11"></a><a class="social-share-icon icon-qzone" target="_blank" href="http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html&amp;title=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;desc=%E5%85%B3%E4%BA%8EK8S%EF%BC%9A%20%20Kubernetes%E6%98%AFGoogle%E5%BC%80%E6%BA%90%E7%9A%84%E5%AE%B9%E5%99%A8%E9%9B%86%E7%BE%A4%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F%E3%80%82%E5%AE%83%E6%9E%84%E5%BB%BA%E4%BA%8Edocker%E6%8A%80%E6%9C%AF%E4%B9%8B%E4%B8%8A%EF%BC%8C%E4%B8%BA%E5%AE%B9%E5%99%A8%E5%8C%96%E7%9A%84%E5%BA%94%E7%94%A8%E6%8F%90%E4%BE%9B%E8%B5%84%E6%BA%90%E8%B0%83%E5%BA%A6%E3%80%81%E9%83%A8%E7%BD%B2%E8%BF%90%E8%A1%8C%E3%80%81%E6%9C%8D%E5%8A%A1%E5%8F%91%E7%8E%B0%E3%80%81%E6%89%A9%20%E5%AE%B9%E7%BC%A9%E5%AE%B9%E7%AD%89%E6%95%B4%E4%B8%80%E5%A5%97%E5%8A%9F%E8%83%BD%EF%BC%8C%E6%9C%AC%E8%B4%A8%E4%B8%8A%E5%8F%AF%E7%9C%8B%E4%BD%9C%E6%98%AF%E5%9F%BA%E4%BA%8E%E5%AE%B9%E5%99%A8%E6%8A%80%E6%9C%AF%E7%9A%84mini-PaaS%E5%B9%B3%E5%8F%B0%E3%80%82%20%20%E7%9B%B8%E4%BF%A1%E7%9C%8B%E8%BF%87%E6%88%91%E5%8D%9A%E5%AE%A2%E7%9A%84%E7%AB%A5%E9%9E%8B%E5%BA%94%E8%AF%A5%E7%9F%A5%E9%81%93%EF%BC%8C%E6%88%91%E5%9C%A814%E5%B9%B4%E7%9A%84%E6%97%B6%E5%80%99%E5%B0%B1%E5%8F%91%E8%A1%A8%E4%BA%86%E4%B8%80%E7%AF%87%E5%90%8D%E4%B8%BADocker%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86%E4%B9%8BKubernetes%E5%BD%93%E6%97%B6%E5%9B%BD%E5%86%85Docker%E5%88%9A%E5%88%9A&amp;summary=%E5%85%B3%E4%BA%8EK8S%EF%BC%9A%20%20Kubernetes%E6%98%AFGoogle%E5%BC%80%E6%BA%90%E7%9A%84%E5%AE%B9%E5%99%A8%E9%9B%86%E7%BE%A4%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F%E3%80%82%E5%AE%83%E6%9E%84%E5%BB%BA%E4%BA%8Edocker%E6%8A%80%E6%9C%AF%E4%B9%8B%E4%B8%8A%EF%BC%8C%E4%B8%BA%E5%AE%B9%E5%99%A8%E5%8C%96%E7%9A%84%E5%BA%94%E7%94%A8%E6%8F%90%E4%BE%9B%E8%B5%84%E6%BA%90%E8%B0%83%E5%BA%A6%E3%80%81%E9%83%A8%E7%BD%B2%E8%BF%90%E8%A1%8C%E3%80%81%E6%9C%8D%E5%8A%A1%E5%8F%91%E7%8E%B0%E3%80%81%E6%89%A9%20%E5%AE%B9%E7%BC%A9%E5%AE%B9%E7%AD%89%E6%95%B4%E4%B8%80%E5%A5%97%E5%8A%9F%E8%83%BD%EF%BC%8C%E6%9C%AC%E8%B4%A8%E4%B8%8A%E5%8F%AF%E7%9C%8B%E4%BD%9C%E6%98%AF%E5%9F%BA%E4%BA%8E%E5%AE%B9%E5%99%A8%E6%8A%80%E6%9C%AF%E7%9A%84mini-PaaS%E5%B9%B3%E5%8F%B0%E3%80%82%20%20%E7%9B%B8%E4%BF%A1%E7%9C%8B%E8%BF%87%E6%88%91%E5%8D%9A%E5%AE%A2%E7%9A%84%E7%AB%A5%E9%9E%8B%E5%BA%94%E8%AF%A5%E7%9F%A5%E9%81%93%EF%BC%8C%E6%88%91%E5%9C%A814%E5%B9%B4%E7%9A%84%E6%97%B6%E5%80%99%E5%B0%B1%E5%8F%91%E8%A1%A8%E4%BA%86%E4%B8%80%E7%AF%87%E5%90%8D%E4%B8%BADocker%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86%E4%B9%8BKubernetes%E5%BD%93%E6%97%B6%E5%9B%BD%E5%86%85Docker%E5%88%9A%E5%88%9A&amp;site=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA"></a><a class="social-share-icon icon-linkedin" target="_blank" href="http://www.linkedin.com/shareArticle?mini=true&amp;ro=true&amp;title=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;url=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html&amp;summary=%E5%85%B3%E4%BA%8EK8S%EF%BC%9A%20%20Kubernetes%E6%98%AFGoogle%E5%BC%80%E6%BA%90%E7%9A%84%E5%AE%B9%E5%99%A8%E9%9B%86%E7%BE%A4%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F%E3%80%82%E5%AE%83%E6%9E%84%E5%BB%BA%E4%BA%8Edocker%E6%8A%80%E6%9C%AF%E4%B9%8B%E4%B8%8A%EF%BC%8C%E4%B8%BA%E5%AE%B9%E5%99%A8%E5%8C%96%E7%9A%84%E5%BA%94%E7%94%A8%E6%8F%90%E4%BE%9B%E8%B5%84%E6%BA%90%E8%B0%83%E5%BA%A6%E3%80%81%E9%83%A8%E7%BD%B2%E8%BF%90%E8%A1%8C%E3%80%81%E6%9C%8D%E5%8A%A1%E5%8F%91%E7%8E%B0%E3%80%81%E6%89%A9%20%E5%AE%B9%E7%BC%A9%E5%AE%B9%E7%AD%89%E6%95%B4%E4%B8%80%E5%A5%97%E5%8A%9F%E8%83%BD%EF%BC%8C%E6%9C%AC%E8%B4%A8%E4%B8%8A%E5%8F%AF%E7%9C%8B%E4%BD%9C%E6%98%AF%E5%9F%BA%E4%BA%8E%E5%AE%B9%E5%99%A8%E6%8A%80%E6%9C%AF%E7%9A%84mini-PaaS%E5%B9%B3%E5%8F%B0%E3%80%82%20%20%E7%9B%B8%E4%BF%A1%E7%9C%8B%E8%BF%87%E6%88%91%E5%8D%9A%E5%AE%A2%E7%9A%84%E7%AB%A5%E9%9E%8B%E5%BA%94%E8%AF%A5%E7%9F%A5%E9%81%93%EF%BC%8C%E6%88%91%E5%9C%A814%E5%B9%B4%E7%9A%84%E6%97%B6%E5%80%99%E5%B0%B1%E5%8F%91%E8%A1%A8%E4%BA%86%E4%B8%80%E7%AF%87%E5%90%8D%E4%B8%BADocker%E5%AE%B9%E5%99%A8%E7%AE%A1%E7%90%86%E4%B9%8BKubernetes%E5%BD%93%E6%97%B6%E5%9B%BD%E5%86%85Docker%E5%88%9A%E5%88%9A&amp;source=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;armin=armin"></a><a class="social-share-icon icon-diandian" target="_blank" href="http://www.diandian.com/share?lo=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html&amp;ti=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;type=link"></a><a class="social-share-icon icon-facebook" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html"></a><a class="social-share-icon icon-twitter" target="_blank" href="https://twitter.com/intent/tweet?text=%E4%BD%BF%E7%94%A8kubeadm%E5%AE%89%E8%A3%85Kubernetes%20v1.10%E4%BB%A5%E5%8F%8A%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98%E8%A7%A3%E7%AD%94_Kubernetes%E4%B8%AD%E6%96%87%E7%A4%BE%E5%8C%BA&amp;url=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html&amp;via=https%3A%2F%2Fwww.kubernetes.org.cn"></a><a class="social-share-icon icon-google" target="_blank" href="https://plus.google.com/share?url=https%3A%2F%2Fwww.kubernetes.org.cn%2F3805.html"></a></div>
				<!-- 文章分析 share.css -->
				<link rel="stylesheet" href="./download_images_files/share.min.css">
				<!-- share.js -->
				<script src="./download_images_files/social-share.min.js.下载"></script>
	<nav>	
		<span class="nav-float-1">上一篇: <a href="https://www.kubernetes.org.cn/3797.html" rel="prev">Kubernetes安装部署演示介绍-（二）</a></span>
		<span class="nav-float-2">下一篇: <a href="https://www.kubernetes.org.cn/3808.html" rel="next">kubeadm安装Kubernetes V1.10集群详细文档</a></span>
	</nav>
<div style="clear:both;"></div>
		<div class="article-tags">标签：<a href="https://www.kubernetes.org.cn/tags/k8s%e4%bb%a3%e7%a0%81%e8%a7%a3%e8%af%bb" rel="tag">k8s代码解读</a><a href="https://www.kubernetes.org.cn/tags/kubeadm" rel="tag">kubeadm</a><a href="https://www.kubernetes.org.cn/tags/kubernetes1-10" rel="tag">Kubernetes1.10</a></div>
				<div class="relates"><div class="title"><h3>相关推荐</h3></div><ul><li><a href="https://www.kubernetes.org.cn/4725.html">kubeadm HA master(v1.12.1)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico + helm) For Centos/Fedora</a></li><li><a href="https://www.kubernetes.org.cn/4619.html">使用kubeadm安装Kubernetes 1.12</a></li><li><a href="https://www.kubernetes.org.cn/4594.html">将Kubeadm单Master集群平滑升级至HA Master集群</a></li><li><a href="https://www.kubernetes.org.cn/4567.html">kubeadm HA master(v1.11.0)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico)</a></li><li><a href="https://www.kubernetes.org.cn/4563.html">kubeadm HA master集群master重置故障恢复</a></li><li><a href="https://www.kubernetes.org.cn/4408.html">玩转K8S之如何访问业务应用（Traefik-ingress篇）</a></li><li><a href="https://www.kubernetes.org.cn/4257.html">kubernetes 通过kube-router 代理kube-proxy calico 发布serviceip 和pod IP 和交换机建bgp,另使用bind9 做coredns的转发</a></li><li><a href="https://www.kubernetes.org.cn/4256.html">centos7使用kubeadm安装kubernetes 1.11版本多主高可用</a></li></ul></div>				<div class="title" id="comments">
	<h3>评论 <b>14</b></h3>
</div>
<div id="respond" class="no_webshot">
		
	<form action="https://www.kubernetes.org.cn/wp-comments-post.php" method="post" id="commentform">
		<div class="comt">
			<div class="comt-title">
				<img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png">				<p><a id="cancel-comment-reply-link" href="javascript:;">取消</a></p>
			</div>
			<div class="comt-box">
				<textarea placeholder="社区交流" class="input-block-level comt-area" name="comment" id="comment" cols="100%" rows="3" tabindex="1" onkeydown="if(event.ctrlKey&amp;&amp;event.keyCode==13){document.getElementById(&#39;submit&#39;).click();return false};"></textarea>
				<div class="comt-ctrl">
					<div class="comt-tips"><input type="hidden" name="comment_post_ID" value="3805" id="comment_post_ID">
<input type="hidden" name="comment_parent" id="comment_parent" value="0">
<label for="comment_mail_notify" class="checkbox inline hide" style="padding-top:0"><input type="checkbox" name="comment_mail_notify" id="comment_mail_notify" value="comment_mail_notify" checked="checked">有人回复时邮件通知我</label><p class="hctpc_block"><span class="hctpc_wrap hctpc_recognition">
				<label class="hctpc_label" for="hctpc_input_90"><span class="hctpc_images_wrap"><span class="hctpc_span"><img class="hctpc_img " src="data:image/png;base64,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" alt="image"></span><span class="hctpc_span"><img class="hctpc_img " src="data:image/png;base64,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" alt="image"></span><span class="hctpc_span"><img class="hctpc_img " src="data:image/png;base64,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" alt="image"></span><span class="hctpc_span"><img class="hctpc_img " src="data:image/png;base64,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" alt="image"></span><span class="hctpc_span"><img class="hctpc_img " src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAMAAADDpiTIAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAABhQTFRFiIiI////AAAAYGBguLi49fX13d3dMjIyhQMs8AAABWFJREFUeNrs3cFu2zAQRVGNRUr//8dFjRTownZkpQaqeeeuk4XMEw5pOMlyU3SLlwAAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAAADASwCAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAALgY+2zDjQB6PrTcGj9AejaOLb+ADTd/kcVALmtWwGQvP6zAEge/1UABI//rQCIHv8TALd/ANz+ATD+AXD7B8D4B8DtHwDjH4De439OAIIBLGeXH4Dk8Q9A+PgHoMn4LwCCASxVAAQDGAVAMICfjX8Awsc/AOHjH4Dw8Q9A+PgH4MrjvwqAYABLAZAMYCsAggGs/3D9Aci8/QNg/ANwzdvfKACCAexbARAMYJkFQDCAD6w/AMHjH4Dc2z8AF9z+JwDBAMZnlh+A5PEPwGXWfxYAwQCWKgCCAYwCIBjAvk0AggGc+7MvAPS5/Z9Y/20BIHn8z30FoMn4P7P+236zA/QY/+f+6td+AyB3/P/++Qcg+PZ/X38AUsf/1/oD0KDtB+sPQIct4Mz6nxkfAPyvd4Dz6w9Aj4d5c/3HXwdI/zQq7x4wTn4nAD1uAssNgH5vBR/eyedyA6AfgMMHwbmev0MCcP2D4J/rPwD9Pg8w3jz+fQFwC2jT9t7xzw7Qrf3N8Q9At9b3xv89nwlMOQiOx98ynQEyDoLPntcOEHEQfDj+AWjY43cEH4//e34xJOAgOF58PQD9D4IvHxWA7gfB5+P/+cgAoM9B8MX4P/LmEQAXPwiOU4dGALocBL99SjtA54Pg6/EPQOPGgfEPQOe278f/07cNAGhxEDz2gAC0FXDwvOgWkJ0dAAAAAAAgtgUAAABIBuAWYAcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAEgAASAABAAAkAACAABIAAEgAAQAAJAAAgAASAABIAAAEAACAABIAAEgAAQAAJAAAgAASAABIAAEAACQAAIAAGgBv0SYACFudcj/Eb08AAAAABJRU5ErkJggg==" alt="image"></span></span>
				<input id="hctpc_input_90" class="hctpc_input hctpc_wp_comments" type="text" autocomplete="off" name="hctpc_number" value="" maxlength="5" size="5" aria-required="true" required="required" style="margin-bottom: 0px; font-size: 12px; max-width: 100%; width: 210px;">
				<input type="hidden" name="hctpc_result" value="yk6psTLt"><input type="hidden" name="hctpc_time" value="1543585232">
					<input type="hidden" name="hctpc_form" value="wp_comments">
				</label><span class="hctpc_reload_button_wrap hide-if-no-js">
					<noscript>
						<style type="text/css">
							.hide-if-no-js {
								display: none !important;
							}
						</style>
					</noscript>
					<span class="hctpc_reload_button dashicons dashicons-update"></span>
				</span></span></p><div class="comt-tip comt-loading" style="display: none;">评论提交中...</div><div class="comt-tip comt-error" style="display: none;">#</div></div>
					<button type="submit" name="submit" id="submit" tabindex="5">提交评论</button>
					<!-- <span data-type="comment-insert-smilie" class="muted comt-smilie"><i class="icon-thumbs-up icon12"></i> 表情</span> -->
				</div>
			</div>

												<div class="comt-comterinfo" id="comment-author-info">
						<ul>
							<li class="form-inline"><label class="hide" for="author">昵称</label><input class="ipt" type="text" name="author" id="author" value="" tabindex="2" placeholder="昵称"><span class="text-muted">昵称 (必填)</span></li>
							<li class="form-inline"><label class="hide" for="email">邮箱</label><input class="ipt" type="text" name="email" id="email" value="" tabindex="3" placeholder="邮箱"><span class="text-muted">邮箱 (必填)</span></li>
							<li class="form-inline"><label class="hide" for="url">网址</label><input class="ipt" type="text" name="url" id="url" value="" tabindex="4" placeholder="网址"><span class="text-muted">网址</span></li>
						</ul>
					</div>
									</div>

	</form>
	</div>
<div id="postcomments">
	<ol class="commentlist">
		<li class="comment even thread-even depth-1" id="comment-258"><span class="comt-f">#9</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-258"><p>我想问下有人装成功了没</p>
<div class="comt-meta"><span class="comt-author">uD83CuDF1Fберечь</span>8个月前 (04-11)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-258&quot;, &quot;258&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给uD83CuDF1Fберечь">回复</a></div></div></li><!-- #comment-## -->
<li class="comment odd alt thread-odd thread-alt depth-1" id="comment-257"><span class="comt-f">#8</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-257"><p>dashboard n呢？</p>
<div class="comt-meta"><span class="comt-author">似念似恋</span>8个月前 (04-11)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-257&quot;, &quot;257&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给似念似恋">回复</a></div></div><ul class="children">
<li class="comment even depth-2" id="comment-270"><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-270"><p>+1 </p>
<div class="comt-meta"><span class="comt-author">qq961499697</span>8个月前 (04-17)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-270&quot;, &quot;270&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给qq961499697">回复</a></div></div></li><!-- #comment-## -->
<li class="comment odd alt depth-2" id="comment-269"><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-269"><p>+1 </p>
<div class="comt-meta"><span class="comt-author">qq961499697</span>8个月前 (04-17)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-269&quot;, &quot;269&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给qq961499697">回复</a></div></div></li><!-- #comment-## -->
<li class="comment even depth-2" id="comment-282"><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-282"><p>马上发布</p>
<div class="comt-meta"><span class="comt-author">看雪</span>8个月前 (04-19)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-282&quot;, &quot;282&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给看雪">回复</a></div></div></li><!-- #comment-## -->
</ul><!-- .children -->
</li><!-- #comment-## -->
<li class="comment odd alt thread-even depth-1" id="comment-256"><span class="comt-f">#7</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-256"><p>楼主你好，我没有配置阿里云加速镜像加速，我在本地已经下载好镜像，重名为k8s.gcr.io开头的镜像，但是用kubeadm一直卡在[init] This might take a minute or longer if the control plane images have to be pulled走不下去，请问你是如何解决的</p>
<div class="comt-meta"><span class="comt-author">妙手空空</span>8个月前 (04-11)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-256&quot;, &quot;256&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给妙手空空">回复</a></div></div><ul class="children">
<li class="comment even depth-2" id="comment-284"><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-284"><p>估计是你本地镜像的版本和你kubeadm初始化的版本不一致</p>
<div class="comt-meta"><span class="comt-author">看雪</span>8个月前 (04-19)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-284&quot;, &quot;284&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给看雪">回复</a></div></div></li><!-- #comment-## -->
<li class="comment odd alt depth-2" id="comment-283"><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-283"><p>你好，你这个问题应该是你本地镜像的版本和kubeadm init的版本不一致导致的</p>
<div class="comt-meta"><span class="comt-author">看雪</span>8个月前 (04-19)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-283&quot;, &quot;283&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给看雪">回复</a></div></div></li><!-- #comment-## -->
</ul><!-- .children -->
</li><!-- #comment-## -->
<li class="comment even thread-odd thread-alt depth-1" id="comment-264"><span class="comt-f">#6</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-264"><p>已经有镜像加速了为什么还要科学上网？</p>
<div class="comt-meta"><span class="comt-author">陌上</span>8个月前 (04-12)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-264&quot;, &quot;264&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给陌上">回复</a></div></div></li><!-- #comment-## -->
<li class="comment odd alt thread-even depth-1" id="comment-281"><span class="comt-f">#5</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-281"><p>感激不尽，安装成功了。因为墙的问题搞了好几天，还专门去装了代理，不过配置还是有点问题，docker拉镜像还是不行，如果早点看到这个就好了。安装有问题的请去看看log ：（centos7） k8s的log在 /var/log/messages， docker的log ： journalctl -u docker</p>
<div class="comt-meta"><span class="comt-author">追梦魂</span>7个月前 (04-20)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-281&quot;, &quot;281&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给追梦魂">回复</a></div></div></li><!-- #comment-## -->
<li class="comment even thread-odd thread-alt depth-1" id="comment-294"><span class="comt-f">#4</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-294"><p>通过集群部署实例发现网络不通，期望能在后面加上简单实例</p>
<div class="comt-meta"><span class="comt-author">神造有机体</span>7个月前 (04-24)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-294&quot;, &quot;294&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给神造有机体">回复</a></div></div></li><!-- #comment-## -->
<li class="comment odd alt thread-even depth-1" id="comment-293"><span class="comt-f">#3</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-293"><p>楼主，你好，flannel网络是每个节点都要安装吗？还是node节点安装就行了呢？</p>
<div class="comt-meta"><span class="comt-author">彩虹</span>7个月前 (04-24)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-293&quot;, &quot;293&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给彩虹">回复</a></div></div></li><!-- #comment-## -->
<li class="comment even thread-odd thread-alt depth-1" id="comment-300"><span class="comt-f">#2</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo avatar-default" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-300"><p>我访问dashboard一直出现禁言访问的问题，请问楼主怎么解决：<br>
configmaps is forbidden: User system:anonymous cannot list configmaps in the namespace default<br>
close<br>
warning<br>
persistentvolumeclaims is forbidden: User system:anonymous cannot list persistentvolumeclaims in the namespace default<br>
close<br>
warning<br>
secrets is forbidden: User system:anonymous cannot list secrets in the namespace default </p>
<div class="comt-meta"><span class="comt-author">ht騲木艮縋篴</span>7个月前 (04-26)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-300&quot;, &quot;300&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给ht騲木艮縋篴">回复</a></div></div></li><!-- #comment-## -->
<li class="comment odd alt thread-even depth-1" id="comment-682"><span class="comt-f">#1</span><div class="comt-avatar"><img alt="" data-src="https://secure.gravatar.com/avatar/06b976c62ce079561288b3843183a9a8?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/06b976c62ce079561288b3843183a9a8?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/avatar-default.png"></div><div class="comt-main" id="div-comment-682"><p>你好，这个问题解决了吗，我现在安装1.12也遇到这个问题，镜像已经load到本地并且打好tag，也与kubeadm init的版本一致，但一直报错去google上拉取镜像，知道什么原因吗</p>
<div class="comt-meta"><span class="comt-author">panguicai</span>2周前 (11-13)<a rel="nofollow" class="comment-reply-link" href="javascript:;" onclick="return addComment.moveForm( &quot;div-comment-682&quot;, &quot;682&quot;, &quot;respond&quot;, &quot;3805&quot; )" aria-label="回复给panguicai">回复</a></div></div></li><!-- #comment-## -->
	</ol>
	<div class="pagenav">
			</div>
</div>
	</div>
	</div>
	<aside class="sidebar">
<div class="widget widget_ui_textasb affix-top" style="top: 0px;"><a class="style01" href="https://www.kubernetes.org.cn/tags/kubernetes1-11" target="_blank"><strong>Kubernetes 1.11 版本</strong><h2></h2><p>2018年第二个大版本Kubernetes 1.11，主要亮点集中在网络层面，以beta测试形式开放来自SIG-API Machinery与SIG-Node的两项主要功能…</p></a></div><div class="widget widget_ui_ads" style="top: 0px;"><div class="item"><img src="./download_images_files/wx101902.jpg"></div></div><div class="widget widget_ui_posts" style="top: 0px;"><h3>最新文章</h3><ul><li><a target="_blank" href="https://www.kubernetes.org.cn/4887.html"><span class="diandian"></span><span class="thumbnail"><img src="./download_images_files/wfefwef22-220x110.jpg" alt="Kubernetes网络分析之Flannel_Kubernetes中文社区" class="thumb"></span><span class="text">Kubernetes网络分析之Flannel</span><span class="muted">2018-11-29</span><span class="muted">评论()</span></a></li>
<li><a target="_blank" href="https://www.kubernetes.org.cn/4877.html"><span class="diandian"></span><span class="thumbnail"><img src="./download_images_files/20181124142236w-220x140.jpg" alt="使用CSI和Kubernetes实现动态扩容_Kubernetes中文社区" class="thumb"></span><span class="text">使用CSI和Kubernetes实现动态扩容</span><span class="muted">2018-11-24</span><span class="muted">评论()</span></a></li>
<li><a target="_blank" href="https://www.kubernetes.org.cn/4872.html"><span class="diandian"></span><span class="thumbnail"><img src="./download_images_files/wwfefefe22-220x150.jpg" alt="奇虎360开源基于Kubernetes管理平台 Wayne_Kubernetes中文社区" class="thumb"></span><span class="text">奇虎360开源基于Kubernetes管理平台 Wayne</span><span class="muted">2018-11-22</span><span class="muted">评论()</span></a></li>
<li><a target="_blank" href="https://www.kubernetes.org.cn/4855.html"><span class="diandian"></span><span class="thumbnail"><img src="./download_images_files/wfefe322-220x150.jpg" alt="CNCF调查：自2018年3月以来，亚洲云使用率增长135%_Kubernetes中文社区" class="thumb"></span><span class="text">CNCF调查：自2018年3月以来，亚洲云使用率增长135%</span><span class="muted">2018-11-20</span><span class="muted">评论()</span></a></li>
</ul></div><div class="widget widget_ui_posts"><h3>热门推荐</h3><ul><li><a target="_blank" href="https://www.kubernetes.org.cn/4855.html"><span class="thumbnail"><img src="./download_images_files/wfefe322-220x150.jpg" alt="CNCF调查：自2018年3月以来，亚洲云使用率增长135%_Kubernetes中文社区" class="thumb"></span><span class="text">CNCF调查：自2018年3月以来，亚洲云使用率增长135%</span><span class="muted">2018-11-20</span><!--<span class="muted">评论()</span>--></a></li>
<li><a target="_blank" href="https://www.kubernetes.org.cn/4838.html"><span class="thumbnail"><img src="./download_images_files/wwfeefef-220x105.jpg" alt="2018 KubeCon PPT 下载_Kubernetes中文社区" class="thumb"></span><span class="text">2018 KubeCon PPT 下载</span><span class="muted">2018-11-17</span><!--<span class="muted">评论()</span>--></a></li>
<li><a target="_blank" href="https://www.kubernetes.org.cn/4823.html"><span class="thumbnail"><img src="./download_images_files/fefe-220x150.jpg" alt="美团容器平台架构及容器技术实践_Kubernetes中文社区" class="thumb"></span><span class="text">美团容器平台架构及容器技术实践</span><span class="muted">2018-11-15</span><!--<span class="muted">评论()</span>--></a></li>
<li><a target="_blank" href="https://www.kubernetes.org.cn/4786.html"><span class="thumbnail"><img src="./download_images_files/20181112003346262-220x150.png" alt="容器、容器集群管理平台与Kubernetes技术漫谈_Kubernetes中文社区" class="thumb"></span><span class="text">容器、容器集群管理平台与Kubernetes技术漫谈</span><span class="muted">2018-11-12</span><!--<span class="muted">评论()</span>--></a></li>
<li><a target="_blank" href="https://www.kubernetes.org.cn/4619.html"><span class="thumbnail"><img src="./download_images_files/fefefe-220x150.jpg" alt="使用kubeadm安装Kubernetes 1.12_Kubernetes中文社区" class="thumb"></span><span class="text">使用kubeadm安装Kubernetes 1.12</span><span class="muted">2018-10-08</span><!--<span class="muted">评论(2)</span>--></a></li>
<li><a target="_blank" href="https://www.kubernetes.org.cn/4105.html"><span class="thumbnail"><img src="./download_images_files/thumbnail.png" class="thumb" alt="Kubernetes-基于flannel的集群网络_Kubernetes中文社区"></span><span class="text">Kubernetes-基于flannel的集群网络</span><span class="muted">2018-09-17</span><!--<span class="muted">评论()</span>--></a></li>
</ul></div><div class="widget widget_tag_cloud"><h3>社区标签</h3><div class="tagcloud"><a href="https://www.kubernetes.org.cn/tags/bocloud%e5%8d%9a%e4%ba%91" class="tag-cloud-link tag-link-178 tag-link-position-1" style="font-size: 10.692307692308pt;" aria-label="BoCloud博云 (6 items)">BoCloud博云</a>
<a href="https://www.kubernetes.org.cn/tags/centos" class="tag-cloud-link tag-link-93 tag-link-position-2" style="font-size: 8pt;" aria-label="CentOS (4 items)">CentOS</a>
<a href="https://www.kubernetes.org.cn/tags/ceph" class="tag-cloud-link tag-link-66 tag-link-position-3" style="font-size: 8pt;" aria-label="Ceph (4 items)">Ceph</a>
<a href="https://www.kubernetes.org.cn/tags/cicd" class="tag-cloud-link tag-link-16 tag-link-position-4" style="font-size: 13.384615384615pt;" aria-label="CI/CD (9 items)">CI/CD</a>
<a href="https://www.kubernetes.org.cn/tags/cncf" class="tag-cloud-link tag-link-126 tag-link-position-5" style="font-size: 18.051282051282pt;" aria-label="CNCF (17 items)">CNCF</a>
<a href="https://www.kubernetes.org.cn/tags/coreos" class="tag-cloud-link tag-link-73 tag-link-position-6" style="font-size: 10.692307692308pt;" aria-label="CoreOS (6 items)">CoreOS</a>
<a href="https://www.kubernetes.org.cn/tags/devops" class="tag-cloud-link tag-link-22 tag-link-position-7" style="font-size: 14.102564102564pt;" aria-label="DevOps (10 items)">DevOps</a>
<a href="https://www.kubernetes.org.cn/tags/docker" class="tag-cloud-link tag-link-47 tag-link-position-8" style="font-size: 19.128205128205pt;" aria-label="Docker (20 items)">Docker</a>
<a href="https://www.kubernetes.org.cn/tags/helm" class="tag-cloud-link tag-link-100 tag-link-position-9" style="font-size: 22pt;" aria-label="Helm (29 items)">Helm</a>
<a href="https://www.kubernetes.org.cn/tags/jenkins" class="tag-cloud-link tag-link-67 tag-link-position-10" style="font-size: 13.384615384615pt;" aria-label="Jenkins (9 items)">Jenkins</a>
<a href="https://www.kubernetes.org.cn/tags/k8s%e4%bb%a3%e7%a0%81%e8%a7%a3%e8%af%bb" class="tag-cloud-link tag-link-26 tag-link-position-11" style="font-size: 16.076923076923pt;" aria-label="k8s代码解读 (13 items)">k8s代码解读</a>
<a href="https://www.kubernetes.org.cn/tags/kube-dns" class="tag-cloud-link tag-link-41 tag-link-position-12" style="font-size: 8pt;" aria-label="kube-dns (4 items)">kube-dns</a>
<a href="https://www.kubernetes.org.cn/tags/kubeadm" class="tag-cloud-link tag-link-52 tag-link-position-13" style="font-size: 19.846153846154pt;" aria-label="kubeadm (22 items)">kubeadm</a>
<a href="https://www.kubernetes.org.cn/tags/kubecon" class="tag-cloud-link tag-link-121 tag-link-position-14" style="font-size: 10.692307692308pt;" aria-label="KubeCon (6 items)">KubeCon</a>
<a href="https://www.kubernetes.org.cn/tags/kubelet" class="tag-cloud-link tag-link-76 tag-link-position-15" style="font-size: 9.4358974358974pt;" aria-label="Kubelet (5 items)">Kubelet</a>
<a href="https://www.kubernetes.org.cn/tags/kubernetes1-4" class="tag-cloud-link tag-link-28 tag-link-position-16" style="font-size: 10.692307692308pt;" aria-label="Kubernetes1.4 (6 items)">Kubernetes1.4</a>
<a href="https://www.kubernetes.org.cn/tags/kubernetes1-5" class="tag-cloud-link tag-link-50 tag-link-position-17" style="font-size: 16.974358974359pt;" aria-label="Kubernetes1.5 (15 items)">Kubernetes1.5</a>
<a href="https://www.kubernetes.org.cn/tags/kubernetes1-6" class="tag-cloud-link tag-link-71 tag-link-position-18" style="font-size: 16.615384615385pt;" aria-label="Kubernetes1.6 (14 items)">Kubernetes1.6</a>
<a href="https://www.kubernetes.org.cn/tags/kubernetes1-7" class="tag-cloud-link tag-link-80 tag-link-position-19" style="font-size: 18.410256410256pt;" aria-label="Kubernetes1.7 (18 items)">Kubernetes1.7</a>
<a href="https://www.kubernetes.org.cn/tags/kubernetes1-8" class="tag-cloud-link tag-link-85 tag-link-position-20" style="font-size: 15.358974358974pt;" aria-label="Kubernetes1.8 (12 items)">Kubernetes1.8</a>
<a href="https://www.kubernetes.org.cn/tags/kubernetes1-9" class="tag-cloud-link tag-link-103 tag-link-position-21" style="font-size: 16.615384615385pt;" aria-label="Kubernetes1.9 (14 items)">Kubernetes1.9</a>
<a href="https://www.kubernetes.org.cn/tags/kubernetes1-10" class="tag-cloud-link tag-link-137 tag-link-position-22" style="font-size: 14.102564102564pt;" aria-label="Kubernetes1.10 (10 items)">Kubernetes1.10</a>
<a href="https://www.kubernetes.org.cn/tags/linkerd" class="tag-cloud-link tag-link-90 tag-link-position-23" style="font-size: 9.4358974358974pt;" aria-label="Linkerd (5 items)">Linkerd</a>
<a href="https://www.kubernetes.org.cn/tags/mesos" class="tag-cloud-link tag-link-49 tag-link-position-24" style="font-size: 8pt;" aria-label="Mesos (4 items)">Mesos</a>
<a href="https://www.kubernetes.org.cn/tags/openstack" class="tag-cloud-link tag-link-24 tag-link-position-25" style="font-size: 11.589743589744pt;" aria-label="OpenStack (7 items)">OpenStack</a>
<a href="https://www.kubernetes.org.cn/tags/paas" class="tag-cloud-link tag-link-75 tag-link-position-26" style="font-size: 14.102564102564pt;" aria-label="PaaS (10 items)">PaaS</a>
<a href="https://www.kubernetes.org.cn/tags/pod" class="tag-cloud-link tag-link-20 tag-link-position-27" style="font-size: 12.487179487179pt;" aria-label="Pod (8 items)">Pod</a>
<a href="https://www.kubernetes.org.cn/tags/prometheus" class="tag-cloud-link tag-link-78 tag-link-position-28" style="font-size: 8pt;" aria-label="Prometheus (4 items)">Prometheus</a>
<a href="https://www.kubernetes.org.cn/tags/rancher" class="tag-cloud-link tag-link-14 tag-link-position-29" style="font-size: 17.512820512821pt;" aria-label="Rancher (16 items)">Rancher</a>
<a href="https://www.kubernetes.org.cn/tags/redis" class="tag-cloud-link tag-link-31 tag-link-position-30" style="font-size: 8pt;" aria-label="Redis (4 items)">Redis</a>
<a href="https://www.kubernetes.org.cn/tags/serverless" class="tag-cloud-link tag-link-168 tag-link-position-31" style="font-size: 10.692307692308pt;" aria-label="Serverless (6 items)">Serverless</a>
<a href="https://www.kubernetes.org.cn/tags/service" class="tag-cloud-link tag-link-40 tag-link-position-32" style="font-size: 9.4358974358974pt;" aria-label="Service (5 items)">Service</a>
<a href="https://www.kubernetes.org.cn/tags/service-mesh" class="tag-cloud-link tag-link-120 tag-link-position-33" style="font-size: 12.487179487179pt;" aria-label="service mesh (8 items)">service mesh</a>
<a href="https://www.kubernetes.org.cn/tags/swarm" class="tag-cloud-link tag-link-46 tag-link-position-34" style="font-size: 8pt;" aria-label="Swarm (4 items)">Swarm</a>
<a href="https://www.kubernetes.org.cn/tags/%e4%bc%81%e4%b8%9a%e6%a1%88%e4%be%8b" class="tag-cloud-link tag-link-77 tag-link-position-35" style="font-size: 21.461538461538pt;" aria-label="企业案例 (27 items)">企业案例</a>
<a href="https://www.kubernetes.org.cn/tags/%e5%ad%98%e5%82%a8" class="tag-cloud-link tag-link-13 tag-link-position-36" style="font-size: 18.051282051282pt;" aria-label="存储 (17 items)">存储</a>
<a href="https://www.kubernetes.org.cn/tags/%e5%ae%89%e5%85%a8" class="tag-cloud-link tag-link-33 tag-link-position-37" style="font-size: 11.589743589744pt;" aria-label="安全 (7 items)">安全</a>
<a href="https://www.kubernetes.org.cn/tags/%e5%ae%b9%e5%99%a8" class="tag-cloud-link tag-link-53 tag-link-position-38" style="font-size: 9.4358974358974pt;" aria-label="容器 (5 items)">容器</a>
<a href="https://www.kubernetes.org.cn/tags/%e5%ae%b9%e5%99%a8%e4%ba%91" class="tag-cloud-link tag-link-43 tag-link-position-39" style="font-size: 9.4358974358974pt;" aria-label="容器云 (5 items)">容器云</a>
<a href="https://www.kubernetes.org.cn/tags/%e5%be%ae%e6%9c%8d%e5%8a%a1" class="tag-cloud-link tag-link-62 tag-link-position-40" style="font-size: 16.974358974359pt;" aria-label="微服务 (15 items)">微服务</a>
<a href="https://www.kubernetes.org.cn/tags/azure" class="tag-cloud-link tag-link-68 tag-link-position-41" style="font-size: 10.692307692308pt;" aria-label="微软Azure (6 items)">微软Azure</a>
<a href="https://www.kubernetes.org.cn/tags/%e6%97%a5%e5%bf%97" class="tag-cloud-link tag-link-59 tag-link-position-42" style="font-size: 11.589743589744pt;" aria-label="日志 (7 items)">日志</a>
<a href="https://www.kubernetes.org.cn/tags/%e7%81%b5%e9%9b%80%e4%ba%91" class="tag-cloud-link tag-link-197 tag-link-position-43" style="font-size: 14.102564102564pt;" aria-label="灵雀云 (10 items)">灵雀云</a>
<a href="https://www.kubernetes.org.cn/tags/%e7%9b%91%e6%8e%a7" class="tag-cloud-link tag-link-18 tag-link-position-44" style="font-size: 15.358974358974pt;" aria-label="监控 (12 items)">监控</a>
<a href="https://www.kubernetes.org.cn/tags/%e7%bd%91%e7%bb%9c" class="tag-cloud-link tag-link-17 tag-link-position-45" style="font-size: 19.487179487179pt;" aria-label="网络 (21 items)">网络</a></div>
</div><div class="widget widget_nav_menu" style="top: 0px;"><h3>Kubernetes 版本资讯</h3><div class="menu-kubernetes%e7%89%88%e6%9c%ac%e6%9b%b4%e6%96%b0-container"><ul id="menu-kubernetes%e7%89%88%e6%9c%ac%e6%9b%b4%e6%96%b0" class="menu"><li id="menu-item-4870" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-4870"><a target="_blank" rel="nofollow" href="https://github.com/kubernetes/kubernetes/releases/tag/v1.13.0-beta.1">Kubernetes v1.13 beta.1 发布</a></li>
<li id="menu-item-4186" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-4186"><a target="_blank" rel="nofollow" href="https://www.kubernetes.org.cn/4617.html">Kubernetes v1.12 已发布</a></li>
<li id="menu-item-4437" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-4437"><a target="_blank" rel="nofollow" href="https://github.com/kubernetes/kubernetes/releases/tag/v1.11.2">Kubernetes v1.11.2 版本已发布</a></li>
<li id="menu-item-4213" class="menu-item menu-item-type-post_type menu-item-object-post menu-item-4213"><a href="https://www.kubernetes.org.cn/4212.html">Kubernetes v1.11 正式版已发布</a></li>
</ul></div></div><div class="widget widget_ui_comments"><h3>最新评论</h3><ul><li><a href="https://www.kubernetes.org.cn/4725.html#comment-713" title="kubeadm HA master(v1.12.1)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico + helm) For Centos/Fedora上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/0f9f157104b68242be763da08fa6b4c7?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/0f9f157104b68242be763da08fa6b4c7?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/0f9f157104b68242be763da08fa6b4c7" style="display: block;"> <strong>nuaa1001</strong> 11小时前说：<br>显示 calico-node-7lb9x calico-node-z45xj kube-proxy-8rnr6  kube-proxy-wwvt4  为 nodelost状态 其他正常 可能是什么原因</a></li><li><a href="https://www.kubernetes.org.cn/4725.html#comment-712" title="kubeadm HA master(v1.12.1)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico + helm) For Centos/Fedora上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/e5c906a19bf9158cf4573a869877afd4?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/e5c906a19bf9158cf4573a869877afd4?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/e5c906a19bf9158cf4573a869877afd4.png" style="display: block;"> <strong>lentil1016</strong> 1天前说：<br>说明有一些容器一直没有启动成功，Ctrl + c后执行kubectl get pods -n kube-system查看有哪些容器启动失败</a></li><li><a href="https://www.kubernetes.org.cn/4725.html#comment-711" title="kubeadm HA master(v1.12.1)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico + helm) For Centos/Fedora上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/1623100c5dd1bf825392f0c8508ede5e?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/1623100c5dd1bf825392f0c8508ede5e?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/1623100c5dd1bf825392f0c8508ede5e" style="display: block;"> <strong>unicorn</strong> 2天前说：<br>楼主你好，卡在这里20分钟左右Waiting for all pods into 'Running' statu. You can press 'Ctrl + c' to terminate this</a></li><li><a href="https://www.kubernetes.org.cn/4630.html#comment-710" title="阿里云Kubernetes实战1--集群搭建与服务暴露上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/7300389d1c71ccfacbe5b750fc94a2c0?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/7300389d1c71ccfacbe5b750fc94a2c0?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/7300389d1c71ccfacbe5b750fc94a2c0" style="display: block;"> <strong>皮特哥哥</strong> 2天前说：<br>cool</a></li><li><a href="https://www.kubernetes.org.cn/4725.html#comment-709" title="kubeadm HA master(v1.12.1)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico + helm) For Centos/Fedora上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/e5c906a19bf9158cf4573a869877afd4?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/e5c906a19bf9158cf4573a869877afd4?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/e5c906a19bf9158cf4573a869877afd4.png" style="display: block;"> <strong>lentil1016</strong> 2天前说：<br>kubeadm目前是BETA测试阶段，社区不再阻止使用者在生产环境使用该工具，但也没有明确推荐。我目前还没有遇到什么由Kubeadm引发的问题，但具体是否要在生产上使用应该由读者自行判断。</a></li><li><a href="https://www.kubernetes.org.cn/4567.html#comment-708" title="kubeadm HA master(v1.11.0)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico)上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/e5c906a19bf9158cf4573a869877afd4?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/e5c906a19bf9158cf4573a869877afd4?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/e5c906a19bf9158cf4573a869877afd4.png" style="display: block;"> <strong>lentil1016</strong> 2天前说：<br>服务发现具体是指什么？如果是指DNS的话，coreDNS是默认安装的。负载均衡对外负载均衡L7是traefik，k8s master是L4负载均衡用的keepalived。另外这个是1.11.0版本的</a></li><li><a href="https://www.kubernetes.org.cn/4567.html#comment-707" title="kubeadm HA master(v1.11.0)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico)上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/343d6ab15ce2190705252441e8083e40?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/343d6ab15ce2190705252441e8083e40?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/343d6ab15ce2190705252441e8083e40" style="display: block;"> <strong>hyvi</strong> 3天前说：<br>这个只是搭建k8s，没有包含服务发现和对外的负载均衡吗？</a></li><li><a href="https://www.kubernetes.org.cn/kubernetes%e8%ae%be%e8%ae%a1%e6%9e%b6%e6%9e%84#comment-706" title="Kubernetes设计架构上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/24424bbb6b745d7009270e5dbe8d18ab?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/24424bbb6b745d7009270e5dbe8d18ab?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/24424bbb6b745d7009270e5dbe8d18ab" style="display: block;"> <strong>root</strong> 4天前说：<br>放大10倍就有码了</a></li><li><a href="https://www.kubernetes.org.cn/k8s#comment-705" title="Kubernetes概述上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/91a153875a643ab18d724fa9d6c95801?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/91a153875a643ab18d724fa9d6c95801?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/91a153875a643ab18d724fa9d6c95801" style="display: block;"> <strong>Lucifer</strong> 5天前说：<br>哈哈,笑死，这些技术和文档都是英文的，只是翻译过来  来学习技术 何必追毛求疵，自己理解就好了</a></li><li><a href="https://www.kubernetes.org.cn/4725.html#comment-704" title="kubeadm HA master(v1.12.1)集群搭建指南(离线包 + 自动化脚本 + ipvs + keepalived + calico + helm) For Centos/Fedora上的评论"><img alt="" data-src="https://secure.gravatar.com/avatar/4e53fb096252ec2e40bcce44590b955e?s=50&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g" srcset="https://secure.gravatar.com/avatar/4e53fb096252ec2e40bcce44590b955e?s=100&amp;d=https%3A%2F%2Fwww.kubernetes.org.cn%2Fwp-content%2Fthemes%2Fdux%2Fimg%2Favatar-default.png&amp;r=g 2x" class="avatar avatar-50 photo" height="50" width="50" src="./download_images_files/4e53fb096252ec2e40bcce44590b955e" style="display: block;"> <strong>Jasontom</strong> 6天前说：<br>请问，目前 kubeadm 能用于生产吗？</a></li></ul></div></aside></section>


<footer class="footer">
	<div class="container">
						<p>© 2018 Kubernetes中文社区 &nbsp; <a href="http://www.miitbeian.gov.cn/" rel="nofollow" target="_blank">粤ICP备16060255号-2</a>&nbsp;<a href="https://www.kubernetes.org.cn/%E7%89%88%E6%9D%83%E8%AF%B4%E6%98%8E" rel="nofollow" target="_blank">版权说明</a>&nbsp;<a href="https://www.kubernetes.org.cn/%E8%81%94%E7%B3%BB%E6%88%91%E4%BB%AC" rel="nofollow" target="_blank">联系我们</a>&nbsp;<a href="https://www.kubernetes.org.cn/%E5%B9%BF%E5%91%8A%E6%8A%95%E6%94%BE" rel="nofollow" target="_blank">广告投放</a>
</p>
			</div>
</footer>

<script>
window.jsui={
    www: 'https://www.kubernetes.org.cn',
    uri: 'https://www.kubernetes.org.cn/wp-content/themes/dux',
    ver: '1.5',
	roll: ["1","2","3","6"],
    ajaxpager: '0',
    url_rp: 'https://www.kubernetes.org.cn/password'
};
</script>
<script type="text/javascript" src="./download_images_files/bootstrap.min.js.下载"></script>
<script type="text/javascript" src="./download_images_files/loader.js.下载"></script>
<script type="text/javascript" src="./download_images_files/wp-embed.min.js.下载"></script>
<script type="text/javascript">
/* <![CDATA[ */
var hctpc_vars = {"nonce":"d5449a0c29","ajaxurl":"https:\/\/www.kubernetes.org.cn\/wp-admin\/admin-ajax.php","enlarge":""};
/* ]]> */
</script>
<script type="text/javascript" src="./download_images_files/front_end_script.js.下载"></script>
<script type="text/javascript" src="./download_images_files/baidutongji.js.下载"></script>
<script>
(function(){
    var bp = document.createElement('script');
    var curProtocol = window.location.protocol.split(':')[0];
    if (curProtocol === 'https') {
        bp.src = 'https://zz.bdstatic.com/linksubmit/push.js';        
    }
    else {
        bp.src = 'http://push.zhanzhang.baidu.com/push.js';
    }
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(bp, s);
})();
</script>

    <div class="m-mask"></div>    <div class="rollbar" style="display: block;"><ul><li><a href="javascript:(scrollTo(&#39;#comments&#39;,-15));"><i class="fa fa-comments"></i></a><h6>去评论<i></i></h6></li><li><a href="javascript:(scrollTo());"><i class="fa fa-angle-up"></i></a><h6>去顶部<i></i></h6></li>    </ul></div><ul class="m-navbar">
			<li id="menu-item-12" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-12"><a href="https://www.kubernetes.org.cn/practice">开发实践</a></li>
<li id="menu-item-14" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-14"><a href="https://www.kubernetes.org.cn/news">行业动态</a></li>
<li id="menu-item-15" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-15"><a href="https://www.kubernetes.org.cn/course">入门教程</a></li>
<li id="menu-item-3312" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-3312"><a href="https://www.kubernetes.org.cn/course/install">安装教程</a></li>
<li id="menu-item-357" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-357"><a href="https://www.kubernetes.org.cn/%E6%96%87%E6%A1%A3%E4%B8%8B%E8%BD%BD">文档下载</a></li>
<li id="menu-item-17" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-17"><a href="https://www.kubernetes.org.cn/kubernetes%E4%BA%A4%E6%B5%81%E7%BE%A4">QQ/微信群</a></li>
<li id="menu-item-16" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-16"><a href="https://www.kubernetes.org.cn/video">视频</a></li>
<li id="menu-item-2645" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-2645"><a href="https://www.kubernetes.org.cn/meetup">活动</a></li>
<li id="menu-item-596" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-596"><a href="http://docs.kubernetes.org.cn/">中文文档</a></li>
							<li class="navto-search"><a href="javascript:;" class="search-show active"><i class="fa fa-search"></i></a></li>
					</ul>			<div class="sign">			    <div class="sign-mask"></div>			    <div class="container">			        <a href="javascript:;" class="close-link signclose-loader"><i class="fa fa-close"></i></a>			        <div class="sign-tips"></div>			        <form id="sign-in">  			            <h3><small class="signup-loader">切换注册</small>登录</h3>			            <h6>			                <label for="inputEmail">用户名或邮箱</label>			                <input type="text" name="username" class="form-control" id="inputEmail" placeholder="用户名或邮箱">			            </h6>			            <h6>			                <label for="inputPassword">密码</label>			                <input type="password" name="password" class="form-control" id="inputPassword" placeholder="登录密码">			            </h6>			            <div class="sign-submit">			                <input type="button" class="btn btn-primary signsubmit-loader" name="submit" value="登录">  			                <input type="hidden" name="action" value="signin">			                <label><input type="checkbox" checked="checked" name="remember" value="forever">记住我</label>			            </div><div class="sign-info"><a href="https://www.kubernetes.org.cn/password">找回密码？</a></div></form>			        <form id="sign-up"> 			            <h3>注册</h3>			            <h6>			                <label for="inputName">昵称 英文或数字</label>			                <input type="text" name="name" class="form-control" id="inputName" placeholder="设置昵称">			            </h6>			            <h6>			                <label for="inputEmail">邮箱</label>			                <input type="email" name="email" class="form-control" id="inputEmail" placeholder="邮箱">			            </h6>			            <div class="sign-submit">			                <input type="button" class="btn btn-primary btn-block signsubmit-loader" name="submit" value="快速注册">  			                <input type="hidden" name="action" value="signup">  			            </div>			        </form>			    </div>			</div>		<div id="jlzsCpn_0_component_0" class=" jlzs-container jlzs-gate" style="width: auto; height: 749px;"></div></body></html>
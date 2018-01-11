<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>城市三级联动 - citys</title>
    <meta name="keywords" content="城市三级联动,行政区划,省市区,区划代码,联动插件">
    <meta name="description" content="一套简单实用的行政区划选择插件，结合最新的省、市、区、街道数据；独立的数据包极大地方便了插件的更新和使用。">
    <link rel="shortcut icon" href="/public/image/favicon.png">
    <link rel="stylesheet" type="text/css" href="/public/style/cssreset-min.css">
    <link rel="stylesheet" type="text/css" href="/public/style/common.css">
    <style type="text/css">
        .citys {
            margin-bottom: 10px;
        }

        .citys p {
            line-height: 28px;
        }

        .warning {
            color: #c00;
        }

        .main a {
            margin-right: 8px;
            color: #369;
        }
    </style>
    <script type="text/javascript" src="/public/script/jquery.min.js"></script>
    <script type="text/javascript" src="/code/jquery.citys.js"></script>
    <script src="http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js"></script>
</head>
<body>
<div class="header">
    <a href="https://github.com/mumuy/widget" target="_blank">项目地址</a>
    <a href="/">返回首页</a>
</div>
<div class="main">
    <div id="location" class="citys">
        <p>您现在的位置：</p>
        <p>
            <select name="province"></select>
            <select name="city"></select>
            <select name="area"></select>
        </p>
    </div>
    <div class="code">
        <p>根据IP地址定位：<a href="http://passer-by.com/api/#docs/ip" target="_blank">IP接口文档</a></p>
    </div>
    <script type="text/javascript">
        if (remote_ip_info) {
            $('#location').citys({
                province: remote_ip_info['province'],
                city: remote_ip_info['city'],
                area: remote_ip_info['district']
            });
        }
    </script>
    <div id="demo" class="citys">
        <p>
            <select name="province"></select>
            <select name="city"></select>
            <select name="area"></select>
        </p>
    </div>
    <div class="code">
        <p>通过地区编码初始化设置</p>
        <p>$('#demo').citys({code:350206});</p>
    </div>
    <script type="text/javascript">
        $('#demo').citys({code: 350206});
    </script>
    <div id="demo1" class="citys">
        <p>
            <select name="province"></select>
            <select name="city"></select>
            <select name="area"></select>
        </p>
    </div>
    <div class="code">
        <p>通过地区名称初始化设置，并且下拉框值为地区名称</p>
        <p>$('#demo1').citys({valueType:'name',province:'福建',city:'厦门',area:'思明'});</p>
    </div>
    <script type="text/javascript">
        $('#demo1').citys({valueType: 'name', province: '福建', city: '厦门', area: '思明'});
    </script>
    <div id="demo2" class="citys">
        <p>
            <select name="province"></select>
            <select name="city"></select>
            <select name="area"></select>
        </p>
        <p id="place">请选择地区</p>
    </div>
    <div class="code">
        <p>事件处理</p>
<pre>
$('#demo2').citys({
    required:false,
    nodata:'disabled',
    onChange:function(data){
        var text = data['direct']?'(直辖市)':'';
        $('#place').text('当前选中地区：'+data['province']+text+' '+data['city']+' '+data['area']);
    }
});
</pre>
    </div>
    <script type="text/javascript">
        $('#demo2').citys({
            required: false,
            nodata: 'disabled',
            onChange: function (data) {
                var text = data['direct'] ? '(直辖市)' : '';
                $('#place').text('当前选中地区：' + data['province'] + text + ' ' + data['city'] + ' ' + data['area']);
            }
        });
    </script>
    <div id="demo3" class="citys">
        <p>
            <select name="province"></select>
            <select name="city"></select>
            <select name="area"></select>
            <select name="town"></select>
        </p>
    </div>
    <div class="code">
        <p>扩展显示行政区划第四级(街道)信息：</p>
<pre>
    var $town = $('#demo3 select[name="town"]');
    var townFormat = function(info){
    $town.hide().empty();
    if(info['code']%1e4&&info['code']<7e6){	//是否为“区”且不是港澳台地区
    	$.ajax({
    		url:'http://passer-by.com/data_location/town/'+info['code']+'.json',
    		dataType:'json',
    		success:function(town){
    			$town.show();
    			for(i in town){
    					$town.append('&lt;option value="'+i+'"&gt;'+town[i]+'&lt;/option&gt;');
    			}
    		}
    	});
    }
    };
    $('#demo3').citys({
        province:'福建',
        city:'厦门',
        area:'思明',
        onChange:function(info){
        	townFormat(info);
        }
    },function(api){
        var info = api.getInfo();
        townFormat(info);
    });
</pre>
    </div>
    <script type="text/javascript">
        var $town = $('#demo3 select[name="town"]');
        var townFormat = function (info) {
            $town.hide().empty();
            if (info['code'] % 1e4 && info['code'] < 7e5) {	//是否为“区”且不是港澳台地区
                $.ajax({
                    url: 'http://passer-by.com/data_location/town/' + info['code'] + '.json',
                    dataType: 'json',
                    success: function (town) {
                        $town.show();
                        for (i in town) {
                            $town.append('<option value="' + i + '">' + town[i] + '</option>');
                        }
                    }
                });
            }
        };
        $('#demo3').citys({
            province: '福建',
            city: '厦门',
            area: '思明',
            onChange: function (info) {
                townFormat(info);
            }
        }, function (api) {
            var info = api.getInfo();
            townFormat(info);
        });
    </script>
    <div class="example">
        <div class="call">
            <h1>调用方法：</h1>
            <p>$(selector).citys(options,callback);</p>
        </div>
        <h2> options参数</h2>
        <table>
            <thead>
            <tr>
                <th width="150">参数</th>
                <th width="120">默认值</th>
                <th>说明</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>dataUrl</td>
                <td>[数据库地址]</td>
                <td>
                    <p>最新数据库（
                        <script src="http://passer-by.com/data_location/version.js"></script>
                        ）：<a href="http://passer-by.com/data_location/list.json" target="_blank">JSON格式</a><a
                                href="http://passer-by.com/data_location/list.jsonp" target="_blank">JSONP格式</a></p>
                    <p>数据库项目：<a href="https://github.com/mumuy/data_location" target="_blank">中国行政区划（省、市、区、街道）</a></p>
                </td>
            </tr>
            <tr>
                <td>dataType</td>
                <td>'json'</td>
                <td>
                    <p>数据库类型:'json'或'jsonp'</p>
                    <p class="warning">IE9-由于默认安全设置，需开启“通过域访问数据源”才能跨域访问json，此类情况建议使用jsonp格式</p>
                </td>
            </tr>
            <tr>
                <td>crossDomain</td>
                <td>true</td>
                <td>
                    <p>是否开启跨域</p>
                    <p class="warning">IE9-如果设置开启跨域而实际未跨域，造成请求异常</p>
                </td>
            </tr>
            <tr>
                <td>provinceField</td>
                <td>'province'</td>
                <td>省份(省级)字段名</td>
            </tr>
            <tr>
                <td>cityField</td>
                <td>'city'</td>
                <td>城市(地级)字段名</td>
            </tr>
            <tr>
                <td>areaField</td>
                <td>'area'</td>
                <td>地区(县区级)字段名</td>
            </tr>
            <tr>
                <td>valueType</td>
                <td>'code'</td>
                <td>下拉框值的类型,code行政区划代码,name地名</td>
            </tr>
            <tr>
                <td>code</td>
                <td>0</td>
                <td>地区编码</td>
            </tr>
            <tr>
                <td>province</td>
                <td>[无]</td>
                <td>省份(省级),可以为地区编码或者名称</td>
            </tr>
            <tr>
                <td>city</td>
                <td>[无]</td>
                <td>城市(地级),可以为地区编码或者名称</td>
            </tr>
            <tr>
                <td>area</td>
                <td>[无]</td>
                <td>地区(县区级),可以为地区编码或者名称</td>
            </tr>
            <tr>
                <td>required</td>
                <td>true</td>
                <td>是否必须选中(是否自动选择地区)</td>
            </tr>
            <tr>
                <td>nodata</td>
                <td>'hidden'</td>
                <td>当无数据时的表现形式:'hidden'隐藏,'disabled'禁用,为空不做任何处理</td>
            </tr>
            <tr>
                <td>onChange(info)</td>
                <td>[无]</td>
                <td>地区切换时触发,回调函数传入地区信息:direct是否为直辖市,province省份(省级)名称,city城市(地级)名称,area地区(县区级)名称,code地区编码</td>
            </tr>
            </tbody>
        </table>
        <h2>callback(api)参数</h2>
        <table>
            <thead>
            <tr>
                <th width="200">方法</th>
                <th>说明</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>getInfo(data)</td>
                <td>获取当前选中的地区信息:direct是否为直辖市,province省份(省级)名称,city城市(地级)名称,area地区(县区级)名称,code地区编码</td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<div style="display: none;">
    <script src="http://s11.cnzz.com/z_stat.php?id=1260218562&web_id=1260218562"></script>
</div>
</body>
</html>

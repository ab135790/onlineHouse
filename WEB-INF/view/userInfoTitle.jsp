<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/view/include/taglib.jsp" %>
<script type="text/javascript">
    function getIndexDataJson(){
        $.ajax({
            url: "/indexDataJson.do",
            type: "post",
            async: true,
            dataType: "json",
            success: function(data) {
                userInfoTitle(data)
            }
        });
    }
    getIndexDataJson();
</script>
<script id="_userInfoTitle" type="text/html">
    <table class="userInfoTitle">
        <tr class="userInfoTitle_tr">
            <td class="userInfoTitle_td userInfoTitle_cor">姓名</td>
            <td class="userInfoTitle_td">{{D_Name}}</td>
            <td class="userInfoTitle_td userInfoTitle_cor">中 签 号</td>
            <td class="userInfoTitle_td">{{ballotnum?ballotnum:'暂无'}}</td>
        </tr>
        <tr class="userInfoTitle_tr">
            <td class="userInfoTitle_td userInfoTitle_cor">分组</td>
            <td class="userInfoTitle_td">第{{groupnum?groupnum:'暂无'}}组</td>
            <td class="userInfoTitle_td userInfoTitle_cor">选房时间</td>
            <td class="userInfoTitle_td">{{selecttime}}开始</td>
        </tr>
    </table>
</script>
<script type="text/javascript">
    function userInfoTitle(dsData){
        let newObject = JSON.parse(JSON.stringify(dsData));
        newObject.selecttime = dayjs(dsData.selecttime).format('HH点mm分');
        let html1 = template('_userInfoTitle', newObject);
        document.getElementById('userInfoTitle').innerHTML = html1;
    }
</script>

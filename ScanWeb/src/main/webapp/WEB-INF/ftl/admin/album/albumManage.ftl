<#include "/admin/layout/common/layout.ftl">
<@layout title="相册管理">
<div class="rightBar">
    <link href="${e.res('/css/goods_edit_list.css')}" rel="stylesheet" type="text/css" />
    <link href="${e.res('/css/goods_release.css')}" rel="stylesheet" type="text/css" />

        <div class="breadcrumbW">
            <div class="breadcrumb">
                <span class="left">商品管理&gt;相册管理</span>
            </div>
        </div>
        <div class="listW">
        <ul class="sList">
            <@form.form method="post" action="${rc.contextPath}/admin/am/album/getalbum">
                <li>
                    <label>相册描述：</label>
                    <input type="text" class="inputStyle w180" id="albumExplain" name="albumExplain" value="${album.albumExplain}">
                </li>
                <li>
                    <label>应用渠道：</label>
                    <select class="selectStyle w185" name="usedChannel">
                        <option value="">请选择</option>
                        <#list usedChannelList as state>
                            <#if state.dataKey==album.usedChannel>
                                <option  value="${state.dataKey}" selected="selected">${state.dataValue}</option>
                            <#else>
                                <option  value="${state.dataKey}">${state.dataValue}</option>
                            </#if>
                        </#list>
                    </select>
                </li>
                <li></li>
                <li>
                    <input type="submit" value="查&nbsp;&nbsp;询" class="shortBtn mrgR10 mrgL60" />
                    <a href="${rc.contextPath}/admin/am/album/addInit" class="cBlue">新增相册</a>
                </li>

            </@form.form>
            </ul>
            <div class="listTopBox">
                <table cellspacing="0" cellpadding="0" border="0" class="listTop">
                    <tbody>
                    <tr>
                        <th class="tFourth">默认图片</th>
                        <th class="tFourth">相册说明</th>
                        <th class="tFourth">使用渠道</th>
                        <th class="tFourth">操作</th>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="listContBox">
                <#if 0 == pager.total>
                    <p style="padding:20px;text-align:center;margin-bottom:10px;">暂无相关查询结果</p>
                <#else>
                    <#list pager.rows as album>
                        <table cellspacing="0" cellpadding="0" border="0">
                            <tbody>
                            <tr>
                                <td class="tFourth"><img src='${e.res(album.PHOTO_LINKS)}' height="50px" width="50px" /></td>
                                <td class="tFourth">${album.ALBUM_EXPLAIN}</td>
                                <td class="tFourth">${album.USED_CHANNEL_VALUE}</td>
                                <td class="tFourth">
                                    <a href="${rc.contextPath}/admin/am/album/editAlbumInit?albumId=${album.ALBUM_ID}" class="cBlue">编辑</a>
                                    <a href="${rc.contextPath}/admin/am/album/delAlbum?albumId=${album.ALBUM_ID}" class="cBlue">删除</a>
                                    <a href="${rc.contextPath}/admin/am/album/getalbumPhoto?albumId=${album.ALBUM_ID}" class="cBlue" target="_blank">查看明细</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </#list>
                </#if>
            </div>
            <#import "/admin/layout/common/pager.ftl" as q>
            <@q.pager pageNo=pager.curPage pageSize=pager.pageSize recordCount=pager.total toURL="${rc.contextPath}/admin/am/album/getalbum"/>
        </div>
</@layout>

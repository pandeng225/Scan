<#macro Kindeditor id content="" readonly="false" style="width:700px;height:200px;visibility:hidden;disabled:disabled" editorWidth="790">
<script charset="utf-8" src="${e.res('/js/kindeditor/kindeditor-min.js')}"></script>
<script charset="utf-8" src="${e.res('/js/kindeditor/lang/zh_CN.js')}"></script>
<script>
    var editorFn_${id} = {};
    var editor_${id};
    KindEditor.ready(function(K) {
                editor_${id} = K.create('textarea[name="${id}"]', {
                resizeType : 0,
                width : '${editorWidth}',
                uploadJson : '${rc.contextPath}/admin/am/noticeImagesUpload?CSRFToken='+$("input[name='CSRFToken']").val(),
                afterFocus : editorFn_${id}.afterFocus,
                afterBlur : editorFn_${id}.afterBlur,
                items : [
                        'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'cut', 'copy', 'paste',
                        'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
                        'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
                        'superscript', 'clearhtml', 'quickformat', 'selectall',  '/',
                        'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
                        'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image',
                        'table', 'hr', 'emoticons', 'pagebreak',
                        'link', 'unlink', '|']
            });
            editor_${id}.html($("#${id}").val());
            editor_${id}.readonly(${readonly});
    });
</script>
<textarea id="${id}" name="${id}" cols="100" rows="8" style="${style}" class="suppressBaseCheck suppressSpecLetterCheck">${content}</textarea>
</#macro>

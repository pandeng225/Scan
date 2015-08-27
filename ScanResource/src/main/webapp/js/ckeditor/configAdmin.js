/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	
	config.toolbar = 'Define'; 

    config.toolbar_Define = [

       ['Source', '-', 'Save', 'NewPage', 'Preview', '-', 'Templates'],

       ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Print', 'SpellChecker', 'Scayt','Image'],

       ['Undo', 'Redo', '-', 'Find', 'Replace', '-', 'SelectAll', 'RemoveFormat'],

       ['Form', 'Checkbox', 'Radio', 'TextField', 'Textarea', 'Select', 'Button', 'ImageButton', 'HiddenField'],

       ['Bold', 'Italic', 'Underline', 'Strike', '-', 'Subscript', 'Superscript'],

       ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', 'Blockquote'],

       ['JustifyLeft', 'JustifyCenter','-', 'JustifyRight', 'JustifyBlock'],

       ['Styles','Format','-','Font','FontSize'],
       
       ['TextColor', 'BGColor'],
       
       ['Link','Unlink','Anchor'],

       ['Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'PageBreak']

    ];
    config.language = 'zh-cn';
    config.extraPlugins = 'font';
		config.font_names='宋体/宋体;黑体/黑体;仿宋/仿宋_GB2312;楷体/楷体_GB2312;隶书/隶书;幼圆/幼圆;微软雅黑/微软雅黑;'+ config.font_names;
		config.resize_enabled = false;
		//是否使用HTML实体进行输出
		config.entities = false;	
		config.htmlEncodeOutput = false;
};

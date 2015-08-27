/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: ZH (Chinese, 中文 (Zhōngwén), 汉语, 漢語)
 */
jQuery.extend(jQuery.validator.messages, {
        required: "必填字段",
		remote: "请修正该字段",
		email: "电子邮件格式不正确",
		url: "请输入合法的网址",
		date: "请输入合法的日期",
		dateISO: "请输入合法的日期 (ISO).",
		number: "请输入合法的数字",
		digits: "只能输入整数",
		creditcard: "请输入合法的信用卡号",
		equalTo: "两次输入不一致",
		accept: "请输入拥有合法后缀名的字符串",
		maxlength: jQuery.validator.format("长度最多是 {0} "),
		minlength: jQuery.validator.format("长度最少是 {0} "),
		rangelength: jQuery.validator.format("长度介于 {0} 和 {1} 之间"),
		range: jQuery.validator.format("介于 {0} 和 {1} 之间的值"),
		max: jQuery.validator.format("最大为 {0} 的值"),
		min: jQuery.validator.format("最小为 {0} 的值")
});

jQuery.extend(jQuery.validator.defaults, {
    errorElement: "span"
});
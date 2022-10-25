function updateBackground(b, type, main_color) {
	var gradient = $('#' + type + '-gradient').val();
	var background1 = $('#' + type + '-background-1').val();
	var background2 = $('#' + type + '-background-2').val();
	if(main_color == 1){
		var background1 = b;
	}else{
		var background2 = b;
	}
	if(gradient != 0){
		$('.ex-' + type).css('background', 'linear-gradient(' + gradient + ', #' + background1 + ', #' + background2 + ')');
	}else{
		$('.ex-' + type).css('background', '#' + b);
	}
}

function gradientChange(value, type){
	var background1 = $('#' + type + '-background-1').val();
	var background2 = $('#' + type + '-background-2').val();
	if (value != 0){
		$('.' + type + '-background').removeClass('hidden');
		$('.ex-' + type).css('background', 'linear-gradient(' + value + ', #' + background1 + ', #' + background2 + ')');
	}else{
		$('.' + type + '-background').addClass('hidden');
		$('.ex-' + type).css('background', '#' + background1);
	}
}

function updateTextColor(color, type) {
	$('.ex-' + type).css('color', '#'+color);
}
function updateBorderColor(color, type){
	$('.ex-' + type).css('border-color', '#'+color);
}
function updateBorder(val){
	$('.ex-btn').css('border-width', val+'px');
}
function updateMinWidth(val){
	$('.ex-btn').css('min-width', val+'px');
}
function updateBorderRadius(val) {
	$('.ex-btn').css('border-radius', val+'px');
}
function updateFontSize(val) {
	$('.ex-btn').css('font-size', val+'px');
}
function updateFontWeight(val) {
	$('.ex-btn').css('font-weight', val);
}
function updatePaddngX(val) {
	$('.ex-btn').css({'padding-left': val+'px', 'padding-right': val+'px'});
}
function updatePaddngY(val) {
	$('.ex-btn').css({'padding-top': val+'px', 'padding-bottom': val+'px'});
}
function updateTextTransform(val){
	if(val.checked == true){
		$('.ex-btn').css('text-transform', 'uppercase');
	}else{
		$('.ex-btn').css('text-transform', 'none');
	}

}

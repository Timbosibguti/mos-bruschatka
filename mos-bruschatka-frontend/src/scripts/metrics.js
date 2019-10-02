$(function() {
	let ymEvent = (target) => ym(metricCode, 'reachGoal', target);

	// Скачать прайс лист (составная цель)
	$('[data-target="#modalDownloadCatalog"], [href="#modalDownloadCatalog"]').on('click', function() {
		ymEvent('downloadCatalog');
	});

	$('#modalDownloadCatalog button[type="submit"]').on('click', function() {
		ymEvent('SubmitBtnDownloadCatalog');
	});



	// Перезвоните мне - Реквизиты (составная цель)
	$('[data-form-title="Реквизиты"] button[type="submit"]').on('click', function() {
		ymEvent('callMe');
	});



	// Рассчитать стоимость (составная цель)
	$('[data-form-title="Расчет доставки"] button[type="submit"], [data-form-title="Рассчитать стоимость"] button[type="submit"]').on('click', function() {
		ymEvent('calculateCost');
	});



	// Проконсультировать (Составная цель)
	$('[data-form-title="Консултация"] button[type="submit"], [data-form-title="adv3"] button[type="submit"]').on('click', function() {
		ymEvent('consult');
	});



	// Получиь образцы (Составная цель)
	$('[data-form-title="Получиь образцы"] button[type="submit"]').on('click', function() {
		ymEvent('getSamples');
	});



	// Купить в 1 клик (составная цель) (Only OPT)
	$('[data-form-title="Купить плитку ОПТ"] button[type="submit"]').on('click', function() {
		ymEvent('sendRequest');
	});



	// Хочу связаться (составная цель)
	$('[data-target="#modalCallback"], [href="#modalCallback"]').on('click', function() {
		ymEvent('askQuestion');
	});

	$('#modalCallback button[type="submit"]').on('click', function() {
		ymEvent('sendRequest');
	});



	// Корзина (Составная цель)
	$(document).on('click', '#formCart button[type="submit"]', function() {
		let step = this.value - 1;

		ymEvent(`korzina_step${step}`);
	});
	
	$(document).on('click', '#cartSubmitOrderBtn', function() {
		ymEvent('invoice_Generated');
	});



	// Указать контакты друга
	$('#modalSuccess button[type="submit"]').on('click', function() {
		ymEvent('SubmitBtnInviteFreind');
	});



	// Рассчитайте стоимость плитки за 2 минуты
	$('#calcStepperNextBtn').on('click', function() {
		let step = this.value - 1;

		ymEvent(`opros_step${step}`);
	});

	$('#calcForm button[type="submit"]').on('click', function() {
		ymEvent('getResult');
	});



	// Подайте заявку на партнерство
	$('[data-title="Заявок на партнерство"] button[type="submit"]').on('click', function() {
		ymEvent('submit_Application');
	});



	// Популярные модели плитки (составная цель)
	$('#productCart a').on('click', function() {
		ymEvent('buttonOpenFormBuyProduct');
	});

	$('[data-form-title="Купить плитку ОПТ"] button[type="submit"]').on('click', function() {
		ymEvent('clickedButtonSubmitFormBuyProduct');
	});
});
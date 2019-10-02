<?php
$json = array();
$info = '';

function add_data($text, $data) {
	if(isset($data) and strlen($data)) {
		return $text . ': ' . $data . '  ||  ';
	}
}

$our_order_id = round(microtime(true) * 1000);
$info .= add_data('ID Заявки', $our_order_id);

foreach($_POST as $inputName => $inputValue) {
	if(!strlen($inputValue)) {
		$json['error'][$inputName] = true;
	} else {
		$json['data'][$inputName] = $inputValue;
	}

	if($inputName != 'title') {
		$info .= add_data($inputName, $inputValue);
	}
}

if(!isset($json['error'])) {
	$title = isset($json['data']['title']) ? $json['data']['title'] : '';
	$name = isset($json['data']['name']) ? $json['data']['name'] : '';
	$phone = isset($json['data']['phone']) ? $json['data']['phone'] : '';
	$email = isset($json['data']['email']) ? $json['data']['email'] : '';


	$roistatData = array(
		'roistat' => isset($_COOKIE['roistat_visit']) ? $_COOKIE['roistat_visit'] : null,
		'key'     => 'MTU5NzY6MTc4MjI6ZDNjMGI3OGE1MGMxYTdlMzAwYjVjMWRiYjcxZTY1ZWQ=', // Ключ для интеграции с CRM, указывается в настройках интеграции с CRM.
		'title'   => 'Новый заявок "' . $title . '" с странице ' . $_SERVER['HTTP_HOST'], // Название сделки
		'comment' => $info, // Комментарий к сделке
		'name'    => $name, // Имя клиента
		'email'   => $email, // Email клиента
		'phone'   => $phone, // Номер телефона клиента
		'is_need_callback' => '0', // После создания в Roistat заявки, Roistat инициирует обратный звонок на номер клиента, если значение параметра рано 1 и в Ловце лидов включен индикатор обратного звонка.
		'sync'    => '0', // 
		'is_need_check_order_in_processing' => '1', // Включение проверки заявок на дубли
		'is_need_check_order_in_processing_append' => '1', // Если создана дублирующая заявка, в нее будет добавлен комментарий об этом
		'fields'  => array(
		// Массив дополнительных полей. Если дополнительные поля не нужны, оставьте массив пустым.
		// Примеры дополнительных полей смотрите в таблице ниже.
		// Сервер преобразует значения полей из указанной кодировки в UTF-8.
		),
	);
	
	file_get_contents("https://cloud.roistat.com/api/proxy/1.0/leads/add?" . http_build_query($roistatData));
	// roistat
	header('Content-Type: application/json');
	# error_reporting(E_ALL);
	# ini_set("display_errors", 1);

	$path_mailer_class = pathinfo(__FILE__);
	require_once($path_mailer_class['dirname'].'/phpmailer/PHPMailerAutoload.php');

	$mail = new PHPMailer;

	# $mail->SMTPDebug = 2;
	# $mail->XMailer = 'The bat! v2.99';
	$mail->setLanguage('ru', '.');
	$mail->isSMTP();
	$mail->Host = 'smtp.yandex.ru';
	$mail->SMTPAuth = true;
	$mail->Username = 'mos.bruschatka@yandex.ru';
	$mail->Password = '2cpfyndq';
	$mail->SMTPSecure = 'ssl';
	$mail->Port = 465;
	$mail->CharSet = 'UTF-8';

	$mail->setFrom('mos.bruschatka@yandex.ru', 'МОСБРУСЧАТКА');
	$mail->addAddress('mos.bruschatka@yandex.ru', 'МОСБРУСЧАТКА');

	/*
	# Для отправки копии письма
	if(isset($input_data['post']['test'])) {
		$mail->AddCC('it@gmail.com', 'Мне');
	}
	*/

	$mail->isHTML(true);

	$mail->Subject = 'Новая заявка на сайте= '.$our_order_id;
	$mail->Body = '<html><body>';
	$mail->Body .= add_data('ID Заявки', $our_order_id);
	$mail->Body .= add_data('Контактный телефон', $_POST['phone']);

	$mail->Body .= add_data('=================', 'Техническия информация:');
	$mail->Body .= add_data('Страница заказа', $_SERVER['HTTP_REFERER']);
	$mail->Body .= add_data('IP клиента', $_SERVER['REMOTE_ADDR']);
	$mail->Body .= add_data('UserAgent клиента', $_SERVER['HTTP_USER_AGENT']);

	$mail->Body .= '</body></html>';

	# Если письмо отправилось, следовательно заказ создан
	if($mail->send()) {
		$json['status'] = 'send';
	} else {
		$json['status'] = 'fail';
	}
}

print(json_encode($json));
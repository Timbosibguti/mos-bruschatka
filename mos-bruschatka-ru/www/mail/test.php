<?php
$info = '';
// $info .= add_data('ID Заявки', $our_order_id);

$title = isset($_POST['title']) ? $_POST['title'] : '';
$name = isset($_POST['name']) ? $_POST['name'] : '';
$phone = isset($_POST['phone']) ? $_POST['phone'] : '';
$email = isset($_POST['email']) ? $_POST['email'] : '';
$phone = isset($_POST['phone']) ? $_POST['phone'] : '';

$roistatData = array(
    'roistat' => isset($_COOKIE['roistat_visit']) ? $_COOKIE['roistat_visit'] : null,
    'key'     => 'MTU5NzY6MTA5NTQ0OmQzYzBiNzhhNTBjMWE3ZTMwMGI1YzFkYmI3MWU2fake', // Ключ для интеграции с CRM, указывается в настройках интеграции с CRM.
    'title'   => $title, // Название сделки
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


function add_data($text, $data) {
	if(isset($data) and strlen($data)) {
		return $text.': '.$data.'<br>';
	}
	return '';
}


$our_order_id = round(microtime(true) * 1000);

$mail = new PHPMailer;

# $mail->SMTPDebug = 2;
# $mail->XMailer = 'The bat! v2.99';
$mail->setLanguage('ru', '.');
$mail->isSMTP();
$mail->Host = 'smtp.yandex.ru';
$mail->SMTPAuth = true;
$mail->Username = 'roses.4ever@yandex.ru';
$mail->Password = '1kf9e6hn';
$mail->SMTPSecure = 'ssl';
$mail->Port = 465;
$mail->CharSet = 'UTF-8';

$mail->setFrom('roses.4ever@yandex.ru', 'МОСБРУСЧАТКА');
$mail->addAddress('mos.bruschatka@yandex.ru', 'МОСБРУСЧАТКА');
$mail->AddCC('dep.market@yandex.ru', 'МОСБРУСЧАТКА копия письма');
$mail->AddCC('yannickngassa@departament.marketing', 'IT Department');

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
	print(json_encode([
		'response' => 'ok',
		'order_id' => $our_order_id,
	]));
}
else {
	print(json_encode([
        'response' => 'fail',
	]));
}
<?php echo $header; ?>

<main class="section" id="wrapper">
	<?php echo $content_top ? $content_top : ''; ?>

	<div class="container">
		<div class="grid">
			<?php echo $column_left ? '<aside class="aside">' . $column_left . '</aside>' : ''?>

			<section class="main-section">
				<div class="row">
					<div class="col-8">

						<h1 class="main-title vacancy__title">Руководитель отдела продаж</h1>
						<h3 class="vacancy__price">от 30 000 руб</h3>

						<div class="vacancy__options">
							<button type="button" class="btn btn--inline btn--yellow" style="width: 220px;">откликнуться на вакансию</button>
						</div>

						<ul class="vacancy__list">
							<h3 class="vacancy__list-title">Обязанности:</h3>
							<li class="vacancy__list-item">Продажа тротуарной плитки</li>
							<li class="vacancy__list-item">Поиск новых клиентов и расширение клиентской базы, создание эффективного отдела продаж</li>
							<li class="vacancy__list-item">Развитие нового направления производства спецтехники</li>
						</ul>

						<ul class="vacancy__list">
							<h3 class="vacancy__list-title">Требования:</h3>
							<li class="vacancy__list-item">Опыт работы от 3 лет в продажах</li>
							<li class="vacancy__list-item">Наличие своей клиентской базы</li>
							<li class="vacancy__list-item">Знание рынка сбыта продукта</li>
							<li class="vacancy__list-item">Коммуникабельность, работоспособность, многозадачность, стрессоустойчивость</li>
						</ul>

						<ul class="vacancy__list">
							<h3 class="vacancy__list-title">Условия:</h3>
							<li class="vacancy__list-item">Комфортный офис в г. Москва</li>
							<li class="vacancy__list-item">Рабочий день с 9:00 до 18:00</li>
							<li class="vacancy__list-item">Ожидаемый доход до 30 000 рублей (оклад + % от продаж)</li>
							<li class="vacancy__list-item">Оформление согласно ТК РФ</li>
							<li class="vacancy__list-item">Оплачиваемый отпуск</li>
							<li class="vacancy__list-item">Оплата ГСМ и мобильной связи</li>
							<li class="vacancy__list-item">Дружный коллектив, традиции, праздники и корпоративные мероприятия</li>
							<li class="vacancy__list-item">Карьерный рост</li>
						</ul>

						<form action="" class="card card--clear-gray vacancy-form">
							<h3>Отклик на вакансию</h3>
							<p class="vacancy-form__note">* - обязательное поле</p>
							<div class="row">
								<div class="col-4">
									<p class="vacancy-form__stepper">Контактные данные</p>
									<input type="text" name="name" placeholder="* ФИО" class="input input--inline">
									<input type="tel" name="phone" placeholder="* +7 (XXX) XX - XX - XX" class="input input--inline js-phone">
									<input type="email" name="email" placeholder="* mymail@mymail.ru" class="input input--inline">
								</div>
								<div class="col-4">
									<p class="vacancy-form__stepper">О себе</p>
									<textarea name="letter" placeholder="сопроводительное письмо" class="vacancy-form__textarea"></textarea>
									<input type="text" name="linkCV" class="input input--fluid" placeholder="ссылка на резюме">
									<input type="file" id="" name="fileCV" accept="image/png, image/jpeg" class="btn btn--fluid btn--blue">
									<p class="text-sm text--light-gray">Файл не более 1 Мб</p>
								</div>
								<div class="col-4">
									<p class="vacancy-form__stepper">Готово</p>
									<input type="checkbox" name="privacy" value="agreed" class="input-checkbox" id="privacy">
									<label for="privacy" class="label-checkbox text-normal" style="margin-bottom: 10px;">
										Я согласен на обработку персональных данных
									</label>

									<button tybe="submit" class="btn btn--inline btn--yellow">Отправить</button>
								</div>
							</div>
						</form>
					</div>
					<div class="col-4">
					
						<div class="card card--clear-gray vacancy-addr">
							<h3 class="vacancy-addr__title">Адрес</h3>
							<p>г. Москва, Кутузовский проспект, 36, 2-ой этаж, помещение 2</p>
							<div class="vacancy-addr__map"><script defer src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Afc64fb3da4829e3af3b1b5c10a61a99a62743502af11335669db10f62993be8c&amp;width=100%&amp;height=218&amp;lang=ru_RU&amp;scroll=false"></script></div>
						</div>

						<div class="card card--clear-gray vacancy-contact">
							<h3>Контакты</h3>
							<p class="vacancy-contact__text-top">ФИО</p>
							<p class="vacancy-contact__text-bottom">Гордая Светлана Викторовна</p>

							<p class="vacancy-contact__text-top">Телефон</p>
							<p class="vacancy-contact__text-bottom">+7 (499) 450-03-11</p>

							<p class="vacancy-contact__text-top">Email поддержки покупателей</p>
							<a href="mailto:mos.bruschatka@yandex.ru" class="vacancy-contact__email">mos.bruschatka@yandex.ru</a>

						</div>

					</div>
				</div>
			</section>

			<?php echo $column_right ? '<aside class="aside aside-right">' . $column_right . '</aside>' : ''?>
		</div>
	</div>
	
	<?php echo $content_bottom ? $content_bottom : ''; ?>
</main>


<?php echo $footer; ?></body></html>
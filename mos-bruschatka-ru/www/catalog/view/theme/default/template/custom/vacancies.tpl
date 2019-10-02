<?php echo $header; ?>
<main class="section" id="wrapper">
	<?php if ($content_top) { ?>
		<?php echo $content_top; ?>
	<?php } ?>
	<div class="container">
		<h1 class="page-title mb-30">Наши Вакансии</h1>
		<div class="row">
			<?php echo $content_left ? $content_left : '' ?>
			
			<section class="col">
				<div class="vacancies-filter">
					<div class="vacancies-filter__item">
						<p class="mb-10 text-sm text-light-gray">Выберите Ваш город из списка</p>
						<div class="custom-select">
							<select name="vacancies[city]" id="">
								<option value="">любой город</option>
								<option value="">City</option>
								<option value="">City</option>
								<option value="">City</option>
								<option value="">City</option>
							</select>
						</div>
					</div>
					<div class="vacancies-filter__item">
						<p class="mb-10 text-sm text-light-gray">Выберите Вашу профессиональную область</p>
						<div class="custom-select">
							<select name="vacancies[specialities]" id="">
								<option value="">любая профобласть</option>
								<option value="">specialities</option>
								<option value="">specialities</option>
								<option value="">specialities</option>
								<option value="">specialities</option>
							</select>
						</div>
					</div>
				</div>

				<ul class="vacancies-list">
					<?php for($i; $i < 7; $i++) { ?>
					<li class="vacancies-list__item">
						<a href="<?php echo $link_vacancy; ?>" class="h3 text--blue vacancies-list__item-name">Руководитель отдела продаж</a>
						<a href="javascript:void(0);" class="vacancies-list__item-location"><svg width="16" height="16" class="icon icon--location"><use xlink:href="#iconLocation"><</use></svg>Санкт-Петербугр</a>
						<a href="javascript:void(0);" class="vacancies-list__item-speciality">Направление: Продажи</a>
						
						<p class="vacancies-list__item-salary">от 30 000 руб</p>
						<p class="vacancies-list__item-description">Опыт работы в продажах (продовольственная группа) обязателен, высшее экономическое образование, знание торговой сети, знание 1С предприятие 8.3 реализация продукции оптовым и розничным покупателем ...</p>
						<div class="vacancies-list__item-actions">
							<button type="button" class="vacancies-list__item-favorite">
								<svg width="16" height="16" class="icon icon--heart"><use xlink:href="#iconHeart"></use></svg>в избранное
							</button>
							<button type="button" class="vacancies-list__item-share">
								<svg width="16" height="16" class="icon icon--heart"><use xlink:href="#iconShare"></use></svg>Поделиться
							</button>
						</div>
					</li>
					<?php } ?>
				</ul>
			</section>
			<aside class="col-12 col-lg-3">
				<div class="card card--clear-gray vacancy-contact">
					<h3>Контакты</h3>
					<p class="vacancy-contact__text-top">ФИО</p>
					<p class="vacancy-contact__text-bottom">Гордая Светлана Викторовна</p>

					<p class="vacancy-contact__text-top">Телефон</p>
					<p class="vacancy-contact__text-bottom">+7 (499) 450-03-11</p>

					<p class="vacancy-contact__text-top">Email поддержки покупателей</p>
					<a href="mailto:mos.bruschatka@yandex.ru" class="vacancy-contact__email">mos.bruschatka@yandex.ru</a>

				</div>
				<div class="blog-newsletters card card--blue">
					<h3 class="text--white blog-newsletters__title">Подпишись на 
							новые вакансии!</h3>
					<p class="text--white blog-newsletters__description">И получай на почту рассылку с самыми свежими вакансиями!</p>
					<form action="javascript:void(0);">
						<input type="text" name="email" placeholder="<?php echo $placeholder_email; ?>" class="input input--fluid">
						<button type="button" class="btn btn--fluid btn--yellow">подписаться</button>
						<div class="privacy-info privacy-info--white">Отправляя форму Вы  соглашаетесь с <a href="javascript:void(0);">политикой  конфиденциальности</a></div>
					</form>
				</div>
			</aside>
		</div>
	</div><!-- container -->

	<?php if ($content_bottom) { ?>
		<?php echo $content_bottom; ?>
	<?php } ?>
</main>
<div class="container-fluid">
		<script defer src="https://api-maps.yandex.ru/services/constructor/1.0/js/?um=constructor%3Afc64fb3da4829e3af3b1b5c10a61a99a62743502af11335669db10f62993be8c&amp;width=100%&amp;height=537&amp;lang=ru_RU&amp;scroll=false"></script>
</div>
<?php echo $footer; ?>
</body></html>
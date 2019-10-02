<!doctype html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="no-js">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="x-ua-compatible" content="ie=edge">
		<base href="<?php echo $base; ?>" />
		<title><?php echo $title; ?></title>
<?php if ($description) { ?>
		<meta name="description" content="<?php echo $description; ?>">
<?php } ?>
<?php if ($keywords) { ?>
		<meta name="keywords" content= "<?php echo $keywords; ?>">
<?php } ?>
<?php if ($google_site_verification) { ?>
		<meta name="google-site-verification" content="<?php echo $google_site_verification; ?>">
<?php } ?>
<?php if ($yandex_verification) { ?>
		<meta name="yandex-verification" content="<?php echo $yandex_verification; ?>">
<?php } ?>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="format-detection" content="telephone=no">
		<meta name="MobileOptimized" content="320">

<?php foreach ($links as $link) { ?>
		<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>">
<?php } ?>

<?php if ($open_graph) { ?>
		<meta property="og:title" content="<?php echo $title; if (isset($_GET['page'])) { echo " - ". ((int) $_GET['page'])." ".$text_page;} ?>" />
		<meta property="og:type" content="website">
		<meta property="og:url" content="<?php echo $og_url; ?>">
<?php if ($og_image) { ?>
		<meta property="og:image" content="<?php echo $og_image; ?>">
<?php } else { ?>
		<meta property="og:image" content="<?php echo $logo; ?>">
<?php } ?>
		<meta property="og:site_name" content="<?php echo $name; ?>">
<?php } ?>
		<meta name="theme-color" content="#ffae00">

		<link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/fancyapps/fancybox@3.5.6/dist/jquery.fancybox.min.css" />
		<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
		<link rel="stylesheet" href="catalog/view/theme/theme_lightshop/assets/css/vendors.css">
<?php foreach ($styles as $style) { ?>
		<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>">
<?php } ?>
		<link rel="stylesheet" href="catalog/view/theme/theme_lightshop/assets/css/app.css">

<?php foreach ($store['analytics'] as $analytic) { ?>
		<?php echo $analytic; ?>
<?php } ?>
<script>var metricCode = <?php echo $ym_code; ?></script>

<?php if($js_footorhead == 1) { ?>
		<script src="catalog/view/javascript/theme_lightshop/jquery-2.2.4.min.js"></script>
		<script src="catalog/view/theme/theme_lightshop/assets/js/vendors.js"></script>
		<script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU"></script>
<?php foreach ($scripts as $script) { ?>
		<script src="<?php echo $script; ?>"></script>
<?php } ?>
		<script src="catalog/view/theme/theme_lightshop/assets/js/app.js"></script>
<?php } ?>
<script src="https://use.fontawesome.com/28ab702e0e.js"></script>

		<link rel="stylesheet" href="https://cdn.envybox.io/widget/cbk.css">
		<script type="text/javascript" src="https://cdn.envybox.io/widget/cbk.js?wcb_code=e81074723d3746c42592f71b0e768fa1" charset="UTF-8" async></script>

		<!-- Pixel -->
		<script type="text/javascript">
			(function (d, w) {
				var n = d.getElementsByTagName("script")[0],
						s = d.createElement("script"),
						f = function () { n.parentNode.insertBefore(s, n); };
				s.type = "text/javascript";
				s.async = true;
				s.src = "https://qoopler.ru/index.php?ref="+d.referrer+"&cookie=" + encodeURIComponent(document.cookie);

				if (w.opera == "[object Opera]") {
					d.addEventListener("DOMContentLoaded", f, false);
				} else { f(); }
			})(document, window);
		</script>
		<!-- /Pixel -->

		<!-- Facebook Pixel Code -->
		<script>
			!function(f,b,e,v,n,t,s)
					{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
					n.callMethod.apply(n,arguments):n.queue.push(arguments)};
					if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
					n.queue=[];t=b.createElement(e);t.async=!0;
					t.src=v;s=b.getElementsByTagName(e)[0];
					s.parentNode.insertBefore(t,s)}(window, document,'script',
					'https://connect.facebook.net/en_US/fbevents.js');
			fbq('init', '1236784053129872');
			fbq('track', 'PageView');
		</script>
		<noscript><img height="1" width="1" style="display:none"
					   src="https://www.facebook.com/tr?id=1236784053129872&ev=PageView&noscript=1"
			/></noscript>
		<!-- End Facebook Pixel Code -->
		<script src="//st.yagla.ru/js/y.c.js?h=1de94bf0df177e715a4649b54823bda8"></script>
	</head>
	<body <?php echo $class ? 'class="' . $class . '" ' : ''; ?>>
		<!--[if lt IE 9]>
			<p class="browserupgrade" style="color: #fff;background: #a50e0e;padding: 30px 0;text-align: center;font-size: 16px;"><?php echo $outdated_browser; ?></p>
		<![endif]-->

		<div class="page page--<?php echo $class; ?>">
			<header class="header__top" id="headerTop">
				<div class="container">
					<div class="header__row align-items-center">
						<div class="row no-gutters align-items-center">
							<div class="header__switcher text--white">
								<input type="checkbox" name="website" id="headerSwitcherToggle" class="header__switcher-input" <?php echo ($store['version'] == 2) ? 'checked="checked"' : ''; ?> />
								<label for="headerSwitcherToggle"><span class="header__switcher-left">розничным покупателям</span></label>
								<label for="headerSwitcherToggle" class="header__switcher-label"></label>
								<label for="headerSwitcherToggle"><span class="header__switcher-right">оптовым покупателям</span></label>
							</div>
							<!--<div class="header__cities">
								<span class="header__cities-dropdown" id="headerCities">
									<i class="icon-location"></i>
									<input type="radio" name="city" value="false" id="headerCityDefault" checked="checked" />
									<label for="headerCityDefault" class="header__cities-label">Выберите город</label>
									<?php foreach($locations as $key => $location) { ?>
									<input type="radio" name="city" value="<?php echo $location['href']; ?>" id="headerCity<?php echo $key; ?>" />
									<label for="headerCity<?php echo $key; ?>" class="header__cities-label"><?php echo $location['name']; ?></label>
									<?php } ?>
								</span>
							</div> -->
						</div>
						<div class="header__top-right nav-top ml-auto">
							<ul class="list-inline nav-top__list">
								<?php if($store['version'] == 1) { ?>
								<li class="nav-top__list-item">
									<a href="<?php echo $shopping_cart; ?>" class="nav-top__link nav-top__link--cart js-call-popup" data-popup="#popupCart">
										<span class="text-uppercase" style="font-size: 13px;">Корзина (<span class="js-counter"><?php echo $text_items; ?></span>)</span>
									</a>
								</li>
								<?php } ?>
								<li class="nav-top__list-item">
									<button type="button" class="nav-top__btn nav-top__btn--download highlight js-modal" data-target="#modalDownloadCatalog">Скачать прайс-лист
									</button>
								</li>
								<?php if($store['version'] == 1) { ?>
								<li class="nav-top__list-item">
									<button type="button" class="nav-top__btn nav-top__btn--search js-open-search-block"></button>
								</li>
								<?php } ?>
							</ul>
						</div>
					</div>
				</div>
			</header>
			
			<nav <?php echo $schema ? 'itemscope itemtype="http://schema.org/Organization" ' : ''; ?> class="navbar js-navbar" id="navbar">
				<div class="container">
					<div class="header__row justify-content-baseline second">
						<?php if ($header_logo) { ?>
						<a href="<?php echo $home; ?>" class="navbar__logo">
							<img src="<?php echo $header_logo; ?>" alt="" height="40" ?>
						</a>
						<?php } else { ?>
						<a href="<?php echo $home; ?>" class="navbar__logo"><?php echo $header_text_logo; ?></a>
						<?php } ?>

						<?php echo $navbar; ?>

						<div class="nav-actions">
							<ul class="nav-actions__list">
								<li class="nav-actions__list-item list-contact">
									<a href="tel:+<?php echo preg_replace("/[^0-9,.]/", "", $phone_1); ?>" class="nav-actions__link text--bold header-phone icon-phone-primary roistat-phone-tel">
										<span class="header-phone__number roistat-phone"><?php echo $phone_1; ?></span>
									</a>
									<?php if($store['version'] == 1) { ?>
									<div class="popup phones">
										<div class="submenu">
											<ul class="submenu__list">
												<li class="submenu__list-item submenu__btns">
													<button type="button" onclick="yaCounter<?php echo $ym_code; ?>.reachGoal('orderCall');" class="btn btn--fluid btn--yellow js-modal" data-target="#modalCallback">Заказать звонок</button>
													<button type="button" onclick="yaCounter<?php echo $ym_code; ?>.reachGoal('orderCall');" class="btn btn--fluid btn--outline-black js-modal" data-target="#modalCallback">Задать вопрос</button>
												</li>
											</ul>
										</div>
									</div>
									<?php } ?>
								</li>
								<a class="header-phone__adress" href="https://wa.me/74994500311?text=%D0%97%D0%B4%D1%80%D0%B0%D0%B2%D1%81%D1%82%D0%B2%D1%83%D0%B9%D1%82%D0%B5!%20%D0%9C%D0%B5%D0%BD%D1%8F%20%D0%B8%D0%BD%D1%82%D0%B5%D1%80%D0%B5%D1%81%D1%83%D0%B5%D1%82%20%D1%86%D0%B5%D0%BD%D0%B0,%20%D1%81%D1%80%D0%BE%D0%BA%D0%B8%20%D0%B8%20%D1%81%D1%82%D0%BE%D0%B8%D0%BC%D0%BE%D1%81%D1%82%D1%8C%20%D0%B4%D0%BE%D1%81%D1%82%D0%B0%D0%B2%D0%BA%D0%B8%20%D0%BF%D0%BB%D0%B8%D1%82%D0%BA%D0%B8:%20&amp;roistat_visit=815845" style="">
									<i class="fa fa-whatsapp" aria-hidden="true" style="font-size: 1.5em; color: #28b31b; vertical-align: middle;"></i> <span style="vertical-align: middle;">пишите в WhatsApp</span>
								</a>
								<?php if($store['version'] == 1) { ?>
								<li class="nav-actions__list-item nav-list_second">
									<a href="<?php echo $shopping_cart; ?>" class="nav-actions__link nav-actions__link--cart2 js-call-popup" data-popup="#popupCart">
										<span class="nav-actions__counter js-counter"><?php echo $text_items; ?></span>
									</a>
								</li>
								<li class="nav-actions__list-item nav-list_second">
									<button type="button" class="nav-actions__link nav-actions__link--search open-search-block js-open-search-block"></button>
								</li>
								<?php } ?>
							</ul>
						</div>

						<button type="button" class="navbar__menu-btn js-open-mob-nav">
							<span class="bar"></span>
						</button>
					</div>
				</div><!-- container -->
			</nav>

			<?php if($store['version'] == 1) { ?>
			<div class="search-block" id="jsSearchBlock">
				<div class="search-block__inner is-offset" id="jsSearchBlockInner">
					<div class="container position-relative">
						<div class="search-input-box" id="jsSearchInputBox">
							<button type="button" class="search-block__btn-search" id="jsSearchBtn"><svg height="15" width="14" class="icon-search"><use xlink:href="#iconSearch"></use></svg></button>
							<input class="search-block__input" id="jsSearchBlockInput" type="search" placeholder="<?php echo $text_search; ?>" autocomplete="on">
							<div class="search-block__output" id="jsSearchOutput"></div>
						</div>
						<button type="button" class="float-right search-block__btn-close" title="Закрыть" id="jsCloseSearchBlock">&#x2715;</button>
					</div>
				</div>
			</div>
			<?php } ?>

			<div class="modal modal--animated modal-download-catalog" id="modalDownloadCatalog">
				<div class="modal-content modal-download-catalog__content">
					<div class="modal-body modal-download-catalog__body">
						<div class="row no-gutters">
							<div class="col-md-6 is-hidden-md">
								<div class="modal-download-catalog__manager js-load-bg" data-src="https://assets.mos-bruschatka.ru/image/catalog/banners/manager.jpg">
									<div class="h3 modal-download-catalog__info">
										<div class="modal-complete__name text--black">Ваш менеджер Василий</div>
										<div class="modal-download-catalog__number text--black">
											<a class="roistat-phone roistat-phone-tel" href="tel:+74996497238">+ 7 (499) 649 72 38</a>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="modal-download-catalog__col-right">
									<p class="mb-15 text-sm">прайс-лист готов к скачиванию...</p>
									<div class="modal-download-catalog__title">Забронируйте индивидуальную скидку</div>
									<ul class="modal-download-catalog__list mb-15">
										<li class="modal-download-catalog__list-item">Скидка на все 2500 моделей</li>
										<li class="modal-download-catalog__list-item">Действует на все услуги (доставку и укладку)</li>
									</ul>
									<form onsubmit="window.open('<?php echo $store['prices_list']; ?>', '_blank');" action="javascript:void(0)" class="text-center modal-download-catalog__form js-form-callback" data-form-title="Скачать прайс-лист">
										<div class="modal-download-catalog__reduction">Ваша скидка <input type="text" name="discount" class="modal-download-catalog__percent js-modal-download-catalog-discount" value="5" readonly /> %</div>
										<input required name="phone" type="tel" placeholder="Введите телефон" class="input input--fluid input--highlight js-phone" />
										<button type="submit" class="btn btn--fluid btn--yellow icon-long-arrow-pointing-to-the-right">Забронировать скидку и <span class="whitespace-nowrap">скачать прайс-лист</span></button>
										<div class="privacy-info"><?php echo $privacy_info; ?></div>
									</form>
								</div>
							</div>
						</div>
					</div><!-- .row -->
				</div>
			</div>

			<div class="modal modal--animated modal-callback" id="modalCallback">
				<div class="modal-content modal-callback__content">
					<div class="modal-body text-center">
						<div class="h2 modal-callback__h2">Заполните форму<br />и мы с вами свяжемся!</div>
						<p class="modal-callback__notice">Введите контактные данные в форму ниже и наш менеджер свяжется с Вами в ближайшее время, чтобы ответить на все Ваши вопросы!</p>
						<form action="javascript:void(0);" class="modal-callback__form js-form-callback" data-form-type="modal" data-form-title="Перезвонить">
							<input type="text" name="name" placeholder="<?php echo $placeholder_name; ?>" class="input input--inline input--highlight">
							<input type="tel" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input input--inline input--highlight js-phone">
							<div class="privacy-info privacy-info--inline text-left"><?php echo $privacy_info; ?></div>
							<button type="submit" class="btn btn--inline btn--yellow">отправить</button>
						</form>
					</div>
				</div>
			</div>

			<div class="modal modal--animated modal-echec" id="modalFail">
				<div class="modal-content modal-echec__content">
					<div class="modal-body modal-echec__body">
						<div class="h2 modal-echec__h2">Ошибка при отправке формы!</div>
						<p class="modal-echec__notice">Повторите запрос позже</p>
					</div>
				</div>
			</div>


			<?php if($store['version'] == 1) { ?>
			<form action="<?php echo isset($action) ? $action : ''; ?>" method="post" enctype="multipart/form-data" class="popup-cart" id="popupCart">
				<?php echo $cart; ?>
			</form>
			<?php } ?>

			<?php if ($schema) { ?>
			<meta itemprop="name" content="<?php echo $name; ?>">
			<div itemscope itemprop="address" itemtype="http://schema.org/PostalAddress">
				<meta itemprop="streetAddress" content="<?php echo $address; ?>">
			</div>
			<?php } ?>

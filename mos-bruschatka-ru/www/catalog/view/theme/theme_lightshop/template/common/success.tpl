<?php echo $header; ?>

<style>
	.thanks-inner{
		padding: 8% 4%;
		text-align: center;
	}

	.thanks-inner__img{
		padding: 2% 5%;
		display: inline-block;
		width: 30%;
		vertical-align: middle;
	}

	.thanks-inner__data{
		display: inline-block;
		width: 44%;
		vertical-align: middle;
	}

	.thanks-inner__data h2{
		text-align: left;
		font-size: 37px;

	}

	.thanks-inner__data p{
		text-align: left;
		font-size: 19px;

	}

	.thanks-inner__btn{
		margin: 8% 0;
		text-align: left;
	}

	.thanks-inner__btn a{

		text-decoration: none;
		color: #000;
		border: 1px solid #ffa500;
		padding: 2% 10%;

	}

	.thanks-inner__btn a:hover{
		background: #ffa500;
	}

	@media(max-width: 550px){
		.thanks-inner__img{
			display: block;
			width: 90%;
		}

		.thanks-inner__data{
			display: block;
			width: 100%;
		}

	}
</style>

<main class="container--rd" id="wrapper">
	<div class="thanks">
		<div class="thanks-inner">
			<div class="thanks-inner__img">
				<img src="/catalog/view/theme/theme_lightshop/image/ths.png" width="100%" alt="">
			</div>
			<div class="thanks-inner__data">
				<h2>Спасибо! Ваш заказ успешно оформлен!</h2>
				<p>Мы уже работаем над Вашим заказом. В ближайшее время <br> с Вами свяжется наш менеджер, чтобы уточнить все детали Вашего заказа.</p>
				<div class="thanks-inner__btn">
					<a href="/" id="js-btn">Продолжить</a>
				</div>

			</div>

		</div>
	</div>
	<script>
		document.getElementById('js-btn').onclick = function() {
			if (document.referrer != '') {
				document.getElementById('js-btn').href = document.referrer;
			}
		}
	</script>
</main>

<?php echo $footer; ?>
</body>
</html>

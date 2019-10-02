<div class="modal-calculator">
	<form class="js-form-callback" action="javascript:void(0)" data-form-title="Купить плитку ОПТ">
		<div class="modal-body modal-calculator__body">
			<h3 class="mb-35 text-center"><?php echo $heading_title; ?></h3>
			<div class="row">
				<div class="col-md-6">
					<table class="table">
						<?php foreach ($attribute_groups as $attribute_group) { ?>
							<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
							<tr>
								<td><?php echo $attribute['name']; ?></td>
								<td><?php echo $attribute['text']; ?></td>
							</tr>
							<?php } ?>
						<?php } ?>
						<tr>
							<td>Цена:</td>
							<td style="text-decoration: line-through;"><?php echo $price; ?></td>
						</tr>
						<tr>
							<td>Цена со скидкой 5%:</td>
							<td><?php echo $price * 0.95; ?></td>
						</tr>
					</table>
				</div>
				<div class="col-md-6">
					<img src="<?php echo $thumb; ?>" alt="" class="modal-calculator__img" />
					<div class="modal-calculator__inputs">
						<p class="h5 mb-15 text-center">Скачайте полный прайс-лист</p>
						<input name="name" type="text" placeholder="Ваше имя" class="input input--fluid" />
						<input name="email" type="text" placeholder="e-mail" class="input input--fluid js-email">
						<input name="phone" type="tel" placeholder="Телефон" class="js-phone input input--fluid" />
					</div>
				</div>
			</div><!-- .row -->
			<div class="modal-calculator__actions mt-15 text-center">
				<button type="submit" class="btn btn--fluid btn--yellow">Отправить</button>
				<div class="privacy-info privacy-info--inline"><?php echo $privacy_info; ?></div>
			</div>
		</div>
	</form>
</div>
<li class="tabs__list-item js-tab">
	<a href="#" class="tabs__link">
		<?php echo $text_lightshop_coupon; ?><svg class="icon-chevron-top"><use xlink:href="#chevron-small-left"></use></svg>
	</a>
</li>
<div class="tabs-content js-tab-content js-tab-descr">
	<div class="tabs-content__title js-tab-title">
		<a href="#" class="tabs-content__title-link">
			<?php echo $text_lightshop_coupon; ?><svg class="icon-chevron-top"><use xlink:href="#chevron-small-left"></use></svg>
		</a>
	</div>
	<div class="tabs-content__inner  js-tab-inner">
			<div class="cart__coupon">
				<span class="fake-input fake-input--coupon">
					<input type="text" name="coupon" value="<?php echo $coupon; ?>" placeholder="<?php echo $entry_coupon; ?>" class="cart__coupon-input">
					<button type="button" value="<?php echo $button_coupon; ?>" class="coupon-btn js-add-coupon">
					<svg class="icon-arrow-long">
						<use xlink:href="#arrow-long-right"></use>
					</svg>
					</button>
				</span>
			</div>				
	</div>
</div>
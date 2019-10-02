<div class="header__languages <?php echo count($languages) < 2 ? 'header__languages--hide' : ''?>">
	<div class="header__select">
	<span class="account__title"><?php echo $text_language; ?></span>
		<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-language">
			<span class="select select--header select--squer select--transparent">
				<select data-placeholder="" class="select select--header  select--transparent">
				<option>&nbsp;</option>
					<?php foreach ($languages as $language) { ?>
						<?php if ($language['code'] == $code) { ?>
						<option value="<?php echo $language['code']; ?>" selected="selected"><?php echo $language['name']; ?></option>
						<?php } else { ?>
						<option value="<?php echo $language['code']; ?>"><?php echo $language['name']; ?></option>
						<?php } ?>
					<?php } ?>
				
				</select>
			</span>
		<input type="hidden" name="code" value="">
		<input type="hidden" name="redirect" value="<?php echo $redirect; ?>">			
		</form>	
	</div>
</div>

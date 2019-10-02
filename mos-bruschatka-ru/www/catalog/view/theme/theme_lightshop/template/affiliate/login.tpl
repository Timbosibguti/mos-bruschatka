<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<div class="alerts">
<?php if ($success) { ?>
	<div class="alert alert--green">
		<span class="alert__text">
			<?php echo $success; ?>
		</span>
		<a href="#" class="alert__close">x</a>
	</div>
<?php } ?>
<?php if ($error_warning) { ?>
	<div class="alert alert--red">
		<span class="alert__text">
			<?php echo $error_warning; ?>
		</span>
		<a href="#" class="alert__close">x</a>
	</div>
<?php } ?>
</div>
<main class="content">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumbs breadcrumbs--sm-pad <?php echo $col < 12 ? '' : 'breadcrumbs--center'?>">
			<ul class="breadcrumb__list">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i == 0) { ?>
				<li class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>		
			<?php } else { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><span><?php echo $breadcrumb['text']; ?></span></li>		
			<?php } ?>
			<?php } ?> 			
			</ul>
		</div>
	<h2 class="content__title <?php echo $col < 12 ? '' : 'content__title--center'?>"><?php echo $heading_title; ?></h2>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="<?php echo $col < 12 ? 'col-sm-' . $col : 'col-sm-10 col-sm-offset-1' ?>">
			<div id="sidebar-mob-btn"></div>
			
			<?php echo $text_description; ?>
				<div class="account-form">
					<div class="account-form__col account-form__col--register">
						<span class="account__title"><?php echo $text_new_affiliate; ?></span>
						<p><?php echo $text_register_account; ?></p>
						<a href="<?php echo $register; ?>" class="btn"><?php echo $button_continue; ?></a>
					</div>
					<div class="account-form__col">
						<span class="account__title"><?php echo $text_returning_affiliate; ?></span>
						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
							<div class="account__input-box">
								<input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-email"  required>
							</div>
							<div class="account__input-box account__input-box--pass">
								<input type="password" name="password" value="<?php echo $password; ?>" placeholder="<?php echo $entry_password; ?>" id="input-password" required>
								<a href="<?php echo $forgotten; ?>"><?php echo $text_forgotten; ?></a>
							</div>
							<p>&nbsp;</p>
							<button class="btn" type="submit"><?php echo $button_login; ?></button>
							<?php if ($redirect) { ?>
							<input type="hidden" name="redirect" value="<?php echo $redirect; ?>" />
							<?php } ?>						
						</form>
					</div>
				</div>
	  
	  
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>
	<?php echo $content_bottom; ?>
	</div>
</main>
<?php echo $footer; ?></body></html>
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
				<div class="account-form">
					<div class="account-form__col">
						<div class="account-logged">	
							<div class="account-logged__box">	
								<span class="account__title"><?php echo $text_my_account; ?></span>						
								<ul class="account-logged__list">			
									<li class="account-logged__list-item"><a href="<?php echo $edit; ?>"><?php echo $text_edit; ?></a></li>
									<li class="account-logged__list-item"><a href="<?php echo $password; ?>"><?php echo $text_password; ?></a></li>
									<li class="account-logged__list-item"><a href="<?php echo $payment; ?>"><?php echo $text_payment; ?></a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="account-form__col">
						<div class="account-logged">	
							<div class="account-logged__box">	
								<span class="account__title"><?php echo $text_my_tracking; ?></span>						
								<ul class="account-logged__list">			
									<li class="account-logged__list-item"><a href="<?php echo $tracking; ?>"><?php echo $text_tracking; ?></a></li>
								</ul>
							</div>
						</div>
					</div>
					<div class="account-form__col">
						<div class="account-logged">	
							<div class="account-logged__box">	
								<span class="account__title"><?php echo $text_my_transactions; ?></span>						
								<ul class="account-logged__list">			
									<li class="account-logged__list-item"><a href="<?php echo $transaction; ?>"><?php echo $text_transaction; ?></a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>
	<?php echo $content_bottom; ?>
	</div>
</main>
<?php echo $footer; ?></body></html> 
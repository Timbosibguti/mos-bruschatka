<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="section" id="wrapper">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumbs breadcrumbs--sm-pad">
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
    <h1 class="content__title"><?php echo $heading_title; ?></h1>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-sm-<?php echo $col; ?>">
			<div id="sidebar-mob-btn"></div>
			
			<p><?php echo $text_balance; ?> <strong><?php echo $balance; ?></strong>.</p>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col"><?php echo $column_date_added; ?></td>
							<td class="table__col"><?php echo $column_description; ?></td>
							<td class="table__col table__col--right"><?php echo $column_amount; ?></td>
						</tr>
					</thead>
					<tbody>
						<?php if ($transactions) { ?>
						<?php foreach ($transactions as $transaction) { ?>
						<tr class="table__row table__row--hover">
							<td class="table__col"><?php echo $transaction['date_added']; ?></td>
							<td class="table__col"><?php echo $transaction['description']; ?></td>
							<td class="table__col table__col--right"><?php echo $transaction['amount']; ?></td>
						</tr>
						<?php } ?>
						<?php } else { ?>
						<tr class="table__row">
							<td class="table__col table__col--center" colspan="5"><?php echo $text_empty; ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</div>
				<?php if ($pagination) { ?>	
				<div class="catalogue__pagination">
					<?php echo $pagination; ?>
				</div>
				<p>&nbsp;</p>
				<?php } ?>
					<div class="checkout__button-box">
					<a href="<?php echo $continue; ?>" class="btn btn--transparent"><?php echo $button_continue; ?><svg class="icon-arrow-long-right"><use xlink:href="#arrow-long-right"></use></svg></a>
				</div>		
		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>	
<?php echo $footer; ?></body></html>
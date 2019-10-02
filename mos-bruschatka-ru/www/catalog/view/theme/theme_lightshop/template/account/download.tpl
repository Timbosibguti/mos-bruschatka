<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="content">
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
			<?php if ($downloads) { ?>
			<div class="table-responsive">
			<table class="table">
				<thead>
					<tr class="table__row">
						<td class="table__col table__col--right"><?php echo $column_order_id; ?></td>
						<td class="table__col"><?php echo $column_name; ?></td>
						<td class="table__col"><?php echo $column_size; ?></td>
						<td class="table__col"><?php echo $column_date_added; ?></td>
						<td class="table__col"></td>
					</tr>
				</thead>
				<tbody>
					<?php foreach ($downloads as $download) { ?>
					<tr class="table__row table__row--hover">
						<td class="table__col table__col--right"><?php echo $download['order_id']; ?></td>
						<td class="table__col"><?php echo $download['name']; ?></td>
						<td class="table__col"><?php echo $download['size']; ?></td>
						<td class="table__col"><?php echo $download['date_added']; ?></td>
						<td class="table__col table__col--right">
						<a href="<?php echo $download['href']; ?>" title="<?php echo $button_download; ?>" class="btn"><?php echo $button_download; ?></a>
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
			<?php } else { ?>
			<p><?php echo $text_empty; ?></p>
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
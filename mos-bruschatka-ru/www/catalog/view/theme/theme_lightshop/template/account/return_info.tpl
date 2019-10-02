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

			<table class="table">
				<thead>
					<tr class="table__row">
						<td class="table__col" colspan="2"><?php echo $text_return_detail; ?></td>
					</tr>
				</thead>
				<tbody>
					<tr class="table__row table__row--hover">
						<td class="table__col" style="width: 50%;"><b><?php echo $text_return_id; ?></b> <?php echo $return_id; ?><br />
							<b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?></td>
						<td class="table__col" style="width: 50%;"><b><?php echo $text_order_id; ?></b> <?php echo $order_id; ?><br />
							<b><?php echo $text_date_ordered; ?></b> <?php echo $date_ordered; ?></td>
					</tr>
				</tbody>
			</table>
			<h3 class="content__title"><?php echo $text_product; ?></h3>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col" style="width: 33.3%;"><?php echo $column_product; ?></td>
							<td class="table__col" style="width: 33.3%;"><?php echo $column_model; ?></td>
							<td class="table__col table__col--right" style="width: 33.3%;"><?php echo $column_quantity; ?></td>
						</tr>
					</thead>
					<tbody>
						<tr class="table__row table__row--hover">
							<td class="table__col"><?php echo $product; ?></td>
							<td class="table__col"><?php echo $model; ?></td>
							<td class="table__col table__col--right"><?php echo $quantity; ?></td>
						</tr>
					</tbody>
				</table>
			</div>
			<h3 class="content__title"><?php echo $text_reason; ?></h3>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col" style="width: 33.3%;"><?php echo $column_reason; ?></td>
							<td class="table__col" style="width: 33.3%;"><?php echo $column_opened; ?></td>
							<td class="table__col" style="width: 33.3%;"><?php echo $column_action; ?></td>
						</tr>
					</thead>
					<tbody>
						<tr class="table__row table__row--hover">
							<td class="table__col"><?php echo $reason; ?></td>
							<td class="table__col"><?php echo $opened; ?></td>
							<td class="table__col"><?php echo $action; ?></td>
						</tr>
					</tbody>
				</table>
			</div>
			<?php if ($comment) { ?>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col"><?php echo $text_comment; ?></td>
						</tr>
					</thead>
					<tbody>
						<tr class="table__row table__row--hover">
							<td class="table__col"><?php echo $comment; ?></td>
						</tr>
					</tbody>
				</table>
			</div>
			<?php } ?>
			<h3 class="content__title"><?php echo $text_history; ?></h3>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col" style="width: 33.3%;"><?php echo $column_date_added; ?></td>
							<td class="table__col" style="width: 33.3%;"><?php echo $column_status; ?></td>
							<td class="table__col" style="width: 33.3%;"><?php echo $column_comment; ?></td>
						</tr>
					</thead>
					<tbody>
						<?php if ($histories) { ?>
						<?php foreach ($histories as $history) { ?>
						<tr class="table__row table__row--hover">
							<td class="table__col"><?php echo $history['date_added']; ?></td>
							<td class="table__col"><?php echo $history['status']; ?></td>
							<td class="table__col"><?php echo $history['comment']; ?></td>
						</tr>
						<?php } ?>
						<?php } else { ?>
						<tr class="table__row">
							<td colspan="3" class="table__col table__col--center"><?php echo $text_no_results; ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</div>
		
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

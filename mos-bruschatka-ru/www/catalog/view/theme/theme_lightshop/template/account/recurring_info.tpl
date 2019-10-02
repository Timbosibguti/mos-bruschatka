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

			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col" colspan="2"><?php echo $text_recurring_detail; ?></td>
						</tr>
					</thead>
					<tbody>
						<tr class="table__row">
							<td class="table__col" style="width: 50%;"><b><?php echo $text_order_recurring_id; ?></b> #<?php echo $order_recurring_id; ?><br />
								<b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?><br />
								<b><?php echo $text_status; ?></b> <?php echo $status; ?><br />
								<b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?></td>
							<td class="table__col" style="width: 50%;"><b><?php echo $text_order_id; ?></b> <a href="<?php echo $order; ?>">#<?php echo $order_id; ?></a><br />
								<b><?php echo $text_product; ?></b> <a href="<?php echo $product; ?>"><?php echo $product_name; ?></a><br />
								<b><?php echo $text_quantity; ?></b> <?php echo $product_quantity; ?></td>
						</tr>
					</tbody>
				</table>
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col"><?php echo $text_description; ?></td>
							<td class="table__col"><?php echo $text_reference; ?></td>
						</tr>
					</thead>
					<tbody>
						<tr class="table__row">
							<td class="table__col" style="width: 50%;"><?php echo $recurring_description; ?></td>
							<td class="table__col" style="width: 50%;"><?php echo $reference; ?></td>
						</tr>
					</tbody>
				</table>
			</div>
			<h3><?php echo $text_transaction; ?></h3>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col"><?php echo $column_date_added; ?></td>
							<td class="table__col"><?php echo $column_type; ?></td>
							<td class="table__col"><?php echo $column_amount; ?></td>
						</tr>
					</thead>
					<tbody>
						<?php if ($transactions) { ?>
						<?php foreach ($transactions as $transaction) { ?>
						<tr class="table__row table__row--hover">
							<td class="table__col"><?php echo $transaction['date_added']; ?></td>
							<td class="table__col"><?php echo $transaction['type']; ?></td>
							<td class="table__col"><?php echo $transaction['amount']; ?></td>
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
			<?php echo $recurring; ?>

		</div>
		<?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	
	<?php echo $content_bottom; ?>
	</div>
</main>	
<?php echo $footer; ?></body></html>

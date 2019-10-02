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
						<td class="table__col" colspan="2"><?php echo $text_order_detail; ?></td>
					</tr>
				</thead>
				<tbody>
					<tr class="table__row">
						<td class="table__col" style="width: 50%;"><?php if ($invoice_no) { ?>
							<b><?php echo $text_invoice_no; ?></b> <?php echo $invoice_no; ?><br />
							<?php } ?>
							<b><?php echo $text_order_id; ?></b> #<?php echo $order_id; ?><br />
							<b><?php echo $text_date_added; ?></b> <?php echo $date_added; ?></td>
						<td class="table__col" style="width: 50%;"><?php if ($payment_method) { ?>
							<b><?php echo $text_payment_method; ?></b> <?php echo $payment_method; ?><br />
							<?php } ?>
							<?php if ($shipping_method) { ?>
							<b><?php echo $text_shipping_method; ?></b> <?php echo $shipping_method; ?>
							<?php } ?></td>
					</tr>
				</tbody>
			</table>
			<table class="table">
				<thead>
					<tr class="table__row">
						<td class="table__col" style="width: 50%; vertical-align: top;"><?php echo $text_payment_address; ?></td>
						<?php if ($shipping_address) { ?>
						<td class="table__col" style="width: 50%; vertical-align: top;"><?php echo $text_shipping_address; ?></td>
						<?php } ?>
					</tr>
				</thead>
				<tbody>
					<tr class="table__row">
						<td class="table__col"><?php echo $payment_address; ?></td>
						<?php if ($shipping_address) { ?>
						<td class="table__col"><?php echo $shipping_address; ?></td>
						<?php } ?>
					</tr>
				</tbody>
			</table>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr class="table__row">
							<td class="table__col"><?php echo $column_name; ?></td>
							<td class="table__col"><?php echo $column_model; ?></td>
							<td class="table__col table__col--right"><?php echo $column_quantity; ?></td>
							<td class="table__col table__col--right"><?php echo $column_price; ?></td>
							<td class="table__col table__col--right"><?php echo $column_total; ?></td>
							<?php if ($products) { ?>
							<td class="table__col" style="width: 20px;"></td>
							<?php } ?>
						</tr>
					</thead>
					<tbody>
						<?php foreach ($products as $product) { ?>
						<tr class="table__row table__row--hover">
							<td class="table__col"><?php echo $product['name']; ?>
								<?php foreach ($product['option'] as $option) { ?>
								<br />
								&nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
								<?php } ?></td>
							<td class="table__col"><?php echo $product['model']; ?></td>
							<td class="table__col table__col--right"><?php echo $product['quantity']; ?></td>
							<td class="table__col table__col--right"><?php echo $product['price']; ?></td>
							<td class="table__col table__col--right"><?php echo $product['total']; ?></td>
							<td class="table__col table__col--right"><?php if ($product['reorder']) { ?>
								<a href="<?php echo $product['reorder']; ?>" data-toggle="tooltip" title="<?php echo $button_reorder; ?>" class="btn"><?php echo $button_reorder; ?></a>
								<?php } ?>
								<a href="<?php echo $product['return']; ?>" data-toggle="tooltip" title="<?php echo $button_return; ?>" class="btn"><?php echo $button_return; ?></a></td>
						</tr>
						<?php } ?>
						<?php foreach ($vouchers as $voucher) { ?>
						<tr class="table__row">
							<td class="table__col"><?php echo $voucher['description']; ?></td>
							<td class="table__col"></td>
							<td class="table__col table__col--right">1</td>
							<td class="table__col table__col--right"><?php echo $voucher['amount']; ?></td>
							<td class="table__col table__col--right"><?php echo $voucher['amount']; ?></td>
							<?php if ($products) { ?>
							<td class="table__col"></td>
							<?php } ?>
						</tr>
						<?php } ?>
					</tbody>
					<tfoot>
						<?php foreach ($totals as $total) { ?>
						<tr class="table__row table__row--hover">
							<td class="table__col table__col--right" colspan="5"><b><?php echo $total['title']; ?></b></td>
							<td class="table__col"><?php echo $total['text']; ?></td>
						</tr>
						<?php } ?>
					</tfoot>
				</table>
			</div>
			<?php if ($comment) { ?>
			<table class="table">
				<thead>
					<tr class="table__row">
						<td class="table__col"><?php echo $text_comment; ?></td>
					</tr>
				</thead>
				<tbody>
					<tr class="table__row">
						<td class="table__col"><?php echo $comment; ?></td>
					</tr>
				</tbody>
			</table>
			<?php } ?>
			<?php if ($histories) { ?>
			<h3 class="content__title"><?php echo $text_history; ?></h3>
			<table class="table">
				<thead>
					<tr class="table__row">
						<td class="table__col"><?php echo $column_date_added; ?></td>
						<td class="table__col"><?php echo $column_status; ?></td>
						<td class="table__col"><?php echo $column_comment; ?></td>
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
<?php if (!isset($redirect)) { ?>
<div class="table-responsive">
	<table class="table">
		<thead>
			<tr class="table__row">
				<td class="table__col"><?php echo $column_name; ?></td>
				<td class="table__col"><?php echo $column_model; ?></td>
				<td class="table__col table__col--right"><?php echo $column_quantity; ?></td>
				<td class="table__col table__col--right"><?php echo $column_price; ?></td>
				<td class="table__col table__col--right"><?php echo $column_total; ?></td>
			</tr>
	</thead>
		<tbody>
			<?php foreach ($products as $product) { ?>
			<tr class="table__row">
				<td class="table__col"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
					<?php foreach ($product['option'] as $option) { ?>
					<br />
					&nbsp;<small> - <?php echo $option['name']; ?>: <?php echo $option['value']; ?></small>
					<?php } ?>
					<?php if($product['recurring']) { ?>
					<br />
					<span class="label label-info"><?php echo $text_recurring_item; ?></span> <small><?php echo $product['recurring']; ?></small>
					<?php } ?></td>
				<td class="table__col"><?php echo $product['model']; ?></td>
				<td class="table__col table__col--right"><?php echo $product['quantity']; ?></td>
				<td class="table__col table__col--right"><?php echo $product['price']; ?></td>
				<td class="table__col table__col--right"><?php echo $product['total']; ?></td>
			</tr>
			<?php } ?>
			<?php foreach ($vouchers as $voucher) { ?>
			<tr class="table__row">
				<td class="table__col"><?php echo $voucher['description']; ?></td>
				<td class="table__col"></td>
				<td class="table__col table__col--right">1</td>
				<td class="table__col table__col--right"><?php echo $voucher['amount']; ?></td>
				<td class="table__col table__col--right"><?php echo $voucher['amount']; ?></td>
			</tr>
			<?php } ?>
		</tbody>
		<tfoot>
			<?php foreach ($totals as $total) { ?>
			<tr class="table__row">
				<td colspan="4" class="table__col table__col--right"><strong><?php echo $total['title']; ?>:</strong></td>
				<td class="table__col table__col--right"><?php echo $total['text']; ?></td>
			</tr>
			<?php } ?>
		</tfoot>
	</table>
</div>
<?php echo $payment; ?>
<?php } else { ?>
<script type="text/javascript"><!--
location = '<?php echo $redirect; ?>';
//--></script>
<?php } ?>

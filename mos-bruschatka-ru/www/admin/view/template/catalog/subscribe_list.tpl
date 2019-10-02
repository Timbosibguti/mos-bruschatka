<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
			<a href="<?php echo $send; ?>" data-toggle="tooltip" title="<?php echo $button_subscribe; ?>" class="btn btn-success"><i class="fa fa-paper-plane"></i></a> 
			<a href="<?php echo $email; ?>" data-toggle="tooltip" title="<?php echo $button_email; ?>" class="btn btn-primary"><i class="fa fa-envelope-o"></i></a>
			<a href="<?php echo $insert; ?>" data-toggle="tooltip" title="Добавить email" class="btn btn-primary"><i class="fa fa-plus"></i></a>
			<a onclick="$('form').submit();" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></a>
			</div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<?php if ($module_install) { ?>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if ($success) { ?>
		<div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-envelope-o"></i> <?php echo $heading_title; ?></h3>
			</div>
			<div class="panel-body">
			<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
							<td class="text-left"><?php if ($sort == 'email') { ?>
								<a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_email; ?>"><?php echo $column_email; ?></a>
								<?php } ?></td>
							<td class="text-left"><?php if ($sort == 'status') { ?>
								<a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
								<?php } ?></td>
							<td class="text-right"><?php echo $column_action; ?></td>
						</tr>
					</thead>
					<tbody>
						<?php if ($subscribers) { ?>
						<?php foreach ($subscribers as $subscribe) { ?>
						<tr>
							<td style="text-align: center;"><?php if ($subscribe['selected']) { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $subscribe['subscribe_id']; ?>" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $subscribe['subscribe_id']; ?>" />
								<?php } ?></td>
							<td class="text-left"><?php echo $subscribe['email']; ?></td>
							<td class="text-left"><?php echo $subscribe['status']; ?></td>
							<td class="text-right"><?php foreach ($subscribe['action'] as $action) { ?>
								<a href="<?php echo $action['href']; ?>" data-toggle="tooltip" title="<?php echo $action['text']; ?>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
								<?php } ?></td>
						</tr>
						<?php } ?>
						<?php } else { ?>
						<tr>
							<td class="text-center" colspan="4"><?php echo $text_no_results; ?></td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</form>
				<div class="row">
					<div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
				</div>
			</div>
		</div>
	</div>
	<?php } else { ?>
	<div class="container-fluid">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-envelope-o"></i> <?php echo $heading_title; ?></h3>
			</div>
			<div class="panel-body">
			<?php echo $text_module_not_exists; ?>
			</div>
		</div>
	</div>
	<?php } ?>
</div>
<?php echo $footer; ?> 
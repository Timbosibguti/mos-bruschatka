<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button onclick="$('#form').attr('action', '<?php echo $update; ?>'); $('#form').submit();" data-toggle="tooltip" title="<?php echo $status_done; ?>" class="btn btn-success"><i class="fa fa-refresh"></i></button>
        <a onclick="$('form').submit();" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger"><i class="fa fa-trash-o"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
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
        <h3 class="panel-title"><i class="fa fa-list"></i> Заявки</h3>
      </div>
      <div class="panel-body">
		<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
			<div class="table-responsive">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" /></td>
							<td class="text-left"><?php if ($sort == 'call_id') { ?>
								<a href="<?php echo $sort_call_id; ?>" class="<?php echo strtolower($order); ?>"><?php echo "Номер"; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_call_id; ?>"><?php echo "Номер"; ?></a>
								<?php } ?></td>
							<td class="text-left"><?php if ($sort == 'name') { ?>
								<a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
								<?php } ?></td>
							<td class="text-right"><?php if ($sort == 'telephone') { ?>
								<a href="<?php echo $sort_telephone; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_telephone; ?></a>
								<?php } else { ?>
								<a href="<?php echo $sort_telephone; ?>"><?php echo $column_telephone; ?></a>
								<?php } ?></td>
							<td class="text-left"><?php echo $text_comment; ?></td>
							<td class="text-right"><?php echo $text_status; ?></td>
							<td class="text-right"><?php echo $text_added; ?></td>
							<td class="text-right"><?php echo $text_modified; ?></td>
							<td class="text-right"><?php echo $text_action; ?></td>
						</tr>
					</thead>
					<tbody>
						<?php if ($callbacks) { ?>
						<?php foreach ($callbacks as $callback) { ?>
						<tr <?php if ($callback['status'] != $status_done) { ?>class="warning"<?php } ?>>
							<td class="text-center"><?php if ($callback['selected']) { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $callback['callback_id']; ?>" checked="checked" />
								<?php } else { ?>
								<input type="checkbox" name="selected[]" value="<?php echo $callback['callback_id']; ?>" />
								<?php } ?></td>
							<td class="text-left"><?php echo $callback['callback_id']; ?></td>
							<td class="text-left"><?php echo $callback['name']; ?></td>
							<td class="text-right"><?php echo $callback['telephone']; ?></td>
							<td class="text-left"><?php echo $callback['comment']; ?></td>
							<td class="text-right"><?php echo $callback['status']; ?></td>
							<td class="text-right"><?php echo $callback['date_added']; ?></td>
							<td class="text-right"><?php echo $callback['date_modified']; ?></td>
							<td class="text-right">
								<a href="<?php echo $callback['action']; ?>" data-toggle="tooltip" title="<?php echo $text_edit; ?></a>" class="btn btn-primary"><i class="fa fa-pencil"></i></a>
							</td>
						</tr>
						<?php } ?>
						<?php } else { ?>
						<tr>
						<td class="text-center" colspan="8"><?php echo $text_no_results; ?></td>
						</tr>
						<?php } ?>
					</tbody>		
				</table>
			</div>
		</form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php // echo $results; ?></div>
        </div>	  
	  </div>	
    </div>
  </div>
</div>
<?php echo $footer; ?>

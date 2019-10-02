<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-yandex-metrika" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-yandex-metrika" class="form-horizontal">
          <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_help; ?></div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-code"><?php echo $entry_code; ?></label>
            <div class="col-sm-10">
              <textarea name="yandex_metrika_code" rows="10" placeholder="<?php echo $entry_code; ?>" id="input-code" class="form-control" style="	font-family: Menlo, Monaco, Consolas, 'Courier New', monospace;" /><?php echo $yandex_metrika_code; ?></textarea>
              <?php if ($error_code) { ?>
              <div class="text-danger"><?php echo $error_code; ?></div>
              <?php } ?>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-2">
              <select name="yandex_metrika_status" id="input-status" class="form-control">
                <?php if ($yandex_metrika_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $text_no_admin; ?>"><?php echo $entry_no_admin; ?></span></label>
            <div class="col-sm-2">
				<label class="radio-inline"><input type="radio" name="yandex_metrika_no_admin" value="1" <?php echo $yandex_metrika_no_admin == '1' ? 'checked="checked"' : '' ?> /> <?php echo $text_yes; ?> </label>
				<label class="radio-inline"><input type="radio" name="yandex_metrika_no_admin" value="" <?php echo $yandex_metrika_no_admin == '' ? 'checked="checked"' : '' ?> /> <?php echo $text_no; ?> </label>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><span data-toggle="tooltip" title="" data-original-title="<?php echo $text_no_users; ?>"><?php echo $entry_no_users; ?></span></label>
            <div class="col-sm-2">
				<label class="radio-inline"><input type="radio" name="yandex_metrika_no_users" value="1" <?php echo $yandex_metrika_no_users == '1' ? 'checked="checked"' : '' ?> /> <?php echo $text_yes; ?> </label>
				<label class="radio-inline"><input type="radio" name="yandex_metrika_no_users" value="" <?php echo $yandex_metrika_no_users == '' ? 'checked="checked"' : '' ?> /> <?php echo $text_no; ?> </label>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<?php echo $footer; ?> 
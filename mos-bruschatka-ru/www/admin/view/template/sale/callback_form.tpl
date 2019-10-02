<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-callback" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $heading_title; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-callback" class="form-horizontal"> 
           <div class="form-group required">
            <label class="col-sm-2 control-label"><?php echo $text_id; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="call_id" value="<?php echo $callback_id; ?>" placeholder="<?php echo $callback_id; ?>" id="callback_id" class="form-control" disabled />
                </div>
          </div> 
		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_name; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $name; ?>" id="name" class="form-control" disabled />
                </div>
          </div> 
		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_telephone; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $telephone; ?>" id="telephone" class="form-control" disabled />
                </div>
          </div>  
		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_comment; ?></label>
                <div class="col-sm-10">
				  <textarea name="comment" rows="5" placeholder="Код share кнопок" id="input-comment" class="form-control"><?php echo $comment; ?></textarea>
                </div>
          </div> 
		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_status; ?></label>
                <div class="col-sm-10">
				<select name="status_id" class="form-control">
                <?php if ($status_id == '0') { ?>
                <option value="0" selected="selected"><?php echo $status_wait; ?></option>
                <option value="1" ><?php echo $status_done; ?></option>
                <?php } else { ?>
                <option value="0" ><?php echo $status_wait; ?></option>
                <option value="1" selected="selected"><?php echo $status_done; ?></option>
                <?php } ?>
				</select>
                </div>
          </div> 
 		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_added; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="date_added" value="<?php echo $date_added; ?>" placeholder="<?php echo $date_added; ?>" id="date_added" class="form-control" disabled />
                </div>
          </div>  
 		  <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $text_modified; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="date_modified" value="<?php echo $date_modified; ?>" placeholder="<?php echo $date_modified; ?>" id="date_modified" class="form-control" disabled />
                </div>
          </div>
		</form>		  
      </div>   
    </div>   
  </div>   
</div>   
<?php echo $footer; ?>

<?php echo $header; ?>
<?php echo $column_left; ?>

<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="module-editor-form" data-toggle="tooltip" title="<?php echo $lang['button_save']; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $lang['button_cancel']; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $lang['heading_title']; ?></h1>
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
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $lang['text_edit']; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="module-editor-form" class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-name"><?php echo $lang['entry_name']; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="name" value="<?php echo $name; ?>" placeholder="<?php echo $lang['entry_name']; ?>" id="input-name" class="form-control" />
                            <?php if ($error_name) { ?>
                            <div class="text-danger"><?php echo $error_name; ?></div>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-module_css_class"><?php echo $lang['entry_module_css_class']; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="module_css_class" value="<?php echo $module_css_class; ?>" placeholder="<?php echo $lang['entry_module_css_class'] ?>" id="input-module_css_class" class="form-control" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-product_name"> <?php echo $lang['entry_product']; ?> </label>
                        <div class="col-sm-10">
                            <input type="text" name="product_name" value="<?php echo $product_name; ?>" placeholder="<?php echo $lang['entry_product'] ?>" id="input-product_name" class="form-control" />
                            <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" id="input-product_id" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-product_description"><?php echo $lang['entry_description']; ?></label>
                        <div class="col-sm-10">
                            <textarea name="product_description" id="input-product_description" placeholder="<?php echo $lang['entry_description']; ?>" class="form-control"><?php echo $product_description; ?></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?php echo $lang['entry_status']; ?></label>
                        <div class="col-sm-10">
                            <select name="status" id="input-status" class="form-control">
                                <?php if ($status) { ?>
                                <option value="1" selected="selected"><?php echo $lang['text_enabled']; ?></option>
                                <option value="0"><?php echo $lang['text_disabled']; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $lang['text_enabled']; ?></option>
                                <option value="0" selected="selected"><?php echo $lang['text_disabled']; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        <!--
        $(document).on('focus', '#input-product_name', function() {
            $(this).autocomplete({
                source: function(request, response) {
                    $.ajax({
                        url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
                        dataType: 'json',
                        success: function(json) {
                            response($.map(json, function(item) {
                                return {
                                    label: item['name'],
                                    value: item['product_id']
                                }
                            }));
                        }
                    });
                },
                select: function(item) {
                    $('#input-product_name').val(item['label']);
                    $('#input-product_id').val(item['value']);
                }
            });
        });
        //-->
    </script>
</div>

<?php echo $footer; ?>

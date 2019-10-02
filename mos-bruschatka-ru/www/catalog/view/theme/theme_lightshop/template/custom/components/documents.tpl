<?php if($store['documents']) { ?>
<div class="section <?php echo ($store['version'] == 2) ? 'section--highlight'  : ''; ?> documents">
    <div class="container container--constraint">
        <div class="h2 documents__h2"><?php echo $store['title']; ?></div>
        <div class="documents__cards">
            <?php foreach($store['documents'] as $document) { ?>
            <a href="javascript:void(0);" class="documents__card" data-src="<?php echo $document['popup']; ?>" data-fancybox="docs">
                <img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $document['thumb']; ?>" alt="" />
            </a>
            <?php } ?>
        </div>
    </div>
</div>
<?php } ?>
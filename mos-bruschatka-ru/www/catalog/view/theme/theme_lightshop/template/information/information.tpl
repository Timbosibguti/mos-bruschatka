<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<main class="content">
    <div class="container">
        <?php echo $content_top; ?>
        <div class="breadcrumbs breadcrumbs--sm-pad">
            <ul class="breadcrumb__list">
                <?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
                    <?php if($i == 0) { ?>
                        <li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item">
                            <a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>>
                                <span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span>
                            </a>
                        </li>
                    <?php } elseif($i + 1 < count($breadcrumbs)) { ?>
                        <li <?php echo $schema ? 'itemscope itemtype="http://data-vocabulary.org/Breadcrumb"' : ''?> class="breadcrumb__list-item">
                            <a href="<?php echo $breadcrumb['href']; ?>" <?php echo $schema ? 'itemprop="url"' : ''?>>
                                <span <?php echo $schema ? 'itemprop="title"' : ''?>><?php echo $breadcrumb['text']; ?></span>
                            </a>
                        </li>
                    <?php } else { ?>
                        <li class="breadcrumb__list-item"><?php echo $breadcrumb['text']; ?></li>
                    <?php } ?>
                <?php } ?>
            </ul>
        </div>
        <h1 class="content__title"><?php echo $heading_title; ?></h1>
        <div class="row">
            <?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
        <div class="">
            <div class="editor">
                <?php echo $description; ?>
            </div>
        </div>
        <?php echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
    </div>
    <?php echo $content_bottom; ?>
    </div>
</main>
<?php echo $footer; ?></body></html>

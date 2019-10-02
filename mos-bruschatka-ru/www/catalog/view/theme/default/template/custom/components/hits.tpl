<section class="section section--clear best-selling js-fade-in" id="bestSelling">
    <div class="container container--constraint">
        <div class="h2 best-selling__h2">Хиты тротуарной плитки</div>
        <h3 class="best-selling__h3">28 востребованных моделей</h3>
        <div class="best-selling__forms">
            <?php foreach ($forms as $form) { ?>
            <button type="button" class="btn btn--gray best-selling__form js-best-selling-form" data-form="<?php echo $form['name'] ?>"><?php echo $form['name'] ?></button>

            <div class="best-selling__products js-best-selling-products" data-form="<?php echo $form['name'] ?>">
                <?php foreach ($form['products'] as $product) { ?>
                <div class="best-selling__product">
                    <a href="<?php echo $product['href'] ?>" target="_blank" class="best-selling__product-img js-best-selling-product-img"><img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $product['thumb'] ?>" height="<?php echo $product['thumb_height']; ?>" width="<?php echo $product['thumb_width']; ?>" alt=""></a>
                    <div class="best-selling__product-info js-best-selling-product-info">
                        <div class="row">
                            <a href="<?php echo $product['href'] ?>" target="_blank" class="col-8 best-selling__product-name"><?php echo $product['name'] ?></a>
                            <div class="col-4 best-selling__product-price"><?php echo $product['price'] ?></div>
                        </div>
                    </div>
                </div>
                <?php } ?>
            </div>
            <?php } ?>
        </div>
        <div class="inline-info">
            <a href="#jsModalDownloadCatalog" class="btn btn--inline btn--yellow js-download-catalog"><svg class="icon-pdf" height="15" width="15"><use xlink:href="#iconPdf"></use></svg>скачать каталог</a>
            <span class="inline-info__description">Скачать полную PDF версию каталога</span>
        </div>
    </div>
</section>
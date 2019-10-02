<div class="section section--highlight examples">
    <div class="container container--constraint">
        <div class="row">
            <div class="col-md-6 col-lg-5">
                <div class="h2 examples__h2">Ничто не расскажет о нас лучше, чем примеры работ</div>
                <h3 class="examples__h3">Наша плитка + наша укладка</h3>
                <form class="examples__form js-form-callback" data-form-type="inline" data-form-title="ПЕРЕЗВОНИТЕ МНЕ">
                    <input type="text" name="phone" placeholder="<?php echo $placeholder_phone; ?>" class="input input--inline js-phone">
                    <button type="submit" class="btn btn--inline btn--yellow icon-phone">ПЕРЕЗВОНИТЕ МНЕ</button>
                    <div class="privacy-info privacy-info--inline"><?php echo $privacy_info; ?></div>
                </form>
            </div>
            <div class="col-md-6 col-lg-7">
                <div class="examples__slideshow js-examples-slideshow">
                    <?php foreach($images as $image) { ?>
                    <div class="examples__slide"><img src="<?php echo $placeholder_img; ?>" data-src="<?php echo $image; ?>" alt="" class="examples__slide-img"></div>
                    <?php } ?>
                </div>
            </div>
        </div>
    </div>
</div>
<?php echo $header; ?>
<main class="section">
    <div class="container">
        <div class="h2 requisites__title-first">Реквизиты</div>
        <div class="row">
            <div class="col-xs-12 col-md-7 col-lg-8">
                <?php echo $content_top; ?>
                <div class="inline-info">
                    <a href="<?php echo $download_link; ?>" target="_blank" class="btn btn--inline icon-download btn--yellow inline-info__btn">скачать реквизиты</a>
                    <span class="inline-info__description">Скачать реквизиты в формате PDF</span>
                </div>
                <?php echo $content_bottom; ?>
            </div>
            <div class="col-xs-12 col-md-4 col-lg-3">
                <form action="javascript:void(0);" class="requisites__form js-form-callback" data-form-title="Реквизиты">
                    <h3 class="requisites__form-title">Отправь реквизиты себе <span class="text--blue">на почту!</span></h3>
                    <input type="text" name="name" placeholder="Имя" class="input input--inline">
                    <input type="text" name="email" placeholder="Email" class="input input--inline">
                    <button type="submit" class="btn btn--inline btn--yellow">отправить реквизиты</button>
                    <div class="privacy-info"><?php echo $privacy_info; ?></div>
                </form>
                <?php echo $column_right; ?>
            </div>
        </div>
    </div>
</main>
<?php echo $footer; ?>
</body></html>

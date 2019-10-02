<div class="product-of-the-day row <?php echo $module_css_class; ?>">
    <div class="heading"><h2><?php echo $heading_title; ?></h2></div>
    <div class="col-sm">
        <div class="product-of-the-day__image"
             style="background-image: url('<?php echo $product_image; ?>');"
             onclick="window.open('<?php echo $product_url; ?>', '_self')"
        >
            <div class="discount-label"> - <?php echo $product_discount; ?>% </div>
        </div>
    </div>
    <div class="col-sm">
        <div class="info">
            <h3 class="product-of-the-day__product-name">
                <a href="<?php echo $product_url; ?>" >
                    <?php echo $product_name; ?>
                </a>
            </h3>
            <p class="product-of-the-day__product-description"><?php echo $product_description; ?></p>
            <div class="product-of-the-day__product-price">
                <p class="price-old"><?php echo $product_old_price; ?> ₽/м<sup>2</sup> </p>
                <p class="price"><?php echo $product_price; ?> ₽ </p>
            </div>
        </div>
    </div>
    <div class="col-sm">
        <div class="controls">
            <div class="controls__start">
                <div class="product-of-the-day__timer" id="product-of-the-day-timer">00:00:00</div>
            </div>
            <div class="controls__end">
                <a href="<?php echo $product_url; ?>" class="product-of-the-day__more-about"> Подробнее </a>
                <br>
                <p class="product-of-the-day__counter">Сегодня купили: <?php echo $today_bought_number; ?> человек</p>
            </div>
        </div>
    </div>
</div>

<script>
    let countDownDate = new Date("<?php echo (new DateTime('tomorrow'))->format('Y-m-d h:i:s') ?>").getTime();

    let format = function(number) {
        return (number > 9) ? '' + number : '0' + number;
    };

    let x = setInterval(function() {
        let now = new Date().getTime();
        let distance = countDownDate - now;

        let days = Math.floor(distance / (1000 * 60 * 60 * 24));
        let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        let seconds = Math.floor((distance % (1000 * 60)) / 1000);

        document.getElementById("product-of-the-day-timer").innerHTML
            = format(hours) + ":" + format(minutes) + ":" + format(seconds);

        if (distance < 0) {
            clearInterval(x);
            document.getElementById("product-of-the-day-timer").innerHTML = "Акция закончилась!";
        }
    }, 1000);
</script>

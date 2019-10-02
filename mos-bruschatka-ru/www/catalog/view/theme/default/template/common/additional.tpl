<div class="additionals">
	<h3 class="additionals__h3">Также вам требуется:</h3>
    <div class="additionals__row">
        <input type="checkbox" name="additional[0]" value="Песок" id="additional1" class="js-additional-input" <?php echo (in_array('Песок', $needs)) ? 'checked="checked"' : ''; ?> />
        <label class="additional__label" for="additional1">
            <p class="additional__title">Песок</p>
            <img src="<?php echo $placeholder_img; ?>" data-src="../image/catalog/additionals/add1.png" alt="" />
            <p class="additional__status"></p>
            <p class="additional__price">(12 м3)  +1 000 ₽ </p>
        </label>
        <input type="checkbox" name="additional[1]" value="Щебень" id="additional2" class="js-additional-input" <?php echo (in_array('Щебень', $needs)) ? 'checked="checked"' : ''; ?> />
        <label class="additional__label" for="additional2">
            <p class="additional__title">Щебень</p>
            <img src="<?php echo $placeholder_img; ?>" data-src="../image/catalog/additionals/add2.png" alt="" />
            <p class="additional__status"></p>
            <p class="additional__price">(12 м3)  +1 000 ₽ </p>
        </label>
        <input type="checkbox" name="additional[2]" value="Геотекстиль" id="additional3" class="js-additional-input" <?php echo (in_array('Геотекстиль', $needs)) ? 'checked="checked"' : ''; ?> />
        <label class="additional__label" for="additional3">
            <p class="additional__title">Геотекстиль</p>
            <img src="<?php echo $placeholder_img; ?>" data-src="../image/catalog/additionals/add3.png" alt="" />
            <p class="additional__status"></p>
            <p class="additional__price">(12 м3)  +1 000 ₽ </p>
        </label>
        <input type="checkbox" name="additional[3]" value="Что-то еще" id="additional4" class="js-additional-input" <?php echo (in_array('Что-то еще', $needs)) ? 'checked="checked"' : ''; ?> />
        <label class="additional__label" for="additional4">
            <p class="additional__title">Что-то еще</p>
            <img src="<?php echo $placeholder_img; ?>" data-src="../image/catalog/additionals/add4.png" alt="" />
            <p class="additional__status"></p>
            <p class="additional__price">(12 м3)  +1 000 ₽ </p>
        </label>
    </div>
</div>
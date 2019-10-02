<div class="additionals">
	<h3 class="additionals__h3">Вам может понадобиться:</h3>
    <div class="additionals__row">
        <input type="checkbox" name="additionals[0]" value="Песок" id="additional1" <?php echo (in_array('Песок', $needs)) ? 'checked="checked"' : ''; ?> />
        <label class="additional__label" for="additional1">
            <p class="additional__title">Песок</p>
            <img src="<?php echo $placeholder_img; ?>" data-src="https://assets.mos-bruschatka.ru/image/catalog/additionals/add1.png" alt="" width="125" height="125" />
            <p class="additional__status"></p>
        </label>
        <input type="checkbox" name="additionals[1]" value="Щебень" id="additional2" <?php echo (in_array('Щебень', $needs)) ? 'checked="checked"' : ''; ?> />
        <label class="additional__label" for="additional2">
            <p class="additional__title">Щебень</p>
            <img src="<?php echo $placeholder_img; ?>" data-src="https://assets.mos-bruschatka.ru/image/catalog/additionals/add2.png" alt="" width="125" height="125" />
            <p class="additional__status"></p>
        </label>
        <input type="checkbox" name="additionals[2]" value="Геотекстиль" id="additional3" <?php echo (in_array('Геотекстиль', $needs)) ? 'checked="checked"' : ''; ?> />
        <label class="additional__label" for="additional3">
            <p class="additional__title">Геотекстиль</p>
            <img src="<?php echo $placeholder_img; ?>" data-src="https://assets.mos-bruschatka.ru/image/catalog/additionals/add3.png" alt="" width="125" height="125" />
            <p class="additional__status"></p>
        </label>
        <input type="checkbox" name="additionals[3]" value="Гравий" id="additional4" <?php echo (in_array('Гравий', $needs)) ? 'checked="checked"' : ''; ?> />
        <label class="additional__label" for="additional4">
            <p class="additional__title">Гравий</p>
            <img src="<?php echo $placeholder_img; ?>" data-src="https://assets.mos-bruschatka.ru/image/catalog/additionals/add4.png" alt="" width="125" height="125" />
            <p class="additional__status"></p>
        </label>
    </div>
</div>

<div class="main-nav">
    <ul class="main-nav__list">
        <?php foreach($store['menuLinks'] as $item) { ?>
        <li class="main-nav__list-item">
            <a href="<?php echo $item['href']; ?>" class="main-nav__link <?php echo ($store['version'] == 2) ? 'js-anim-scroll' : ''; ?> <?php echo $item['icon']; ?>-primary"><?php echo $item['name']; ?></a>
            <?php if(isset($item['childrens'])) { ?>
            <div class="popup">
                <div class="submenu">
                    <ul class="submenu__list">
                    <?php foreach($item['childrens'] as $children) { ?>
                        <li class="submenu__list-item">
                            <a href="<?php echo $children['href']; ?>" class="submenu__link <?php echo $children['icon']; ?>-primary"><?php echo $children['name']; ?></a>
                        </li>
                    <?php } ?>
                    </ul>
                </div>
            </div>
            <?php } ?>
        </li>
        <?php } ?>
    </ul>
</div>

<div class="mob-nav" id="mobNav">
    <div class="mob-nav-inner is-offset" id="mobNavInner">
        <a href="" class="mob-nav-top__link js-nav__link"></a>
        <ul class="mob-nav__list">
            <?php foreach($store['menuLinks'] as $item) { ?>
            <li class="mob-nav__list-item">
                <a href="<?php echo $item['href']; ?>" class="main-nav__link <?php echo ($store['version'] == 2) ? 'js-anim-scroll' : ''; ?> <?php echo $item['icon']; ?>-primary"><?php echo $item['name']; ?></a>
                <?php if(isset($item['childrens'])) { ?>
                <div class="popup">
                    <div class="submenu">
                        <ul class="submenu__list">
                        <?php foreach($item['childrens'] as $children) { ?>
                            <li class="submenu__list-item">
                            <a href="<?php echo $children['href']; ?>" class="submenu__link <?php echo $children['icon']; ?>-primary"><?php echo $children['name']; ?></a>
                        </li>
                        <?php } ?>
                        </ul>
                    </div>
                </div>
                <?php } ?>
            </li>
            <?php } ?>
        </ul>
    </div>
</div>

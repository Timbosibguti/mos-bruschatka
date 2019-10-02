<div id="contactMap" class="contact-map" style="width: 100%; min-height: 525px">
    <div class="col-4 contact-map__balloon">
        <div class="h2 mb-15">Контакты</div>
        <h3 class="mb-35">Приходите к нам в офис</h3>
        <div class="text-sm text--light-gray mb-5">Адрес</div>
        <p class="mb-15"><?php echo $store['address']; ?></p>
        <div class="text-sm text--light-gray mb-5">Телефон</div>
        <p class="mb-15"><a class="roistat-phone" href="tel:+74994500311"><?php echo $store['phone']; ?></a></p>
        <div class="text-sm text--light-gray mb-5">График</div>
        <p class="mb-15"><?php echo $store['opening']; ?></p>

        <p class="text--bold"><a href="<?php echo $contact_link; ?>" class="">Как нас найти?</a></p>

        <button type="button" class="btn btn--inline btn--yellow mt-30 js-modal" data-target="#modalCallback"><i class="fa fas fa-phone" aria-hidden="true"></i>Хочу связаться</button>
    </div>
</div>
<script defer="defer">
    var ymaps;
    ymaps.ready(contactMaps);
    function contactMaps() {
        var mapLoaded = false;

        $(window).on('resize load scroll', function() {
            if((window.pageYOffset + $(window).height()) > $('#contactMap').offset().top) {
                if(!mapLoaded) {
                    mapLoaded = true;
                    var contactMap = new ymaps.Map('contactMap', {
                        center: [<?php echo $store['coords']; ?>],
                    zoom: 15,
                        behaviors: ["drag", "dblClickZoom", "rightMouseButtonMagnifier", "multiTouch"],
                        controls: []
                }, {
                        searchControlProvider: 'yandex#search'
                    });

                    var routePanelControl = new ymaps.control.RoutePanel({
                        options: {
                            title: 'Карта с проездом от метро',
                            showHeader: true,
                            maxWidth: '250px',
                            visible: true,
                            autofocus: false,
                            float: 'none',
                            position: {
                                right: 25,
                                top: 25
                            }
                        }
                    });

                    var zoomControl = new ymaps.control.ZoomControl({
                        options: {
                            size: 'small',
                            float: 'none',
                            zoomDuration: 600,
                            position: {
                                bottom: 200,
                                right: 25
                            }
                        }
                    });

                    routePanelControl.routePanel.state.set({
                        fromEnabled: true,
                        toEnabled: false,

                        to: [<?php echo $store['coords']; ?>]
                });

                    contactMap.controls.add(routePanelControl).add(zoomControl);
                }
            }
        });
    }
</script>

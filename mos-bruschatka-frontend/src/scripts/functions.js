/* Opencart functions */
let content1 = '#cart';
let content2 = '#popupCart';
let counter = '.js-counter';
let shakeUiConfig = {
    times: 3,
    distance: 5,
};

function getURLVar(key) {
    var value = [];

    var query = document.location.search.split('?');

    if (query[1]) {
        var part = query[1].split('&');

        for (i = 0; i < part.length; i++) {
            var data = part[i].split('=');

            if (data[0] && data[1]) {
                value[data[0]] = data[1];
            }
        }
 
        if (value[key]) {
            return value[key];
        } else {
            return '';
        }
    }
}

let cart = {
    'add': function(data, successCallback) {
        $.ajax({
            url: 'index.php?route=checkout/cart/add',
            type: 'post',
            data: data,
            dataType: 'json'
        }).done(function(json) {
            $('.product-page__input-box-error').remove();

            if (json['error']) {
                if (json['error']['option']) {
                    for (let i in json['error']['option']) {
                        var element = $('#input-option' + i.replace('_', '-'));

                        if (element.parent().hasClass('select')) {
                        element.next().after('<div class="product-page__input-box-error">' + json['error']['option'][i] + '</div>');
                        } else {
                        element.after('<div class="product-page__input-box-error">' + json['error']['option'][i] + '</div>');
                        }
                    }
                }
                
                if (json['error']['recurring']) {
                    $('select[name=\'recurring_id\']').next().after('<div class="product-page__input-box-error">' + json['error']['recurring'] + '</div>');
                }
            } else {
                $(content2).load('/index.php?route=common/cart/info', function() {
                    $(counter).html(json['total']);
                });

                successCallback();
            }

        }).fail(function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        });
    },
    'fastAdd': function(data, successCallback) {
        $.ajax({
            url: (Object.keys(data).length < 2) ? 'index.php?route=checkout/cart/fastAdd' : 'index.php?route=checkout/cart/add',
            type: 'POST',
            data: data,
        }).done(function(response) {
            successCallback();
            $(content2).load('index.php?route=common/cart/info', function() {
                $(counter).html(response['total_products'] ? response['total_products'] : response['total']);
            });
        }).fail(function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        });
    },
    'update': function(data) {
        $.ajax({
            url: 'index.php?route=checkout/cart/edit',
            type: 'post',
            data: data,

            beforeSend: function() {
                //$contents.addClass('loading');
            },
            complete: function() {
                //$contents.removeClass('loading');
            }
        }).done(function(html) {
            $(content1).replaceWith($(html).find(content1));
            $(content2).replaceWith($(html).find(content2));
            $(counter).html($(html).find(counter).eq(0).html());
        }).fail(function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        });
    },
    'remove': function(key) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
        }).done(function(html) {
            $(content1).replaceWith($(html).find(content1));
            $(content2).replaceWith($(html).find(content2));
            $(counter).html($(html).find(counter).eq(0).html());
        }).fail(function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        });
    },
    'clear': function() {
        $.ajax({
            url: 'index.php?route=checkout/cart/clear',
        }).done(function() {
            window.location.reload();
        }).fail(function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        });
    }
}

let voucher = {
    'add': function() {

    },
    'remove': function(key) {
        $.ajax({
            url: 'index.php?route=checkout/cart/remove',
            type: 'post',
            data: 'key=' + key,
            dataType: 'json',
            beforeSend: function() {
                //$('#cart > button').button('loading');
            },
            complete: function() {
                //$('#cart > button').button('reset');
            },
            success: function(json) {
                // Need to set timeout otherwise it wont update the total
                setTimeout(function () {
                        if (json['total'] > 0) {
                            $(counter).html($(html).find(counter).eq(0).html());
                        } else {
                            $('#cart-total').html('');
                        }
                }, 100);

                var now_location = String(document.location.pathname);

                if ((now_location == '/cart/') || (now_location == '/checkout/') || (getURLVar('route') == 'checkout/cart') || (getURLVar('route') == 'checkout/checkout')) {
                    location = 'index.php?route=checkout/cart';
                } else {
                    $('#cart .js-cart-bottom').load('index.php?route=common/cart/info .scroll-container');
                    $('#cart .js-cart-title').load('index.php?route=common/cart/info .js-cart-items',function(){
                    svgFix();fancyFastCart();
                    });
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }
}




let wishlist = {
    'add': function(product_id) {
        $.ajax({
            url: 'index.php?route=account/wishlist/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            complete: function() {
                getCompareWish();
            },
            success: function(json) {
                $('.alert').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                }

                if (json['success']) {
                    $('.alerts').append($('<div class="alert alert--green"><span class="alert__text"> ' + json['success'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
                    alertClose();
                }

                $('#wishlist-total span').html(json['total']);
                $('#wishlist-total').attr('title', json['total']);

                //$('html, body').animate({ scrollTop: 0 }, 'slow');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    },
    'remove': function() {

    }
}

let compare = {
    'add': function(product_id) {
        $.ajax({
            url: 'index.php?route=product/compare/add',
            type: 'post',
            data: 'product_id=' + product_id,
            dataType: 'json',
            complete: function() {
                getCompareWish();
            },
            success: function(json) {
                $('.alert').remove();

                if (json['success']) {
                    $('.alerts').append($('<div class="alert alert--green"><span class="alert__text"> ' + json['success'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
                    alertClose();

                    $('#compare-total').html(json['total']);
                    //$('html, body').animate({ scrollTop: 0 }, 'slow');
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });

    },
    'remove': function() {

    }
}

let review = {
    'add': function(product_id) {
        $.ajax({
            url: 'index.php?route=product/product/write&product_id=' + product_id,
            type: 'post',
            dataType: 'json',
            data: $("#form-review").serialize(),
            beforeSend: function() {
                $('#form-review > button').attr('disabled', 'disabled');
            },
            complete: function() {
                $('#form-review > button').removeAttr('disabled');
            },
            success: function(json) {
                $('.alert--red, .alert--green').remove();
                if (json['error']) {
                    $('h3').before('<div class="alert alert--red" style="margin-bottom: 20px;"><span class="alert__text">' + json['error'] + '</span></div>');
                        setTimeout(function(){
                            $('.alert--red').remove();
                        }, 5000)
                }
                if (json['success']) {
                    $('h3').before('<div class="alert alert--green" style="margin-bottom: 20px;"><span class="alert__text"> ' + json['success'] + '</span></div>');
                    $('input[name=\'name\']').val('');
                    $('textarea[name=\'text\']').val('');
                    $('input[name=\'rating\']:checked').prop('checked', false);
                        setTimeout(function(){
                            $('.alert--green').remove();
                            $.fancybox.close();
                        }, 5000)
                }
            }
        });
    },
}

let comment = {
    'add': function(blog_id) {
        $.ajax({
            url: 'index.php?route=extension/module/lightshop_blog/write&blog_id=' + blog_id,
            type: 'post',
            dataType: 'json',
            data: $("#form-comment").serialize(),
            beforeSend: function() {
                $('#form-comment > button').attr('disabled', 'disabled');
            },
            complete: function() {
                $('#form-comment > button').removeAttr('disabled');
            },
            success: function(json) {
                $('.alert--red, .alert--green').remove();
                if (json['error']) {
                    $('.message').append('<div class="alert alert--red" style="margin-bottom: 20px;"><span class="alert__text">' + json['error'] + '</span></div>');
                        setTimeout(function(){
                            $('.alert--red').remove();
                        }, 5000)
                }
                if (json['success']) {
                    $('.message').append('<div class="alert alert--green" style="margin-bottom: 20px;"><span class="alert__text"> ' + json['success'] + '</span></div>');
                    $('input[name=\'name\']').val('');
                    $('textarea[name=\'text\']').val('');
                    $('input[name=\'email\']:checked').prop('checked', false);
                        setTimeout(function(){
                            $('.alert--green').remove();
                            $.fancybox.close();
                        }, 5000)
                }
            }
        });
    },
}
/* end Opencart functions */

/* auto */
function labelSelection() {
    /**
     * Just toggling label's state
     */
    let label = '.js-label-selection';
    let input = '.js-label-selection input';
    let state = 'active';
    let filterAttr = 'name';

    $(document).on('change', input, function() {
        let prop = $(this).attr(filterAttr);

        $(`${input}[${filterAttr}="${prop}"]`).each(function() {
            if( this.checked ) {
                $(this).closest(label).addClass(state);
            } else {
                $(this).closest(label).removeClass(state);
            }
        })
    });
}

function checkInputNumber() {
    let min = 1;
    let value = undefined;
    let input = 'input[type="number"]';

    $(document).on('input', input, function() {
        if(this.value < min) {
            this.value = value;
        } else {
            value = this.value;
        }
    })
}

function lazyload() {
    let $selectors = $('img[data-src], .js-load-iframe, .js-load-bg');

    let instance = $selectors.lazy({
        chainable: false,
        visibleOnly: true,
        enableThrottle: true,
        throttle: 600,
    });

    $(document).on('click swipe afterChange', function() {
        setTimeout(function() {
            instance.update();
        }, 300);
    })
}
/* End auto */

function slickSlidersInit() {
    /**
     * All single row sliders must have option rows: 0;
     * This is to fix unwanted nested div
     */
    let slideshowArray = ['.js-comments-home-slider', '.js-examples-slideshow', '.js-projects-slideshow-imgs', '.js-teams-slideshow', '.js-recomend-slider'];

    let simpleSlideConfig = {
        rows: 0,
        dots: false,
        arrows: true,
        autoplay: true,
        autoplaySpeed: 10000,
        nextArrow: '<button type="button" class="icon-slick icon-slick--next icon-slick--simple"></button>',
        prevArrow: '<button type="button" class="icon-slick icon-slick--prev icon-slick--simple"></button>'
    };

    let recomSlideConfig = {
        rows: 0,
        dots: false,
        arrows: false,
        autoplay: true,
        slidesToShow: 3,
        autoplaySpeed: 10000,
         responsive: [
    {
      breakpoint: 576,
      settings: {
        arrows: false,
        centerMode: true,
        centerPadding: '40px',
        slidesToShow: 1
      }
    },
    {
      breakpoint: 414,
      settings: {
        arrows: false,
        centerMode: true,
        centerPadding: '40px',
        slidesToShow: 1
      }
    }
  ]
    }

    let slickCounter = '<span class="slick-counter">' +
                            '<span class="slick-current-slide-index">1</span>' +
                            '<span class="slick-counter__separator">/</span>' +
                            '<span class="slick-slides-number">5</span>' +
                        '</span>'

    slickSliders();
    let isFiltered = false;

    $('.js-slick-filter').on('click', function(e) {
        e.preventDefault();
        let filter = $(this).data('slick-filter');
        let slider = $(this).data('slick-slider');

        if(isFiltered) {
            $(slider).slick('slickUnfilter');
            isFiltered = false;
        }

        $('.js-slick-filter.active').not($(this)).removeClass('active');

        if($(this).hasClass('active')) {
            $(this).removeClass('active');
        } else {
            $(this).addClass('active');
            $(slider).slick('slickFilter', filter);
            isFiltered = true;
        }

        counter(slider);
    });

    $('.js-projects-slideshow-infos, .js-projects-slideshow-titles').slick({
        rows: 0,
        arrows: false,
        asNavFor: '.js-projects-slideshow-imgs',
        fade: true
    });
    
    $('.js-projects-slideshow-imgs').slick('slickSetOption', {'asNavFor': '.js-projects-slideshow-infos, .js-projects-slideshow-titles'}, true);

    $('.js-partners-slideshow-imgs').slick({
        rows: 0,
        dots: false,
        arrows: true,
        autoplay: true,
        slidesToShow: 4,
        autoplaySpeed: 10000,
        nextArrow: '<button type="button" class="icon-slick icon-slick--next icon-slick--simple"></button>',
        prevArrow: '<button type="button" class="icon-slick icon-slick--prev icon-slick--simple"></button>'
    });

    $('.js-about-slider').slick({
        rows: 0,
        dots: false,
        arrows: false,
        asNavFor: '.js-about-nav-slider',
        fade: true,
    });

    $('.js-about-nav-slider').slick({
        rows: 0,
        dots: false,
        arrows: false,
        autoplay: true,
        slidesToShow: 4,
        infinite: true,
        autoplaySpeed: 10000,
        infinite: true,
        asNavFor: '.js-about-slider',
    });

    $('.js-about-nav-slider .slick-slide').on('click', function() {
        let index = $(this).data('slick-index');

        $('.js-about-nav-slider').slick('slickGoTo', index);
    });

    function slickSliders() {
        $.each(slideshowArray, function(index, slideshow) {
            if(slideshow === '.js-recomend-slider') {
                $(slideshow).slick(recomSlideConfig);
            } else {
                $(slideshow).slick(simpleSlideConfig);
                $(slideshow +'.slick-initialized').append(
                    slickCounter
                );
                counter(slideshow);
                $(slideshow).on('reInit beforeChange', function(event, slick, currentSlide, nextSlide) {
                    let id = $(this).find('.slick-current .js-youtube').attr('id');
                    if(players[id]) {
                        players[id].pauseVideo();
                    }
                });
            }
        });
    }

    function counter(slideshow) {
        let totalSlides = Number($(slideshow +' .slick-cloned').length) - 1;

        $(slideshow + ' .slick-slides-number').html(totalSlides);
        $(slideshow).on('reInit afterChange', function(event, slick, currentSlide) {
            totalSlides = Number($(slideshow +' .slick-cloned').length) - 1;

            $(slideshow + ' .slick-slides-number').html(totalSlides);
            if(!currentSlide) {
                currentSlide = $(this).slick('slickCurrentSlide');
            }
            if(currentSlide >= totalSlides) {
                $(this).slick('slickGoTo', 0);
            }
            $(slideshow + ' .slick-current-slide-index').html(currentSlide + 1);
        });
    }
}

function youtube() {
    let $youtube = $(".js-youtube");

    /* LAZYLOAD ALL VIDEOS */
    for (let i = 0; i < $youtube.length; i++) {
        let src = "https://img.youtube.com/vi/"+ $youtube.eq(i).data('embed') +"/maxresdefault.jpg";

        $youtube.eq(i).append('<img data-src="' + src + '" alt="mosbruschatka video" />');
    }
}

function forms() {
    $(document).on('submit', '.js-form-callback', function(e) {
        e.preventDefault();
        let $self = $(this);
        let formTitle = $(this).data('form-title');
        let $submitBtn = $self.find('[type="submit"]');
        let data = $self.serialize() + '&title=' + encodeURIComponent(formTitle);
        let stateBtnText = [$submitBtn.html(), 'Отправляем', 'Отправлено'];

        $self.find(`input`).removeClass('input-error');

        $.ajax({
            url: 'mail/callback.php',
            type: 'POST',
            data: data,
            dataType: 'JSON',
            beforeSend: function() {
                $submitBtn.attr('disabled', 'disabled').html(stateBtnText[1]);
            },
            complete: function() {

            }
        }).done(function(response) {
            if(response['error']) {
                for(let i in response['error']) {
                    $self.find(`input[name="${i}"]`).effect('shake', shakeUiConfig);
                }
            } else {
                roistatStatus(response);
            }

            setTimeout(() => {
                if(response['error'] || response['status'] !== 'send') {
                    $submitBtn.removeAttr('disabled').html(stateBtnText[0]);
                } else {
                    $submitBtn.removeClass('flashed').addClass('btn--success').html(stateBtnText[2]);
                }
            }, 300);
        }).fail(function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        });
    });
}

function quizz() {
    let btnNext = '#calcStepperNextBtn';
    let $inputCurrentStepper;
    let $checkedInputCurrentStepper;
    let stateActiveClassName = 'active';
    let stateCompletedClassName = 'completed';
    let input = '#calcStepperInner input';
    let statehiddenClassName = 'is-offset';
    let stateVisibleClassName = 'not-offset';
    let steps = $('#calcStepperInner > div').length;
    let StepperNavItemClassName = 'js-calc-stepper';
    let stepperIndex = 1;

    stepperInit();

    $('.js-open-calc').on('click', function() {
        stepper(stepperIndex);
        $('#calcStepIntro').removeClass(stateVisibleClassName).addClass(statehiddenClassName);
        $('#calcTabShowcaseStepper').removeClass('intro');
        $('.js-calc-gift').appendTo('.js-calc-last-step');
    });

    $(btnNext).on('click', function() { 
        if(stepperIndex < steps) {
            stepperIndex = stepperIndex + 1;
            stepper(stepperIndex);
        }
    });

    /* Navigate through stepper by clicking list-item if this stepper has been already completed */
    $(document).on('click', `.${StepperNavItemClassName}`, function() {
        stepperIndex = $(this).index() + 1;

        if($(this).hasClass(stateCompletedClassName)) {
            stepper(stepperIndex);
        }
    });

    $(input).on('change', function() {
        let self = this;
        let $self = $(self);
        let inputNme = $(this).attr('name');
        let inputValue = self.value;

        if(inputNme === 'product') {
            $('.js-calc-patt-prod').hide();
            $(`.js-calc-patt-prod[data-product="${inputValue}"]`).show();
            $('#calcTabShowcaseStepper').removeClass('intro').addClass('product');
            $(`.${StepperNavItemClassName}`).removeClass(stateCompletedClassName);
            
        } else if(inputNme === 'pattern') {
            let image = '';

            for(let i = 0; i < 40; i++) {
                image += `<svg width="100" height="100"><use xlink:href="#${inputValue}"></use></svg>`;
            }

            $('#calcTabShowcaseStepper').html(`${image}`);
        } else if(inputNme === 'color1') {
            $('#calculator .user-color-1').css('fill', `${inputValue}`);
        } else if(inputNme === 'color2') {
            $('#calculator .user-color-2').css('fill', `${inputValue}`);
        }

        monitorCurrentStepper();
    });

    $('#calcResetForm').on('click', function() {
        calcReset();
    });

    function slider() {
        let min = 30;
        let max = 1000;
        let value = min;
        
        $('#calcStepperSurface').on('input', function(){
            value = this.value;
            if(value > max) {
                value = max;
            }
            this.value = value;
        });
        $('#calcStepperSurface').on('focusout', function() {
            value = this.value;
    
            if(value < min) {
                value = min;
            }
    
            this.value = value;
    
        });
        $('#calcStepperSurface').on('keypress', function() {
            if(event.keyCode==13){
            value = this.value;
    
            if(value < min) {
                value = min;
            }
    
            this.value = value;
            }
        });
    }

    

    function monitorCurrentStepper() {
        $inputCurrentStepper = $('#calcStepperInner > .active').find('input[type="radio"]:visible');
        $checkedInputCurrentStepper = $inputCurrentStepper.filter(':checked');
        controls();
    }

    function stepperInit() {
        for(let i = 0; i < steps; i++) {
            $('#calcStepperList').append(`<li class="${StepperNavItemClassName}"></li>`);
        }
        stepper(stepperIndex);
    
        $('#calcStepperInner').css('margin-bottom', 0);
        
        slider();
    }

    function calcReset() {
        stepperIndex = 1;
        $('#calcForm input[type="radio"]').removeAttr('checked');
        $('#calculator .user-color-1, #calculator .user-color-2').css('fill', '#fff');
        $(`.${StepperNavItemClassName}`).removeClass(`${stateActiveClassName} ${stateCompletedClassName}`);
        $('#calcStepEnd').hide();
        $('#calcForm').fadeIn();
        $('#calcStepIntro').removeClass(statehiddenClassName).addClass(stateVisibleClassName);
        $('#calcTabShowcase').removeClass('ready');
        $('#calcTabShowcaseStepper').removeClass('product').addClass('intro').html('');
        $('.js-calc-gift').appendTo('#calcStepIntro');
    }

    function controls() {
        if($inputCurrentStepper.length > 0 && $checkedInputCurrentStepper.length < 1) {
            $(btnNext).attr('disabled', 'disabled');
        } else {
            $(btnNext).removeAttr('disabled');
        }
    }

    /**
     * Go to specific step
     * 
     * @param {*} index: represent the index of the stepper's div
     */
    function stepper(index) {
        stepperIndex = index;
        let step = index - 1;

        // Stepper list
        $(`.${StepperNavItemClassName}.${stateActiveClassName}`).removeClass(stateActiveClassName).addClass(stateCompletedClassName);
        $(`.${StepperNavItemClassName}`).eq(step).removeClass(stateCompletedClassName).addClass(stateActiveClassName);

        // Stepper inner
        $(`#calcStepperInner > div.${stateActiveClassName}`).hide().removeClass(stateActiveClassName).promise().done(function() {
            $('#calcStepperInner > div').eq(step).fadeIn().addClass(stateActiveClassName);
        });

        // Controls
        $(btnNext).val(index);
        
        if(index < steps) {
            $('#calcStepperControls').show();
            $('#calcTabShowcase').removeClass('ready');
        } else {
            $('#calcStepperControls').hide();
            $('#calcTabShowcase').addClass('ready');
        }

        monitorCurrentStepper();
    }
}

function roistatStatus(roistat) {

    if(roistat.status === 'send') {
        window.location.href = '/index.php?route=checkout/success';
    } else {
        $.fancybox.open({
            src: '#modalFail',
            type: 'inline',
            opt: {
                smallBtn: false,
            }
        });
    }

}

function fancybox() {
    let elts = '.js-modal, .js-download-catalog, .js-nav-top-link, .js-nav-actions-link, .js-callback';

    $(document).on('click', elts, function(e) {
        e.preventDefault();
        let source  = $(this).attr('href');
        let type = $(this).data('type');
        
        if(!source) {
            source = $(this).data('target');
        }

        if(!type) {
            type = 'inline';
        }

        if(source.charAt(0) !== '#' || type === 'ajax') {
            $.fancybox.open({
                href: source,
                type: 'ajax',
            });
        } else {
            $.fancybox.open({
                src: source,
                type: 'inline',
                autofocus: false,
                touch: false,
            });
        }
    });
}

function sortProducts() {
    $(document).on('click', '.js-catalog-sort', function(e) {
        e.preventDefault();
        $('.js-catalog-sort').not($(this)).attr('title', '-');
        let link = $(this).attr('href');
        let title = $(this).attr('title');
        let self = $(this);

        if(title === 'возрастанию') {
            link = link + 'DESC';
        } else {
            link = link + 'ASC';
        }

        $.ajax({
            url: link,
            type: 'GET',

            beforeSend: function() {
                $('#mainContainer').addClass('loading');
            },
            complete: function() {
                $('#mainContainer').removeClass('loading');
                if(title === 'возрастанию') {
                    self.attr('title', 'убыванию');
                } else {
                    self.attr('title', 'возрастанию');
                }
            }
        })
        .done(function(response) {
            $('#mainContainer').replaceWith($(response).find('#mainContainer'));
            $('.js-catalog-products-list-img').autoHeight(195, '.js-catalog-products-list-name');
        });
    });
}

function ocFilter() {
    let arrayOptions = {};
    let arrayLink = [];
    let commonPageLink = window.location.protocol + '//' + window.location.hostname + ':' + window.location.port + window.location.pathname;
    let path = $('#path').val();
    let link = undefined;
    let minVal = undefined;
    let maxVal = undefined;
    let range = undefined;

    $(document).on('click', '.js-ocf-value-link', function(e) {
        e.preventDefault();

        if(path != $('#path').val()) {
            arrayOptions = {};
            arrayLink = [];
            commonPageLink = window.location.protocol + '//' + window.location.hostname + ':' + window.location.port + window.location.pathname;
            path = $('#path').val();
        }
        
        let param =  $(this).attr('href').split('/');
        let option = param[param.length - 2];
        let value = param[param.length - 1];

        // Collect element of link
        if(option in arrayOptions) {
            let arrayOption = arrayOptions[option];

            if(arrayOption.includes(value)) {
                arrayOption.splice(arrayOption.indexOf(value), 1 );;
            } else {
                arrayOption.push(value);
            }
        } else {
            arrayOptions[option] = [value];
        }

        // Create the new link
        let arrayEntries = Object.entries(arrayOptions);
        arrayLink = [];

        for(let [option, value] of arrayEntries) {
            if(value.length > 0) {
                arrayLink.push(option + '/' + value.join('/'));
            }
        }

        link = commonPageLink + arrayLink.join('/');
        if (range) {
            link = link + '/price/' + range;
        }

        $.ajax({
            url: link,
            type: 'post',

            beforeSend: function() {
                $('main').addClass('loading');
            },
            complete: function() {
                $('main').removeClass('loading');
            }
        }).done(function(response, status) {
            if(status === 'success') {
                $('#catalogue').replaceWith($(response).find('#catalogue'));
                $('.js-catalog-products-list-img').autoHeight(195, '.js-catalog-products-list-name');
                window.history.pushState(null, 'Catalog', link);
            }
        });
    });

    $(document).on('slide', '#ocfPriceScale', function(event, ui) {
        minVal = ui.values[0];
        maxVal = ui.values[1];
        range = minVal + '-' + maxVal;
        $('#ocfMinPrice').val(minVal);
        $('#ocfMaxPrice').val(maxVal);
    });

    $(document).on('input', '#ocfMinPrice, #ocfMaxPrice', function() {
        minVal = $('#ocfMinPrice').val();
        maxVal = $('#ocfMaxPrice').val();
        range = minVal + '-' + maxVal;
        $('#ocfPriceScale').slider('option', 'values', [minVal, maxVal]);
    });

    $(document).on('change', '#ocfMinPrice, #ocfMaxPrice', function() {
        $('#ocfPriceScale').trigger('slidestop');
    });

    $(document).on('slidestop', '#ocfPriceScale', function(event, ui) {
        $.ajax({
            url: window.location.href + '/price/' + range,
            type: 'post',

            beforeSend: function() {
                $('#wrapper').addClass('loading');
            }
        }).done(function(response, status) {
            if(status === 'success') {
                $('#catalogue').replaceWith($(response).find('#catalogue'));
                $('.js-catalog-products-list-img').autoHeight(195, '.js-catalog-products-list-name');
            }
        }).always(function() {
            $('#wrapper').removeClass('loading');
        });
    });
}

function navCategory() {
    $(document).on('click', '.js-ajax-nav-category-link', function(e) {
        e.preventDefault();
        let link = this.href;

        $.ajax({
            url: link,
            type: 'GET',
            beforeSend: function() {
                $('#wrapper').addClass('loading');
            }
        }).done(function(response) {
            $('#wrapper').replaceWith($(response).find('#wrapper'));
            window.history.pushState(null, null, link);
        }).always(function() {
            $('#wrapper').removeClass('loading');
        });
    });
}

function searchBar() {
    let $input = $('#jsSearchBlockInput');
    let $searchBtn = $('#jsSearchBtn');
    let $closeBtn = $('#jsCloseSearchBlock');
    let $openBtn = $('.js-open-search-block');
    let value = $input.val();
    let $results = $('#jsSearchOutput');
    let minValueLength = 0;

    $input.on('keyup', function() {
        value = $input.val();

        if(value.length > minValueLength) {
            $results.fadeIn(0);
            searchFor(value);
        } else {
            $results.fadeOut(0);
        }
    });

    $openBtn.on('click', function() {
        $('#jsSearchBlock').fadeIn();
        setTimeout(function() {
            $('#jsSearchBlockInner').switchClass('is-offset', 'not-offset', 100);
        }, 100);
    });

    $closeBtn.on('click', function() {
        $('#jsSearchBlockInner').switchClass('not-offset', 'is-offset', 100);
        $('#jsSearchBlock').fadeOut();
    });
    
    function searchFor(keyword) {
        let link = 'index.php?route=product/search&search=' + keyword;

        $.ajax({
            url: 'index.php?route=product/product/autocomplete&filter_name=' + keyword,
            type: 'post',
            dataType: 'json',

            success: function(json) {
                searchPreview(json);
            }
        });

        $searchBtn.on('click', function() {         
            if(value.length > 0) {
                window.location.href = link;
            } else {
                $input.focus();
            }
        });
    
        $input.keypress(function(e) {
            if(e.which === 13) {
                window.location.href = link;
            }
        });
    }

    function searchPreview(data = {}) {
        if(data) {
            $results.html('<ul class="search-block__list"></ul>');
            $.each(data, function(index, item) {
                $results.find('ul').append(
                    '<li class="search-block__list-item" data-value="' + item['value'] + '">' +
                    '<a href="' + item['href'] + '" class="search-block__link">' +
                    '<div class="search-block__img"><img src="' + item['image'] + '" alt=""></div>' +
                    '<div class="search-block__infos">' +
                    '<p class="search-block__name">' + item['name'] + '</p>' +
                    '<p class="search-block__price-default">' + item['price'] + '</p></div>' +
                    '</a></li>'
                );
            });
        }
    }
}

function fixedHeader() {
    let $header = $('#headerTop');
    let $nav = $('#navbar');
    let fixedHeaderClassName = 'is-sticked';
    //let headerPosBot = $header.offset().top + $header.outerHeight(true);
    let headerPosBot = 40;

    $(window).on('load resize scroll', function() {
        if(headerPosBot > window.pageYOffset) {
            if($nav.hasClass(fixedHeaderClassName)) {
                $nav.removeClass(fixedHeaderClassName);
            }
        } else if (headerPosBot + 12 < window.pageYOffset){
            if(!$nav.hasClass(fixedHeaderClassName)) {
                $nav.addClass(fixedHeaderClassName);
            }
        }
    })
}

function navbar() {
    let $mobNavBtn = $('.js-open-mob-nav');
    let $mobnav = $('#mobNav');
    let $mobNavInner = $('#mobNavInner');
    let visibleClass = 'not-offset';
    let hiddenClass = 'is-offset';
    let btnStatus = 'active';

    $mobNavBtn.on('click', function() {
        if($(this).hasClass(btnStatus)) {
            $mobNavInner.switchClass(visibleClass, hiddenClass, 300);
            setTimeout(function() {
                $mobnav.fadeOut();
            }, 100);
            $(this).switchClass(btnStatus, '');
        } else {
            $mobnav.fadeIn();
            $mobNavInner.switchClass(hiddenClass, visibleClass, 300);
            $(this).switchClass('', btnStatus);
        }
    });
}

function popups() {
    let $elt = $('.js-call-popup');

    $elt.on('mouseenter', function() {
        let popup = $(this).data('popup');

        $(this).after($(popup));
    });
}

function citySelection() {
    $(document).on('click', '#headerCities', function(e) {
        e.preventDefault();
        e.stopPropagation();
        // Force trigger checked label's input clicked
        $('#'+$(e.target).attr('for')).prop('checked',true);
        if($(this).hasClass('expanded')) {
            let link = $(this).find('input:checked').val();
            if(link != 'false') {
                window.location.assign(link);
            }
        }
        $(this).toggleClass('expanded');
    });
    $(document).click(function() {
        $('#headerCities').removeClass('expanded');
    });
}

function scrollToTop() {
    var $s = $('.js-stt');
    if ($s.length && window.innerWidth > 767) {
        $(window).scroll(function(){
            if ($(this).scrollTop() > 300){
                $s.addClass('active');
            } else {
                $s.removeClass('active');
            }
        });
         $s.on('click', function(e){
            $('html, body').animate({
                scrollTop: 0
            }, 400);
             e.preventDefault();
         });
    }
}

function tabs() {
    $('.js-tab-btn').tabs();
}

function accordion() {
    $(document).on('click', '.js-accordion', function(e) {
        e.preventDefault();
        let $panel = $(this).next();
        
        $(this).toggleClass('is-hidden');
        $panel.toggle('blind');
    });
}

function cartStep() {
    let form = '#formCart';
    let formBtnControl = '.js-cart-control-btn';
    let submitOrderBtn = '#cartSubmitOrderBtn';
    let inputPaymentMethod = 'input[name="paymentMethod"]';

    /**
     * On click, determine the next step index;
     * Then, update cart_user database;
     * Move to step according to its index
     */
    $(document).on('click', formBtnControl, function(e) {
        e.preventDefault();
        let $self = $(this);
        let nextStep = this.value;
        let data = $(form).serialize() + '&step=' + nextStep;

        $.ajax({
            url: 'index.php?route=checkout/cart_user',
            type: 'POST',
            data: data,
        }).done(function(response) {
            if(response['error']) {
                for(let i in response['error']) {
                    $(form).find(`input[name="${i}"]`).effect('shake', shakeUiConfig);
                }
            } else {
                stepper(data);
            }
        }).fail(function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        });
    });

    /**
     * Stepper
     */
    let stepper = function(data) {
        $.ajax({
            url: 'index.php?route=checkout/cart',
            type: 'POST',
            data: data,
            beforeSend: function() {
                $(`${form}, #formCartResult`).addClass('loading loader--centered');
            },
            complete: function() {
                $(`${form}, #formCartResult`).removeClass('loading loader--centered');
            }
        }).done(function(response) {
            $('#cart').replaceWith($(response).find('#cart'));
        });
    }

    /**
     * Hide Delivery form if input[name=delivey[status]] is unchecked
     */
    $(document).on('change', '.js-cart-del-check-status', function() {
        if($(this).is(':checked')) {
            $('#jsCartDelForm').removeClass('disabled');
            $('#jsCartDelForm').find('.input:disabled').removeAttr('disabled');
        } else {
            $('#jsCartDelForm').addClass('disabled');
            $('#jsCartDelForm').find('.input').attr('disabled', 'disabled');
        }
    });

    /**
     * Updated totalPrice on paymentMethod change
     */
    $(document).on('change', inputPaymentMethod, function() {
        $.ajax({
            url: 'index.php?route=checkout/cart/pricesByPaymentMethod',
            type: 'POST',
            data: {paymentMethod: this.value},
            dataType: 'JSON'
        }).done(function(response) {
            $('.js-cart-total-price').html(response.totalPrice);
        });
    });

    /**
     * 
     */
    $(document).on('click', submitOrderBtn, function() {
        $.ajax({
            url: 'index.php?route=checkout/cart_user/submitOrder',
            type: 'POST',
            beforeSend: function() {
                $('#cart').addClass('loading');
            },
            complete: function() {
                //$('#cart').removeClass('loading');
            }
        }).done(function(response) {
            if(response.success == 1) {
                $.ajax({
                    url: 'mail/buy-product.php',
                    type: 'POST',
                    data: response,
                }).done(function() {
                    window.location.assign(response.redirect)
                })
            }
        });
    });
}

function cartActions() {
    let btnFastAdd = '.js-cart-fast-add';
    let form = '#buyProduct';
    let btnRemove = '.js-cart-remove';
    let btnClear = '.js-cart-clear';
    let spinner = '.js-cart-spinner';
    let min = 1;
    let value = 1;

    $(document).on('input', spinner, function() {
        if(this.value < min) {
            this.value = value;
        } else {
            value = this.value;
        }
    });

    $(document).on('change', spinner, function(e) {
        e.preventDefault();
        let $form = $(this).closest('form');
        let data = $form.serialize();

        cart.update(data);
    });

    $(document).on('click', btnFastAdd, function(e) {
        e.preventDefault();

        let productCard = $(this).closest('.product-card');
        let params = productCard.data('params') !== null ? productCard.data('params') : {};
        let $this = $(this);
        params['product_id'] = $this.val();

        if ($this.prop('added') == true) {
            $('.js-counter').trigger('click');
            return;
        }

        cart.fastAdd(params, function() {
            $this.html('в корзине').addClass('checked-cart').prop('added', true);

            let image = productCard.find('img');

            cartAnimation(image, $this, image.width());
        });
    });

    $(document).on('click', btnRemove, function(e) {
        e.preventDefault();
        let id = this.value;

        cart.remove(id);
    });

    $(document).on('submit', form, function(e) {
        e.preventDefault();
        let button = $(form).find('[type=submit]');
        if (button.prop('added') == true) {
            $('.js-counter').trigger('click');
            return;
        }
        let data = $(this).serialize();

        cart.add(data, function() {
            button.html('В корзине').removeClass('btn--yellow').addClass('btn--green').prop('added', true);

            let image = $(form).find(".js-control__img").find("img");
            let startWidth = 150;
            cartAnimation(image, button, startWidth);
        });
    });

    $(document).on('click', btnClear, function(e) {
        e.preventDefault();     
        cart.clear();
    });
}

function cartAnimation(img, from, startWidth) {
    let cartObj = $(".js-call-popup:visible").last();
    let endWidth = 20;
    img.clone()
                .css({
                    'width': startWidth,
                    'position': 'absolute',
                    'z-index': '9999',
                    top: from.offset().top,
                    left: from.offset().left
                })
                .appendTo("body")
                .animate({
                    opacity: 0.05,
                    left: cartObj.offset().left,
                    top: cartObj.offset().top,
                    width: endWidth
                }, 1000, function() {
                    $(this).remove();
                });
}

function inputmask() {
    $('input[name="phone"]').inputmask({mask:"+ 7 (999) 999 - 99 - 99", clearIncomplete: true});
    $('input[name="email"], .js-email').inputmask({alias:"email", "clearIncomplete": true});
}

function switchWebsite() {

        if(window.location.hostname.includes('opt')) { 
            $('.js-nav__link').html("Розничным покупателям") 
            $('.js-nav__link').attr("href", `${window.location.protocol}//${window.location.hostname.replace("opt.","")}`)
            } else { 
            $('.js-nav__link').html("Оптовым покупателям") 
            $('.js-nav__link').attr("href", `${window.location.protocol}//opt.${window.location.hostname}`)
            }
    
    $('#headerSwitcherToggle').on('change', function(){
        let path = window.location.hostname;

        if(path.includes('opt')) {
            link = path.replace('opt.', '')
            window.location.assign(`${window.location.protocol}//${link}`);
        } else {
            window.location.assign(`${window.location.protocol}//opt.${path}`);
        }
    });


}

function delCompute() {
    let $locs = $('#delCompLocs');
    let $result = $('#delCompResult');

    $('#delCompLocs .js-btn-next').on('click', function() {
        $locs.hide();
        $result.fadeIn();
    });

    $('#delCompResult .js-btn-prev').on('click', function() {
        $result.hide();
        $locs.fadeIn();
    });
}

function formConsultation() {
    let $chrono, chrono;
    let number = 5;
    
    $('.js-form-consultation').on('submit', function(e) {
        e.preventDefault();
        let data = $(this).serialize();
        data = data + '&percent=' + number;

        $.ajax({
            url: '/mail/consultation.php',
            type: 'POST',
            data: data,
        }).done(function(response) {
            roistatStatus(response);
        }).fail(function() {

        }).always(function() {

        });
    });

    // appear({
    //  init: function init(){
    //      $chrono = $('#chrono');
    //      $chrono.html(number + ' %');
    //  },
    //  elements: function elements(){
    //       return $chrono;
    //  },
    //  appear: function appear(el){
    //      function startChrono() {
    //          chrono = setInterval(function() {
    //              number = (number - 0.01).toFixed(2);
                    
    //              $(el).html(number + ' %')
    //              if($('#consultation .js-phone').inputmask('isComplete')) {
    //                  stopChrono();
    //              };

    //              if(number < 1) {
    //                  stopChrono();
    //              }
    //          }, 1000);
    //      }

    //      function stopChrono() {
    //          clearInterval(chrono);
    //      }

    //      startChrono();
    //  },
    //  bounds: 200,
    //  reappear: false
    // });
}

function downloadFile() {
    $(document).on('click', '.js-download-file', function() {
        let filename = $(this).data('file');
        let url = 'https://assets.mos-bruschatka.ru/downloads/' + filename;
        download(url);
    });
}

function download(dataurl) {
    var a = document.createElement("a");
    a.href = dataurl;
    a.target = '_blank';
    var b = document.createEvent("MouseEvents");
    b.initEvent("click", false, true);
    a.dispatchEvent(b);
    return false;
}

function wrapperMinHeight() {
    let windowHeight = $(window).height();
    $('#wrapper').css('min-height', (windowHeight - (200 + $('#footer').outerHeight(true) + $('#header').outerHeight(true))));
}

function ajaxRequest() {
    $(document).on('click', '.js-ajax', function(e) {
        e.preventDefault();
        let $self = $(this);
        let link = $(this).attr('href');
        let target = $(this).data('target');

        if(!link) {
            link = $(this).data('url');
        }

        if($self.hasClass('active')) {
            return false;
        }

        $.ajax({
            url: link,
            type: 'GET',
            beforeSend: function() {
                $('.js-ajax.active').switchClass('active', '', 100).promise().done(function() {
                    $self.switchClass('', 'active', 100);
                });
            }
        }).done(function(response) {
            $(target).replaceWith($(response).find(target));
        });
    });
}

function customSelect() {
    let x, i, j, selElmnt, a, b, c;
    /*look for any elements with the class "custom-select":*/
    x = document.getElementsByClassName("custom-select");
    for (i = 0; i < x.length; i++) {
        selElmnt = x[i].getElementsByTagName("select")[0];
        /*for each element, create a new DIV that will act as the selected item:*/
        a = document.createElement("DIV");
        a.setAttribute("class", "select-selected");
        a.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
        x[i].appendChild(a);
        /*for each element, create a new DIV that will contain the option list:*/
        b = document.createElement("DIV");
        b.setAttribute("class", "select-items select-hide");
        for (j = 1; j < selElmnt.length; j++) {
            /*for each option in the original select element,
            create a new DIV that will act as an option item:*/
            c = document.createElement("DIV");
            c.innerHTML = selElmnt.options[j].innerHTML;
            c.addEventListener("click", function(e) {
                /*when an item is clicked, update the original select box,
                and the selected item:*/
                let y, i, k, s, h;
                s = this.parentNode.parentNode.getElementsByTagName("select")[0];
                h = this.parentNode.previousSibling;
                for (i = 0; i < s.length; i++) {
                    if (s.options[i].innerHTML == this.innerHTML) {
                        s.selectedIndex = i;
                        h.innerHTML = this.innerHTML;
                        y = this.parentNode.getElementsByClassName("same-as-selected");
                        
                        for (k = 0; k < y.length; k++) {
                            y[k].removeAttribute("class");
                        }

                        this.setAttribute("class", "same-as-selected");
                        break;
                    }
                }
                h.click();
            });

            b.appendChild(c);
        }

        x[i].appendChild(b);

        a.addEventListener("click", function(e) {
            /*when the select box is clicked, close any other select boxes,
            and open/close the current select box:*/
            e.stopPropagation();
            closeAllSelect(this);
            this.nextSibling.classList.toggle("select-hide");
            this.classList.toggle("select-arrow-active");
        });
    }

    function closeAllSelect(elmnt) {
        /*a function that will close all select boxes in the document,
        except the current select box:*/
        let x, y, i, arrNo = [];
        x = document.getElementsByClassName("select-items");
        y = document.getElementsByClassName("select-selected");
        for (i = 0; i < y.length; i++) {
            if (elmnt == y[i]) {
                arrNo.push(i)
            } else {
                y[i].classList.remove("select-arrow-active");
            }
        }
        for (i = 0; i < x.length; i++) {
            if (arrNo.indexOf(i)) {
                x[i].classList.add("select-hide");
            }
        }
    }
    /*if the user clicks anywhere outside the select box,
    then close all select boxes:*/
    document.addEventListener("click", closeAllSelect);
}

function filialsAddress() {
    $(document).on('click', '#filialsAddress', function() {
        let self = $(this);
        let value = $(this).find('option:selected').val();
        let target = $(this).find('option:selected').data('target');

        $('.js-filials-info').each(function() {
            $(this).hide();
        }).promise().done(function() {
            $(target).fadeIn();
        });
    });
}

function animScroll() {
    $('.js-anim-scroll').on('click', function(e) {
        e.preventDefault();
        let $self = $(this);
        let target = $self.attr('href');
        
        if(!target) {
            target = $self.data('target');
        }

        if( $(target).length ) {
            $('html, body').animate({
                scrollTop: $(target).offset().top - 50
            }, 900);
        }
    });
}

function extendMap() {
    let containerWidth = $('.js-get-margin').width();
    let windowWidth = $(window).width();
    let margin = (windowWidth - containerWidth) / 2;

    $('#visitUsMap').css('width', 'calc(100% + ' + margin + 'px)');
}

function unclassified() {
    $('input, textarea').placeholder();
    
    $(document).on('click', '#jsCatDescFullHeight', function() {
        $('#jsCatDesc').toggleClass('collapsed');
        $(this).toggleClass('is-collapsed');
    });

    // Product-page
    $(document).on('change', '.radiobox-colors__list-item input', function() {
        let myId = $(this).attr('id');
        let $label = $(`.label--color[for="${myId}"]`);
        let color = $label.attr('title');
        
        $('.js-content-color').html(color);
        $label.find('a').click();
    });
}

function downloadCatalogCounter() {
    let timer, status = false, value = 5;
    $('.js-modal-download-catalog-discount').val(value);

    $('.js-modal[data-target="#modalDownloadCatalog"], .js-modal[href="#modalDownloadCatalog"]').on('click', function() {
        if (status === false) {
            status = true;

            timer = setInterval(function() {
                value = (value - 0.01).toFixed(2);

                if (value < 1.01) {
                    value = 1.01;
                    clearInterval(timer);
                }

                if (value < 3) {
                    $('.js-modal-download-catalog-discount').css({
                        'color': '#ff0000'
                    });
                }

                $('.js-modal-download-catalog-discount').val(value);
            }, 1000);
        }
    });

    $('#formCatalog .js-phone').on('input', function() {
        if($(this).inputmask('isComplete')) {
            clearInterval(timer);
        }
    });
}

function consultationCounter() {
    let timer, status = false, value = 5;
    $('.js-consultation-discount').val(value);

    if (status === false) {
        status = true;

        timer = setInterval(function() {
            value = (value - 0.01).toFixed(2);

            if (value < 1.01) {
                value = 1.01;
                clearInterval(timer);
            }

            if (value < 3) {
                $('.js-consultation-discount').css({
                    'color': '#ff0000'
                });
            }

            $('.js-consultation-discount').val(value);
            $('.js-consultation-discount').html(value);
        }, 1000);
    }

    $('.js-consultation-discount').closest('form').on('submit', function() {
        if($(this).find('input[name="phone"]').inputmask('isComplete')) {
            clearInterval(timer);
        }
    });
}

$(function() {
    fixedHeader();
    navbar();
    wrapperMinHeight();
    youtube();
    slickSlidersInit();
    sortProducts();
    ocFilter();
    searchBar();
    scrollToTop();
    tabs();
    accordion();
    cartStep();
    fancybox();
    navCategory();
    citySelection();
    switchWebsite();
    delCompute();
    formConsultation();
    downloadFile();
    ajaxRequest();
    customSelect();
    filialsAddress();
    animScroll();
    cartActions();
    extendMap();
    popups();
    downloadCatalogCounter();
    consultationCounter();
    forms();
    quizz();

    // Auto
    checkInputNumber();
    labelSelection();
    unclassified();
    lazyload();
});

$(document).ajaxComplete(function() {
    if($('img[data-src]').length) {
        lazyload();
    }
    inputmask();
});

$(window).on('load', function() {
    $('.js-product-card-img').autoHeight(195, '.js-product-card-name');
    $('.js-recomend-slideshow-img').autoHeight(150, '.js-recomend-slideshow-link');
        if (window.innerWidth <= 576) {
            $(".js-control__media").insertAfter(".js-control__img")
        } else {
            $(".js-control__media").prependTo(".js-control__col-right")
        }
    inputmask();
});

$(window).on('resize', function() {
    $('.js-product-card-img').autoHeight(195, '.js-product-card-name');
    $('.js-recomend-slideshow-img').autoHeight(150, '.js-recomend-slideshow-link');
        if (window.innerWidth <= 576) {
          $(".js-control__media").insertAfter(".js-control__img")
        } else {
          $(".js-control__media").prependTo(".js-control__col-right")
        }
        
    scrollToTop();
    extendMap();
});

$(window).on('scroll', function() {
    
})

$.fn.extend({
    autoHeight: function(height, item) {
        return this.each(function() {
            let itemHeight = $(this).closest('div').find(item).height();
            let newHeight = height - itemHeight;
    
            $(this).height(newHeight);
        });
    },

    tabs: function() {
        return this.each(function() {
            $(this).on('click', function(e) {
                e.preventDefault();
                let $self = $(this);
                let target = $self.attr('href');

                let $lastActive = $self.closest('.tabs').find('.js-tab-btn.active');
                let lastTarget = $lastActive.attr('href');
                

                if(!target) {
                    target = $(this).data('target');
                }

                if(!lastTarget) {
                    lastTarget = $lastActive.data('target');
                }

                if(!$self.hasClass('active')) {
                    $(lastTarget).hide().promise().done(function() {
                        $(target).fadeIn();
                        $self.addClass('active');
                        $lastActive.removeClass('active');
                    });
                }
            });

            if($(this).hasClass('default')) {
                $(this).removeClass('default');
                $(this).trigger('click');
            }
        });
    }
});

//hits wholesale FancyBox init
$(function() {
    $('#hits.wholesale .product-card a').fancybox({type: 'ajax'});
});

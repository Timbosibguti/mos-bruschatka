<?php echo $header; $col = $column_left ? 9 : 12; $col = $column_right ? $col - 3 : $col; ?>
<div class="alerts">
<?php if ($error_warning) { ?>
	<div class="alert alert--red">
		<span class="alert__text">
			<?php echo $error_warning; ?>
		</span>
		<a href="#" class="alert__close">x</a>
	</div>
<?php } ?>
</div>
<main class="section" id="wrapper">
	<div class="container">
	<?php echo $content_top; ?>
		<div class="breadcrumbs breadcrumbs--sm-pad">
			<ul class="breadcrumb__list">
			<?php foreach ($breadcrumbs as $i=> $breadcrumb) { ?>
			<?php if($i == 0) { ?>
				<li class="breadcrumb__list-item"><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>
			<?php } elseif($i + 1 < count($breadcrumbs)) { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><a href="<?php echo $breadcrumb['href']; ?>"><span><?php echo $breadcrumb['text']; ?></span></a></li>		
			<?php } else { ?>
				<li class="breadcrumb__list-item"><svg class="icon-chevron-right"><use xlink:href="#chevron-small-left"></use></svg><span><?php echo $breadcrumb['text']; ?></span></li>		
			<?php } ?>
			<?php } ?> 			
			</ul>
		</div>
    <h1 class="content__title"><?php echo $heading_title; ?></h1>
	<div class="row">
		<?php echo $column_left ? '<div class="col-sm-3">' . $column_left . '</div>' : ''?>
		<div class="col-md-<?php echo $col -4; ?> col-xs-12">
		
					<div class="checkout" id="step-1">
						<div class="checkout__title">
							<svg class="icon-location-pin"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#user"></use></svg>
							<h3><?php echo $text_lightshop_checkout_s1; ?></h3>
						</div>
						<div class="checkout__inner" id="collapse-checkout-option">
						</div>
					</div>				
					<div class="checkout" id="step-2">
						<div class="checkout__title">
<svg class="icon-v-card" version="1.1" id="V-card" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
	 viewBox="0 0 20 20" enable-background="new 0 0 20 20" xml:space="preserve">
<path  d="M19,3H1C0.447,3,0,3.447,0,4v12c0,0.552,0.447,1,1,1h18c0.553,0,1-0.448,1-1V4C20,3.448,19.553,3,19,3z
	 M13,7h4v1h-4V7z M11,14.803c-0.129-0.102-0.293-0.201-0.529-0.303c-1.18-0.508-2.961-1.26-2.961-2.176
	c0-0.551,0.359-0.371,0.518-1.379c0.066-0.418,0.385-0.007,0.445-0.961c0-0.38-0.174-0.475-0.174-0.475s0.088-0.562,0.123-0.996
	c0.036-0.453-0.221-1.8-1.277-2.097C6.959,6.228,6.834,6.305,7.403,6.004C6.159,5.945,5.869,6.596,5.207,7.075
	C4.643,7.495,4.49,8.16,4.518,8.514C4.555,8.947,4.643,9.51,4.643,9.51S4.468,9.604,4.468,9.984c0.061,0.954,0.38,0.543,0.445,0.961
	c0.158,1.008,0.519,0.828,0.519,1.379c0,0.916-1.781,1.668-2.961,2.176C2.268,14.588,2.122,14.673,2,14.76V5h9V14.803z M18,11h-5v-1
	h5V11z"/>
</svg>
							<h3><?php echo $text_lightshop_checkout_s2; ?></h3>
						</div>
						<div class="checkout__inner" id="collapse-payment-address">
						</div>
					</div>
					<?php if ($shipping_required) { ?>
					<div class="checkout" id="step-3" <?php echo $checkout_st3_sa ? 'style="display: none;"' : '' ?>>
						<div class="checkout__title">
							<svg class="icon-map"><use xlink:href="#l-map"></use></svg>
							<h3><?php echo $text_lightshop_checkout_s3; ?></h3>
						</div>
						<div class="checkout__inner" id="collapse-shipping-address">
						</div>
					</div>
					<?php } ?>
					<div class="checkout" id="step-4">
						<div class="checkout__title">
							<svg class="icon-location-pin"><use xlink:href="#location-pin"></use></svg>
							<h3><?php echo $text_lightshop_checkout_s4; ?></h3>
						</div>
						<div class="checkout__inner" id="collapse-shipping-method">
						</div>
					</div>
					

				
		</div>
		<div class="col-md-<?php echo $col -8; ?> col-xs-12" id="custcart"></div>		
		<?php //echo $column_right ? '<div class="col-sm-3">' . $column_right . '</div>' : ''?>
	</div>	

	<?php echo $content_bottom; ?>
	</div>
</main>	
<?php echo $footer; ?>
<script type="text/javascript"><!--
<?php if (!$logged) { ?>
$(document).ready(function() {
    $.ajax({
        url: 'index.php?route=checkout/login',
        dataType: 'html',
        complete: function() {
			initCustomScroll();
			order();
        },
        success: function(html) {
			$('#collapse-checkout-option').html(html);
			
			$('#collapse-checkout-option').parent().addClass('pass');
			setTimeout(function(){
				$('#collapse-checkout-option').parent().find('.checkout__title').trigger('click');
				svgFix();
			},300);
			
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});
<?php } else { ?>
$(document).ready(function() {
    $.ajax({
        url: 'index.php?route=checkout/payment_address',
        dataType: 'html',
        complete: function() {
			$('#button-account').removeAttr('disabled');
        },
        success: function(html) {
            $('#collapse-payment-address').html(html);

			$('#collapse-checkout-option').parent().addClass('disabled');
			
			$('#collapse-payment-address').parent().addClass('pass');
			
			setTimeout(function(){
				$('#collapse-payment-address').parent().find('.checkout__title').trigger('click');
				svgFix();
			},300);	
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});
<?php } ?>
$(document).ready(function() {
	refreshcart();
});	
// Checkout
$(document).delegate('#button-account', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/' + $('input[name=\'account\']:checked').val(),
        dataType: 'html',
        beforeSend: function() {
        	$('#button-account').attr('disabled', 'disabled');
		},
        complete: function() {
			$('#button-account').removeAttr('disabled');

        },
        success: function(html) {
            $('.alert, .checkout__input-box-error').remove();

            $('#collapse-payment-address').html(html);

			$('#collapse-payment-address').parent().addClass('pass');
			
			setTimeout(function(){
				$('#collapse-payment-address').parent().find('.checkout__title').trigger('click');
				svgFix();
			},300);	

        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$(document).delegate('input[name=\'customer_group_id\']', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/' + $('input[name=\'account\']:checked').val(),
        type: 'post',
        data: $('input[name=\'customer_group_id\']:checked'),
        dataType: 'html',
        success: function(html) {

            $('#collapse-payment-address').html(html);
			
			setTimeout(function(){
				svgFix();
			},300);	

        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

// Login
$(document).delegate('#button-login', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/login/save',
        type: 'post',
        data: $('#collapse-checkout-option :input'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-login').attr('disabled', 'disabled');
		},
        complete: function() {
            $('#button-login').removeAttr('disabled');
        },
        success: function(json) {
            $('.alert, .checkout__input-box-error').remove();
            $('.form-group').removeClass('has-error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
					$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> ' + json['error']['warning'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
					alertClose();

				// Highlight any found errors
				$('input[name=\'email\']').parent().addClass('has-error');
				$('input[name=\'password\']').parent().addClass('has-error');
		   }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

// Register
$(document).delegate('#button-register', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/register/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
			$('#button-register').attr('disabled', 'disabled');
		},
        success: function(json) {
            $('.alert, .checkout__input-box-error').remove();
			$('.form-group textarea, .form-group input, .form-group .select, .checkout__captcha-box input').removeClass('error');
            $('.form-group').removeClass('has-error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-register').removeAttr('disabled');

                if (json['error']['warning']) {
					$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> ' + json['error']['warning'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
					alertClose();
                }

				for (i in json['error']) {
					var element = $('#input-payment-' + i.replace('_', '-'));
					
					
						
					if ($(element).parent().hasClass('select')) {
						$(element).next().after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).next().addClass('error');
					} else {
						$(element).after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).addClass('error');
					}
					
				}

				// Highlight any found errors
				$('.checkout__input-box-error').parent().addClass('has-error');
            } else {
                <?php if ($shipping_required == $shipping_required) { ?>
                var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').prop('value');
                var checkout_st3_sa = <?php echo $checkout_st3_sa; ?>;

                if (shipping_address || checkout_st3_sa) {
                    $.ajax({
                        url: 'index.php?route=checkout/shippay_method',
                        dataType: 'html',
						complete: function() {
							refreshmetods();
						},
                        success: function(html) {
							// Add the shipping address
                            $.ajax({
                                url: 'index.php?route=checkout/shipping_address',
                                dataType: 'html',
								complete: function() {
		                            setTimeout(function(){
		                            	$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');
		                            },1000);
		                        },
                                success: function(html) {
                                    $('#collapse-shipping-address').html(html);

									$('#collapse-shipping-address').parent().addClass('pass');
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });

							$('#collapse-shipping-method').html(html);

							$('#collapse-shipping-method').parent().addClass('pass');

							$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');

							$('#collapse-shipping-method').parent().find('.checkout__title h3').html('<?php echo $text_lightshop_checkout_s4; ?>');
							$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
							$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
							svgFix();
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                } else {
                    $.ajax({
                        url: 'index.php?route=checkout/shipping_address',
                        dataType: 'html',
 						complete: function() {
                            setTimeout(function(){
                            	$('#collapse-shipping-address').parent().find('.checkout__title').trigger('click');
                            },300);
                        },                       
                        success: function(html) {
                            $('#collapse-shipping-address').html(html);

							$('#collapse-shipping-address').parent().addClass('pass');

							$('#collapse-shipping-address').parent().find('.checkout__title').trigger('click');

							$('#collapse-shipping-method').parent().find('.checkout__title h3').html('<?php echo $text_lightshop_checkout_s4; ?>');
							$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
							$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
							svgFix();
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                }
                <?php } else { ?>
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-method').html(html);

						$('#collapse-payment-method').parent().addClass('pass');

						$('#collapse-payment-method').parent().find('.checkout__title').trigger('click');

						$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
						svgFix();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
                <?php } ?>

                $.ajax({
                    url: 'index.php?route=checkout/payment_address',
                    dataType: 'html',
                    complete: function() {
                        $('#button-register').removeAttr('disabled');
                    },
                    success: function(html) {
                        $('#collapse-payment-address').html(html);

						$('#collapse-payment-address').parent().addClass('pass');
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$(document).delegate('#button-register-b', 'click', function(e) {
	e.preventDefault();
	$('#collapse-checkout-option').parent().find('.checkout__title').trigger('click');	
});

// Payment Address
$(document).delegate('#button-payment-address', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/payment_address/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-payment-address').attr('disabled', 'disabled');
		},
        complete: function() {
			$('#button-payment-address').removeAttr('disabled');
        },
        success: function(json) {
            $('.alert, .checkout__input-box-error').remove();
			$('.form-group textarea, .form-group input, .form-group .select, .checkout__captcha-box input').removeClass('error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                if (json['error']['warning']) {
					$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> ' + json['error']['warning'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
					alertClose();
                }

				for (i in json['error']) {
					var element = $('#input-payment-' + i.replace('_', '-'));

					
						
					if ($(element).parent().hasClass('select')) {
						$(element).next().after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).next().addClass('error');
					} else {
						$(element).after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).addClass('error');
					}
				}

				// Highlight any found errors
				$('.checkout__input-box-error').parent().parent().addClass('has-error');
            } else {
                <?php if ($shipping_required) { ?>
                $.ajax({
                    url: 'index.php?route=checkout/shipping_address',
                    dataType: 'html',
 					complete: function() {
                        setTimeout(function(){
                             $('#collapse-shipping-address').parent().find('.checkout__title').trigger('click');
                        },300);
                    },
                    success: function(html) {
                        $('#collapse-shipping-address').html(html);

						$('#collapse-shipping-address').parent().addClass('pass');

						$('#collapse-shipping-address').parent().find('.checkout__title').trigger('click');	

						$('#collapse-shipping-method').parent().find('.checkout__title h3').html('<?php echo $text_lightshop_checkout_s4; ?>');
						$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
						$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
						svgFix();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
                <?php } else { ?>
		                $.ajax({
		                    url: 'index.php?route=checkout/shippay_method',
		                    dataType: 'html',
		                    complete: function() {
		                        $('#button-shipping-address').removeAttr('disabled');
								refreshmetods();
		                            setTimeout(function(){
		                            	$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');
		                            },1000);

		                    },
		                    success: function(html) {
		                        $('#collapse-shipping-method').html(html);

								$('#collapse-shipping-method').parent().addClass('pass');

//								$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');	

								$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
								$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');

								svgFix();

		                    },
		                    error: function(xhr, ajaxOptions, thrownError) {
		                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		                    }
		                });
                <?php } ?>
                <?php if ($checkout_st3_sa) { ?>
		                $.ajax({
		                    url: 'index.php?route=checkout/shippay_method',
		                    dataType: 'html',
		                    complete: function() {
		                        $('#button-shipping-address').removeAttr('disabled');
								refreshmetods();
		                            setTimeout(function(){
		                            	$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');
		                            },1000);

		                    },
		                    success: function(html) {
		                        $('#collapse-shipping-method').html(html);

								$('#collapse-shipping-method').parent().addClass('pass');

//								$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');	

								$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
								$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');

								svgFix();

		                    },
		                    error: function(xhr, ajaxOptions, thrownError) {
		                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		                    }
		                });
		         <?php }else{ ?>
		                $.ajax({
		                    url: 'index.php?route=checkout/payment_address',
		                    dataType: 'html',
		                    success: function(html) {
		                        $('#collapse-payment-address').html(html);
		                    },
		                    error: function(xhr, ajaxOptions, thrownError) {
		                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		                    }
		                });
		         <?php } ?>
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

// Shipping Address
$(document).delegate('#button-shipping-address', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/shipping_address/save',
        type: 'post',
        data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select'),
        dataType: 'json',
        beforeSend: function() {
			$('#button-shipping-address').attr('disabled', 'disabled');
	    },
        success: function(json) {
            $('.alert, .checkout__input-box-error').remove();
			$('.form-group textarea, .form-group input, .form-group .select, .checkout__captcha-box input').removeClass('error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-shipping-address').removeAttr('disabled');

                if (json['error']['warning']) {
					$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> ' + json['error']['warning'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
					alertClose();
                }

				for (i in json['error']) {
					var element = $('#input-shipping-' + i.replace('_', '-'));

					
						
					if ($(element).parent().hasClass('select')) {
						$(element).next().after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).next().addClass('error');
					} else {
						$(element).after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).addClass('error');
					}
					
				}

				// Highlight any found errors
				$('.checkout__input-box-error').parent().parent().addClass('has-error');
            } else {

                $.ajax({
                    url: 'index.php?route=checkout/shippay_method',
                    dataType: 'html',
                    complete: function() {
                        $('#button-shipping-address').removeAttr('disabled');
						refreshmetods();
                            setTimeout(function(){
                            	$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');
                            },1000);

                    },
                    success: function(html) {
                        $('#collapse-shipping-method').html(html);

						$('#collapse-shipping-method').parent().addClass('pass');

						$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');	

						$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
						$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
/*
                        $.ajax({
                            url: 'index.php?route=checkout/shipping_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-shipping-address').html(html);
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
 */
						svgFix();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });

                $.ajax({
                    url: 'index.php?route=checkout/payment_address',
                    dataType: 'html',
                    success: function(html) {
                        $('#collapse-payment-address').html(html);
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
				

            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$(document).delegate('#button-shipping-address-b', 'click', function(e) {
	e.preventDefault();
	$('#collapse-payment-address').parent().find('.checkout__title').trigger('click');	
});

function refreshcart() {
    $('#custcart').load('index.php?route=common/cart&custcart=1');
}

function refreshmetods() {
    $.ajax({
        url: 'index.php?route=checkout/shippay_method/refreshmetods',
        type: 'post',
        data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method input[type=\'checkbox\']:checked,#collapse-shipping-method textarea'),
        dataType: 'json',
        beforeSend: function() {
 //        	$('#button-payment-method').attr('disabled', 'disabled');
		},
        complete: function() {
			refreshcart();


				$.ajax({
					 url: 'index.php?route=checkout/confirm',
					 dataType: 'html',
						success: function(html) {
						   $.ajax({
								url: 'index.php?route=checkout/shippay_method',
								dataType: 'html',
								complete: function() {
									$('#button-shipping-address').removeAttr('disabled');
								},
								success: function(html) {
									$('#collapse-shipping-method').html(html);

									$('#collapse-shipping-method').parent().addClass('pass');

//									$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');	

									$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
									$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');

									svgFix();
								},
								error: function(xhr, ajaxOptions, thrownError) {
									alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
								}
							});
						},
						error: function(xhr, ajaxOptions, thrownError) {
						 alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
					}
				 });	

        },
        success: function(json) {
	
        },
    });

};
$(document).delegate('#collapse-shipping-method input[type=\'radio\']', 'click', function() {
	refreshmetods();
});
$(document).delegate('#collapse-shipping-method textarea', 'change', function() {
	refreshmetods();
});

$(document).delegate('#button-confirm1','click', function(e) {alert('334');
	e.preventDefault();
	if($("#agree").prop("checked") == false){
		$('.alerts').empty();
		$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> <?php echo $error_agree; ?> </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
		alertClose();
		return;
	}	

});

$.fn.bindFirst = function(name, fn) {
  var elem, handlers, i, _len;
  this.bind(name, fn);
  for (i = 0, _len = this.length; i < _len; i++) {
    elem = this[i];
    handlers = jQuery._data(elem).events[name.split('.')[0]];
    handlers.unshift(handlers.pop());
  }
};

// Guest
$(document).delegate('#button-guest', 'click', function() { 
    $.ajax({
        url: 'index.php?route=checkout/guest/save',
        type: 'post',
        data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select'),
        dataType: 'json',
        beforeSend: function() {
       		$('#button-guest').attr('disabled', 'disabled');
	    },
        success: function(json) {
            $('.alert, .checkout__input-box-error').remove();
			$('.form-group textarea, .form-group input, .form-group .select, .checkout__captcha-box input').removeClass('error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-guest').removeAttr('disabled');

                if (json['error']['warning']) {
					$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> ' + json['error']['warning'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
					alertClose();
                }

				for (i in json['error']) {
					var element = $('#input-payment-' + i.replace('_', '-'));

					
						
					if ($(element).parent().hasClass('select')) {
						$(element).next().after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).next().addClass('error');
					} else {
						$(element).after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).addClass('error');
					}
				}

				// Highlight any found errors
				$('.checkout__input-box-error').parent().addClass('has-error');
            } else {
                <?php if (1) { ?>
                var shipping_address = $('#collapse-payment-address input[name=\'shipping_address\']:checked').prop('value');
                var shipping_required = "<?php  echo $shipping_required; ?>";
                if (shipping_address || !shipping_required) {
                    $.ajax({
                        url: 'index.php?route=checkout/shippay_method',//lightshop change this
                        dataType: 'html',
                        complete: function() {
                            $('#button-guest').removeAttr('disabled');
							refreshmetods();
                        },
                        success: function(html) {
							// Add the shipping address
                            $.ajax({
                                url: 'index.php?route=checkout/guest_shipping',
                                dataType: 'html',
                                success: function(html) {
                                    $('#collapse-shipping-address').html(html);

									$('#collapse-shipping-address').parent().addClass('pass');
                                },
                                error: function(xhr, ajaxOptions, thrownError) {
                                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                                }
                            });

						    $('#collapse-shipping-method').html(html);

							$('#collapse-shipping-method').parent().addClass('pass');
							
							
							setTimeout(function(){
		                        $('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');
		                    },300);	

							$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
							$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
							svgFix();
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                } else {
                    $.ajax({
                        url: 'index.php?route=checkout/guest_shipping',
                        dataType: 'html',
                        complete: function() {
                            $('#button-guest').removeAttr('disabled');
                            setTimeout(function(){
                            	$('#collapse-shipping-address').parent().find('.checkout__title').trigger('click');
                            },300);
                        },
                        success: function(html) {
                            $('#collapse-shipping-address').html(html);
							
							$('#collapse-shipping-address').parent().addClass('pass');
							
							$('#collapse-shipping-address').parent().find('.checkout__title').trigger('click');	

							$('#collapse-shipping-method').parent().find('.checkout__title h3').html('<?php echo $text_lightshop_checkout_s4; ?>');
							$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
							$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
							svgFix();
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                }
                <?php } else { ?>
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    complete: function() {
                        $('#button-guest').removeAttr('disabled');
                    },
                    success: function(html) {
                        $('#collapse-shipping-method').html(html);
						
						$('#collapse-shipping-method').parent().addClass('pass');

						$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');	

						$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
						svgFix();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
                <?php } ?>
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$(document).delegate('#button-guest-b', 'click', function(e) {
	e.preventDefault();
	$('#collapse-checkout-option').parent().find('.checkout__title').trigger('click');	
});

// Guest Shipping
$(document).delegate('#button-guest-shipping', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/guest_shipping/save',
        type: 'post',
        data: $('#collapse-shipping-address input[type=\'text\'], #collapse-shipping-address input[type=\'date\'], #collapse-shipping-address input[type=\'datetime-local\'], #collapse-shipping-address input[type=\'time\'], #collapse-shipping-address input[type=\'password\'], #collapse-shipping-address input[type=\'checkbox\']:checked, #collapse-shipping-address input[type=\'radio\']:checked, #collapse-shipping-address textarea, #collapse-shipping-address select'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-guest-shipping').attr('disabled', 'disabled');
		},
        success: function(json) {
            $('.alert, .checkout__input-box-error').remove();
			$('.form-group textarea, .form-group input, .form-group .select, .checkout__captcha-box input').removeClass('error');

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-guest-shipping').removeAttr('disabled');
                if (json['error']['warning']) {
					$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> ' + json['error']['warning'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
					alertClose();
                }

				for (i in json['error']) {
					var element = $('#input-shipping-' + i.replace('_', '-'));

					
						
					if ($(element).parent().hasClass('select')) {
						$(element).next().after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).next().addClass('error');
					} else {
						$(element).after('<div class="checkout__input-box-error">' + json['error'][i] + '</div>');
						$(element).addClass('error');
					}
				}

				// Highlight any found errors
				$('.checkout__input-box-error').parent().addClass('has-error');
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/shippay_method',
                    dataType: 'html',
                    complete: function() {
                        $('#button-guest-shipping').removeAttr('disabled');
                        setTimeout(function(){
                       		$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');
                        },1000);
                    },
                    success: function(html) {
                        $('#collapse-shipping-method').html(html);

						$('#collapse-shipping-method').parent().addClass('pass');

						$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');	

						$('#collapse-payment-method').parent().find('.checkout__title h3').html('<?php echo $text_checkout_payment_method; ?>');
						$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
						svgFix();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$(document).delegate('#button-guest-shipping-b', 'click', function(e) {
	e.preventDefault();
	$('#collapse-payment-address').parent().find('.checkout__title').trigger('click');	
});

$(document).delegate('#button-shipping-method', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/shipping_method/save',
        type: 'post',
        data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method textarea'),
        dataType: 'json',
        beforeSend: function() {
        	$('#button-shipping-method').attr('disabled', 'disabled');
		},
        success: function(json) {
            $('.alert, .checkout__input-box-error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-shipping-method').removeAttr('disabled');

                if (json['error']['warning']) {
					$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> ' + json['error']['warning'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
					alertClose();
                }
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/payment_method',
                    dataType: 'html',
                    complete: function() {
                        $('#button-shipping-method').removeAttr('disabled');
                    },
                    success: function(html) {
                        $('#collapse-payment-method').html(html);
						
						$('#collapse-payment-method').parent().addClass('pass');

						$('#collapse-payment-method').parent().find('.checkout__title').trigger('click');	

						$('#collapse-checkout-confirm').parent().find('.checkout__title h3').html('<?php echo $text_checkout_confirm; ?>');
						svgFix();
                    },
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$(document).delegate('#button-shipping-method-b', 'click', function(e) {
	e.preventDefault();
	$('#collapse-shipping-address').parent().find('.checkout__title').trigger('click');	
});

$(document).delegate('#button-payment-method', 'click', function() {
    $.ajax({
        url: 'index.php?route=checkout/shippay_method/save',//lightshop change this
        type: 'post',
        data: $('#collapse-shipping-method input[type=\'radio\']:checked, #collapse-shipping-method input[type=\'checkbox\']:checked,#collapse-shipping-method textarea'),
        dataType: 'json',
        beforeSend: function() {
         	$('#button-payment-method').attr('disabled', 'disabled');
		},
        complete: function() {
			refreshcart();
        },
        success: function(json) {
            $('.alert, .checkout__input-box-error').remove();

            if (json['redirect']) {
                location = json['redirect'];
            } else if (json['error']) {
                $('#button-payment-method').removeAttr('disabled');

                if (json['error']['warning']) {
					$('.alerts').append($('<div class="alert alert--red"><span class="alert__text"> ' + json['error']['warning'] + ' </span><a href="#" class="alert__close">x</a></div>').hide().fadeIn(500));
					alertClose();
                }
            } else {
                $.ajax({
                    url: 'index.php?route=checkout/confirm',
                    dataType: 'html',
                    complete: function() {
                        $('#button-payment-method').removeAttr('disabled');
                    },
                    success: function(html) {
                        $('#collapse-checkout-confirm').html(html);

						$('#collapse-checkout-confirm').parent().addClass('pass');

						$('#collapse-checkout-confirm').parent().find('.checkout__title').trigger('click');	
						svgFix();
					},
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                    }
                });
            }
        },
        error: function(xhr, ajaxOptions, thrownError) {
            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
    });
});

$(document).delegate('#button-payment-method-b', 'click', function(e) {
	e.preventDefault();
	$('#collapse-shipping-method').parent().find('.checkout__title').trigger('click');	
});
//--></script>
</body></html>

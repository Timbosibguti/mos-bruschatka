</div><!-- FOOTER FIX [END] -->

<!-- BEGIN ROISTAT -->
<script>
	(function(w, d, s, h, id) {
		w.roistatProjectId = id; w.roistatHost = h;
		var p = d.location.protocol == "https:" ? "https://" : "http://";
		var u = /^.*roistat_visit=[^;]+(.*)?$/.test(d.cookie) ? "/dist/module.js" : "/api/site/1.0/"+id+"/init";
		var js = d.createElement(s); js.charset="UTF-8"; js.async = 1; js.src = p+h+u; var js2 = d.getElementsByTagName(s)[0]; js2.parentNode.insertBefore(js, js2);
	})(window, document, 'script', 'cloud.roistat.com', '2eddbbf2f2e2a8cd7b11edbc44e38d1c');
</script>
<!-- END ROISTAT -->

<!-- FOOTER -->

            <?php if (isset($yandex_money_metrika_active) && $yandex_money_metrika_active){ ?>
                <?php echo $yandex_metrika; ?>
                <script type="text/javascript">
                    window.dataLayer = window.dataLayer || [];
                    function sendEcommerceAdd(id, quantity) {
                       $.ajax({
                            url: "<?= $yandex_money_product_info_url; ?>",
                            type: 'post',
                            data: 'id=' + id,
                            dataType: 'json',
                            success: function(json) {
                                json.quantity = quantity;
                                dataLayer.push({ecommerce: {add: {products: [json]}}});
                            }
                        });
                    }
                    $(window).on("load", function () {
                        var opencartCartAdd = cart.add;
                        cart.add = function (product_id, quantity) {
                            opencartCartAdd(product_id, quantity);
                            sendEcommerceAdd(product_id, typeof(quantity) !== 'undefined' ? parseInt(quantity) : 1);
                        };
                        $('#button-cart').on('click', function() {
                            sendEcommerceAdd($('#product input[name="product_id"]').val(), parseInt($('#product input[name="quantity"]').val()));
                        });
                    });
                </script>
            <?php } ?>
	<footer class="section footer js-footer" id="footer">
		<div class="container">
			<div class="row no-gutters">
				<div class="row col-12 col-lg-8 offset-lg-1 order-lg-2">
				<?php  foreach ($footer_navs as $key => $footer_nav) { ?>
					<div class="col-12  col-md-3 col-sm-6">
						<?php if($footer_nav['language'][$language_id]['name']) { ?>
						<span class="footer__list-title footer__list-header">
							<?php echo $footer_nav['language'][$language_id]['name']  ?>
						</span>	
						<?php } ?>					   

						<?php if ($footer_nav['settype']) { ?>
							<div><?php echo html_entity_decode($footer_nav['type'][$footer_nav['settype']]['links']['html']); ?></div>
						<?php } else { ?>
						<ul class="footer__list">
							<?php  foreach ($footer_nav['type'][$footer_nav['settype']]['links'] as $id => $link) { ?>
								<li class="footer__list-item"><a href="<?php echo $link; ?>" class="footer__link" <?php if(isset($top_links[$id]['target'])){ ?>target="<?php echo $top_links[$id]['target']; ?>" <?php } ?>><?php echo isset($top_links[$id]) ? key($top_links[$id]) : ''; ?></a></li>
							<?php } ?>						   
						</ul>
					<?php } ?>
					</div>
				<?php } ?>				
				</div>
				<div class="col-12 col-lg-2">					
					<?php if ($footer_t_logo || $footer_logo) { ?>
					<span class="footer__logo">
						<?php if ($footer_logo) { ?>
						<a href="<?php echo $home; ?>" class="footer__logo-link" >
							<img src="<?php echo $footer_logo; ?>" alt="" />
						</a>
						<?php } else { ?>
						<a href="<?php echo $home; ?>" class="footer__logo-link"><?php echo $text_logo; ?></a>
						<?php } ?>
					</span>
					<?php } ?>
					<span class="copyright">
						<?php echo $footer_copyright; ?>
					</span>
					<p style="font-size: 10px; line-height: 1; margin-top: 8px;">
						<a href="/offers" target="_blank">Сайт носит исключительно информационный характер и не является публичной офертой.</a>
					</p>
					<p style ="font-size: 11px; font-weight: normal; line-height: 1; margin-top: 17px; text-decoration: underline">
						<a href ="/privacy" target="_blank">Политика конфиденциальности</a>
					</p>
					<span class="footer__info-text">
						<?php  if($soc_stat) { ?>
						<?php  if(isset($social_navs)) { ?>
						<div class="soc__lists-item">
							<span class="footer__list-title">
								<?php echo $footer_text; ?>
							</span>
							<?php  foreach ($social_navs as $key => $social_nav) { ?>
							<a href="<?php echo $social_nav['link']; ?>" target="_blank" class="footer__link-icon icon-social-<?php echo strtolower($social_links[$social_nav['settype']]); ?>" rel="nofollow"></a>
							<?php } ?>
						</div>
						<?php } ?>
					<?php } ?>
					</span>
				</div>
			</div>
		</div>
	</footer>
	
	<?php if ($scroll_to_top) { ?>
		<a href="#" class="scroll-to-top js-stt" style="<?php echo $scroll_to_top_pos; ?>: 50px;">&#x2191;</a>
	<?php } ?>

	<!-- BEGIN JIVOSITE INTEGRATION WITH ROISTAT -->
	<script defer>(function(w, d, s, h){var p=d.location.protocol=="https:" ? "https://" : "http://";var u="/static/marketplace/JivoSite/script.js";var js=d.createElement(s); js.async=1; js.src=p+h+u; var js2=d.getElementsByTagName(s)[0]; js2.parentNode.insertBefore(js, js2);})(window, document, 'script', 'cloud.roistat.com');</script>
	<!-- END JIVOSITE INTEGRATION WITH ROISTAT -->

	<script src="https://moclients.com/js/2466.js"></script>

	<script src="https://www.youtube.com/iframe_api"></script>

	<script>
		let $youtube = $(".js-youtube");
		let players = [];

		$youtube.each(function() {
			players.push($(this).attr('id'));
		});

		function onYouTubeIframeAPIReady() {
			$youtube.on('click', function() {
				console.log('youtube');
				players[$(this).attr('id')] = new YT.Player($(this).attr('id'), {
					height: '360',
					width: '640',
					videoId: $(this).data('embed')
				});
			});
		}
	</script>

	<script type="text/javascript">!function(){var t=document.createElement("script");t.type="text/javascript",t.async=!0,t.src="https://vk.com/js/api/openapi.js?160",t.onload=function(){VK.Retargeting.Init("VK-RTRG-370429-33K6q"),VK.Retargeting.Hit()},document.head.appendChild(t)}();</script><noscript><img src="https://vk.com/rtrg?p=VK-RTRG-370429-33K6q" style="position:fixed; left:-999px;" alt=""/></noscript>
